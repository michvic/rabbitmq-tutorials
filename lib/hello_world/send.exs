# send
{:ok, connection} = AMQP.Connection.open("amqp://guest:guest@localhost")
{:ok, channel} = AMQP.Channel.open(connection)

AMQP.Queue.declare(channel, "hello")

AMQP.Basic.publish(channel, "", "hello", "Hello World!")
IO.puts(" [x] Sent 'Hello World!'")

AMQP.Connection.close(connection)
