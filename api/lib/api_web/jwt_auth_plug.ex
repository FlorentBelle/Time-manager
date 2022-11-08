defmodule ApiWeb.JWTAuthPlug do

  import Plug.Conn
  import Ecto.Query

  alias Api.Repo
  alias Api.User
  alias Api.AuthTokens

  def init(opts), do: opts

  def call(conn, _) do
    bearer = get_req_header(conn, "authorization") |> List.first()
    if(bearer == nil) do
      conn |> put_status(401)
    else
      token = bearer |> String.split(" ") |> List.last()
      signer = Joken.Signer.create("HS256", "tpGhg0MXdCE82vGgKMIgj0R3jEU7Os9VDzfu6qYhyie6Hh3mpwoUgJ9faWVdYNs3")

      if(token == nil) do
        conn |> put_status(401)
      else
        with {:ok, %{ "user_id" => user_id }} <- ApiWeb.JWTToken.verify_and_validate(token, signer) do
          user = Repo.get(User, user_id)
          if(user == nil) do
            conn |> put_status(401)
          else
            if(Repo.exists?(from at in AuthTokens, where: at.token == ^token)) do
              conn |> put_status(401)
            else
              conn |> assign(:current_user, user)
            end
          end
        else
          {:error, _whatever_reason} -> conn |> put_status(401)
          _ -> conn |> put_status(401)
        end
      end
    end
  end



end
