defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @earth_orbit_period 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / orbit_period(planet)
  end

  defp orbit_period(planet) do
    case planet do
      :earth   -> @earth_orbit_period
      :mercury -> @earth_orbit_period * 0.2408467
      :venus   -> @earth_orbit_period * 0.61519726
      :mars    -> @earth_orbit_period * 1.8808158
      :jupiter -> @earth_orbit_period * 11.862615
      :saturn  -> @earth_orbit_period * 29.447498
      :uranus  -> @earth_orbit_period * 84.016846
      :neptune -> @earth_orbit_period * 164.79132
    end
  end
end
