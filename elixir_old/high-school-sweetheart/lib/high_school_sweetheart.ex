defmodule HighSchoolSweetheart do

  def first_letter(name) do
    name
      |> String.replace("\n", "")
      |> String.replace("\t", "")
      |> String.replace(" ", "")
      |> String.first()
  end

  def initial(name) do
    uppercased_first_letter = name |> first_letter() |> :string.uppercase()
    "#{uppercased_first_letter}."
  end

  def initials(full_name) do
    full_name
      |> :string.split(" ")
      |> Enum.map(&initial/1)
      |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    first_name_initials = initials(full_name1)
    second_name_initials = initials(full_name2)
    ~s"""
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{first_name_initials}  +  #{second_name_initials}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
