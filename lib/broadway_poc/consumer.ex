defmodule BroadwayPoc.Consumer do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producers: [
        default: [
          module: {BroadwayPoc.Producer, 1},
          transformer: {__MODULE__, :transform, []}
        ],
      ],
       processors: [
         default: [stages: 1]
      ]
      # batchers: [
      #   default: [stages: 2, batch_size: 5],
      # ]
    )
  end

  def transform(event, _opts) do
    %Message{
      data: event,
      acknowledger: {__MODULE__, :ack_id, :ack_data}
    } |> IO.inspect()
  end


  def ack(:ack_id, successful, failed) do
    :ok
  end

  def handle_message(:default, message, status) do
    IO.inspect(message)
    message
  end

end
