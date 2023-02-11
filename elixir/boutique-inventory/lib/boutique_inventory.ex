defmodule BoutiqueInventory do

  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    has_no_price = fn item -> item[:price] == nil end
    Enum.filter(inventory, has_no_price)
  end

  def update_names(inventory, old_word, new_word) do
    change_word = fn name -> String.replace(name, old_word, new_word) end
    change_name = fn item -> Map.update!(item, :name, change_word) end
    Enum.map(inventory, change_name)
  end

  def increase_quantity(item, count) do
    new_quantities = Enum.into(item.quantity_by_size, %{}, fn {size, old} -> {size, old+count} end)
    %{item | quantity_by_size: new_quantities}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn x, acc -> acc+elem(x,1) end)
  end
end
