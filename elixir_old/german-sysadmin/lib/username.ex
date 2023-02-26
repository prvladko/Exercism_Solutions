defmodule Username do
  def sanitize([]), do: []

  def sanitize([h | t]) do
    case h do
      h when h in ?a..?z or h == ?_ -> [h | sanitize(t)]
      h when h == ?ä -> [?a, ?e | sanitize(t)]
      h when h == ?ö -> [?o, ?e | sanitize(t)]
      h when h == ?ü -> [?u, ?e | sanitize(t)]
      h when h == ?ß -> [?s, ?s | sanitize(t)]
      _ -> sanitize(t)
    end
  end
end
