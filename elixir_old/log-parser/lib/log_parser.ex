defmodule LogParser do

  @valid_prefixes ~w[DEBUG INFO WARNING ERROR]

  def valid_line?(line) do
    valid_prefixes = Enum.join(@valid_prefixes, "|")
    line =~ ~r/^\[(#{valid_prefixes})\]/
  end

  def split_line(line) do
    Regex.split(~r/\<[\*|\-|\~|\=]*\>/, line)
  end

  def remove_artifacts(line) do
    ~r/end-of-line\d+/i
    |> Regex.split(line)
    |> Enum.join()
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(?<username>\S+)/u, line) do
      [_, username] -> "[USER] #{username} #{line}"
      _ -> line
    end
  end
end
