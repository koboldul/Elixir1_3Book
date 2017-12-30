defmodule FileR do
  
  def read(file_name) do
    Stream.resource(fn -> File.open!(file_name) end,
                  fn file -> 
                    case IO.read(file, :line) do
                      data when is_binary(data) -> {[data], file}
                      _-> {:halt, file}
                    end
                  end,
                  fn file -> File.close(file) end)
  end
end
