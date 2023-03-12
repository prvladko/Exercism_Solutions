defmodule HighSchoolSweetheart do
  def first_letter(name) do
    # Please implement the first_letter/1 function
    #String.first(String.trim("#{name}"))
    name
    |> String.trim()
    |> String.first()
  end

  def initial(name) do
    # Please implement the initial/1 function
    first_letter(name)
    |> String.upcase()
    |> Kernel.<> "."
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    [n | s] = String.split(full_name)
    initial(n) <> " " <> initial(Enum.at(s, 0))
  end

  def pair(full_name1, full_name2) do
    pairin = initials(full_name1) <> "  +  " <> initials(full_name2)

"     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n**     #{pairin}     **\n **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
  end
end
