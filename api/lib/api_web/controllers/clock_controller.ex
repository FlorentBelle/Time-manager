defmodule ApiWeb.ClocksController do
  use ApiWeb, :controller

  alias Api.Clocks

  def create(conn, params) do
    case params |> Clocks.create_clock() do
      {:ok, %Clocks{} = _clock} -> conn |> render(ApiWeb.ClocksView, "create_clock.json", params: params)
      _ -> conn |> render(ApiWeb.ErrorView, "error.json", %{status: "500", error: "Interal Server Error"})
    end
  end

  def retrieve(conn, params) do
    clockId = String.to_integer(params["id"])
    conn |> render(ApiWeb.ClocksView, "get_clock.json", %{status: "200", success: true, message: "Clock found", content: Clocks.get_clock(clockId)})
  end

  def retrieve(conn, params) do
    conn |> render(ApiWeb.ErrorView, "error.json", %{status: "403", error: "No clock found"})
  end

end
