# send
{:ok, connection} = AMQP.Connection.open("amqp://guest:guest@localhost")
{:ok, channel} = AMQP.Channel.open(connection)

AMQP.Queue.declare(channel, "task_queue", durable: true)

message =
  case System.argv() do
    [] -> "Hello World!"
    words -> Enum.join(words, " ")
  end

AMQP.Basic.publish(channel, "", "task_queue", message, persistent: true)

IO.puts(" [x] Send '#{message}'")

AMQP.Connection.close(connection)
