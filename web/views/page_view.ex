defmodule Vanpool.PageView do
  use Vanpool.Web, :view

  def riding_state(ridings, van) do
    ridings =  Enum.filter(ridings, fn r -> r.vanid == van.id end)
    if length(ridings) > 1 do
      "roundtrip"
    else if List.first(ridings).dir == "in"  do
      "morning"
    else
      "afternoon"
    end
    end
  end
end
