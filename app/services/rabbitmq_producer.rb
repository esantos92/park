require 'bunny'

class RabbitmqProducer
  def self.publish(queue, message)
    connection = Bunny.new(host: 'rabbitmq')
    connection.start

    channel = connection.create_channel
    queue = channel.queue(queue)

    channel.default_exchange.publish(message, routing_key: queue.name)
    connection.close
  end
end

