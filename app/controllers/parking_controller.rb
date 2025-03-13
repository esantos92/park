class ParkingController < ApplicationController
  def show
    registers = Car.where(plate: params[:plate])

    render json: { message: 'Carro sem registros' }, status: :ok and return if registers.empty?

    body =[]
    registers.each do |register|
      payload = {
        id: register.id,
        time: time_lapsed(register),
        paid: register.payments.paid.present?,
        left: register.checkouted?
      }

      body << payload
    end

    render json: body, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Carro não encontrado' }, status: :not_found
  end

  def create
    Cars::Register.call(car_params[:plate])

    render json: { message: 'Carro registrado' }

  rescue ArgumentError => e
    render json: { message: e.message }, status: :bad_request
  end

  def pay
    car = Car.find(params[:id])

    if car.payments.paid.present?
      render json: { message: 'O pagamento deste carro já foi registrado' }, status: :unprocessable_entity and return
    end

    payment = car.payments.pending.last

    payment.pay! if payment.may_pay?

    if payment.paid?
      render json: { message: 'Pagamento efetuado' }
    else
      render json: { message: 'Falha ao efetuar pagamento' }, status: :bad_request
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Carro não encontrado' }, status: :not_found
  rescue => e
    render json: { message: e.message }, status: :bad_request
  end

  def out
    car = Car.find(params[:id])

    if car.checkouted?
      render json: { message: 'A saída deste carro já foi registrada' }, status: :unprocessable_entity and return
    end

    Cars::Checkout.call(car)

    render json: { message: 'Carro liberado' }
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Carro não encontrado' }, status: :not_found
  rescue ArgumentError => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private
  def car_params
    params.permit(:plate)
  end

  def time_lapsed(car)
    minutes = car.checkouted? ? car.check_out - car.created_at : Time.zone.now - car.created_at
    "#{minutes.ceil / 60} minutos"
  end
end
