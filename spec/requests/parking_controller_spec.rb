require 'rails_helper'

RSpec.describe 'ParkingController', type: :request do
  shared_examples 'a car not found' do
    it 'returns not found' do
      request

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["message"]).to eq('Carro não encontrado')
    end
  end

  describe 'GET /parking/:plate' do
    let(:request) { get "/parking/#{plate}" }

    context 'when car has an enter register' do
      context 'when car has a pending payment' do
        let(:car) { create(:car, :with_payment) }
        let(:plate) { car.plate }

        let(:expected_response) do
          [
            {id: car.id, time: time_lapsed(car), paid: false, left: false}
          ]
        end

        it 'returns the expected response' do
          request

          expect(response).to have_http_status(:ok)
          expect(response.body).to eq(expected_response.to_json)
        end
      end

      context 'when car has a paid payment' do
        let(:car) { create(:car, :with_paid_payment) }
        let(:plate) { car.plate }

        let(:expected_response) do
          [
            {id: car.id, time: time_lapsed(car), paid: true, left: false}
          ]
        end

        it 'returns the expected response' do
          request

          expect(response).to have_http_status(:ok)
          expect(response.body).to eq(expected_response.to_json)
        end
      end
    end

    context 'when car outed' do
      let(:car) { create(:car, :checkouted) }
      let(:plate) { car.plate }

      let(:expected_response) do
        [
          {id: car.id, time: time_lapsed(car), paid: true, left: true}
        ]
      end

      it 'returns the expected response' do
        request

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(expected_response.to_json)
      end
    end

    context 'when car has not an enter register' do
      let(:plate) { 'CBA-1234' }

      it 'returns message' do
        request

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq('Carro sem registros')
      end
    end
  end

  describe 'POST /parking' do
    let(:plate) { 'CBA-1234' }
    let(:request) { post '/parking', params: { plate: plate } }

    it 'calls Cars::Register' do
      expect(Cars::Register).to receive(:call).with(plate)

      request
    end

    it 'creates a Car register' do
      expect { request }.to change(Car, :count).by(1)
      expect(Car.last.plate).to eq(plate)
    end

    context 'when there is an opened register for the plate' do
      let(:error_message) { 'This car has some enter opened registered' }

      before do
        allow(Cars::Register).to receive(:call).and_raise(ArgumentError, error_message)
      end

      it 'returns bad request' do
        request

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["message"]).to eq(error_message)
      end
    end
  end

  describe 'PUT /parking/:id/pay' do
    let(:car) { create(:car, :with_payment) }
    let(:id) { car.id }
    let(:request) { put "/parking/#{id}/pay" }

    context 'when car is entered' do
      context 'when car has a pending payment' do
        it 'updates the payment status' do
          expect { request }.to change { car.payments.last.status }.from('pending').to('paid')
        end
      end

      context 'when car has a paid payment' do
        before { car.payments.last.update!(status: 'paid') }

        it 'return unprocessable entity' do
          request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["message"]).to eq('O pagamento deste carro já foi registrado')
        end
      end

      context 'when does not have an entered car' do
        let(:id) { car.id + 1 }

        it_behaves_like 'a car not found'
      end

      context 'when an unexpected error occurs' do
        let(:error_message) { 'some error' }

        before do
          allow_any_instance_of(Payment).to receive(:pay!).and_raise(StandardError, error_message)
        end

        it 'returns bad request' do
          request

          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)["message"]).to eq(error_message)
        end
      end
    end
  end

  describe 'PUT /parking/:id/out' do
    let(:request) { put "/parking/#{id}/out" }

    context 'when car is entered' do
      context 'when car has a paid payment' do
        let(:car) { create(:car, :with_paid_payment) }
        let(:id) { car.id }

        it 'updates the car status' do
          expect { request }.to change { car.reload.status }.from('entered').to('checkouted')
          expect(response).to have_http_status(:ok)
        end

        it 'calls Cars::Checkout' do
          expect(Cars::Checkout).to receive(:call).with(car)

          request
        end
      end

      context 'when car has a pending payment' do
        let(:car) { create(:car, :with_payment) }
        let(:id) { car.id }

        it 'returns unprocessable entity' do
          request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["message"]).to eq('Carro não tem um pagamento pago')
        end
      end

      context 'when car just checkouted' do
        let(:car) { create(:car, :checkouted) }
        let(:id) { car.id }

        it 'returns unprocessable entity' do
          request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["message"]).to eq('A saída deste carro já foi registrada')
        end
      end
    end

    context 'when does not have an entered car' do
      let(:id) { 123 }

      it_behaves_like 'a car not found'
    end
  end

  def time_lapsed(car)
    minutes = car.checkouted? ? car.check_out - car.created_at : Time.zone.now - car.created_at
    "#{minutes.ceil / 60} minutos"
  end
end
