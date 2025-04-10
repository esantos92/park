require 'bunny'

class RabbitmqConsumer
  def self.consume(queue)
    connection = Bunny.new(host: 'rabbitmq')
    connection.start

    channel = connection.create_channel
    queue = channel.queue(queue)

    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      puts "Mensagem recebida: #{body}"
      # Processar a mensagem aqui
    end
  end
end