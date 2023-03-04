defmodule Rules do
  def eat_ghost?(power_pellet_active, touching_ghost) do
    power_pellet_active == true and touching_ghost == true
  end

  def score?(touching_power_pellet, touching_dot) do
    touching_power_pellet == true or touching_dot == true
  end

  def lose?(power_pellet_active, touching_ghost) do
    power_pellet_active == false and touching_ghost == true
  end

  def win?(has_eaten_all_dots, power_pellet_active, touching_ghost) do
    has_eaten_all_dots == true and lose?(power_pellet_active, touching_ghost) == false
  end
end
