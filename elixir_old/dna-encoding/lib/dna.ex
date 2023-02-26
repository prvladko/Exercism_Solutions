defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000
  def encode_nucleotide(_code_point), do: nil
  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T
  def decode_nucleotide(_encoded_code), do: nil
  def encode([]), do: <<>>

  def encode([first | rest]) do
    <<encode_nucleotide(first) :: 4, encode(rest) :: bitstring>>
  end

  def decode(<<>>), do: []

  def decode(<<first :: 4, rest :: bitstring>>) do
    [decode_nucleotide(first) | decode(rest)]
  end
end
