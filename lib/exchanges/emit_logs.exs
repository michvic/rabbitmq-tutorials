{:ok, connection} = AMQP.Connection.open("amqp://guest:guest@localhost")
{:ok, channel} = AMQP.Channel.open(connection)

message =
  case System.argv() do
    [] -> "Hello World!"
    words -> Enum.join(words, " ")
  end

AMQP.Exchange.declare(channel, "logs", :fanout)
AMQP.Basic.publish(channel, "logs", "", message)
IO.puts(" [x] Sent '#{message}'")

AMQP.Connection.close(connection)
