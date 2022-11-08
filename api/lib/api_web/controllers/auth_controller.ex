defmodule ApiWeb.AuthController do
  use ApiWeb, :controller

  import Ecto.Query
  import Plug.Conn

  alias Api.User
  alias Api.Clocks
  alias Api.AuthTokens
  alias Api.Repo
  alias ApiWeb.JWTToken

  def register(conn, %{ "email" => email, "username" => username, "password" => password }) do
    case %{ "email" => email, "username" => username, "password" => password, "role_id" => 1 } |> User.create_user() do
      {:ok, %User{} = user} ->
        newUser = %{ id: user.id, username: user.username, email: user.email, role_id: 1}
        user_id = user.id
        Repo.insert(%Clocks{user: user_id})
        conn |> render(ApiWeb.AuthView, "auth_view.json", %{status: 201, success: true, message: "User registered successfully", content: %{user: newUser, user_id: user_id}})
      _ ->
        if(Repo.exists?(from u in User, where: u.email == ^email)) do
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 409, error: "User already exists"})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 500, error: "Interal Server Error. Canno't create user"})
        end
    end
  end

  def login(conn, %{ "email" => email, "username" => username, "password" => password }) do
    if (email === nil || password === nil) do
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "Invalid credentials"})
    else
      user = Repo.one!(from u in User, join: r in "roles", on: r.id == u.role_id,  where: u.username >= ^username, where: u.email <= ^email, select: %{id: u.id, username: u.username,email: u.email, password: u.password, role_id: u.role_id, role_name: r.role_name, isAuthoriseAdmin: r.isAuthoriseAdmin, isAuthoriseManager: r.isAuthoriseManager })
      if(user !== nil) do
        isValidPassword = Pbkdf2.verify_pass(password, user.password)
        if(isValidPassword) do
          signer = Joken.Signer.create("HS256", "tpGhg0MXdCE82vGgKMIgj0R3jEU7Os9VDzfu6qYhyie6Hh3mpwoUgJ9faWVdYNs3")
          extra_claims = %{ user_id: user.id }
          {:ok, token, _claims} = JWTToken.generate_and_sign(extra_claims, signer)
          {:ok, _claims} = JWTToken.verify_and_validate(token, signer)
          user_without_password = %{ id: user.id, email: user.email, username: user.username, role_id: user.role_id, role_name: user.role_name, isAuthoriseAdmin: user.isAuthoriseAdmin, isAuthoriseManager: user.isAuthoriseManager }
          conn |> render(ApiWeb.AuthView, "login_view.json", %{status: 201, success: true, message: "Welcome back !", user: user_without_password, token: token })
        else
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "Invalid credentials"})
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "Invalid credentials"})
      end
    end
  end

  def get(conn, _params) do
    IO.inspect(conn)
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      conn |> render(ApiWeb.AuthView, "authentificated_user.json", %{status: 200, success: true, message: "User authorized", user: conn.assigns.current_user})
    end
  end

  def delete(conn, _params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      case Ecto.build_assoc(conn.assigns.current_user, :auth_tokens, %{token: get_token(conn)})
      |> Repo.insert!() do
        %AuthTokens{} ->  conn |> render("logout.json", %{status: 200, success: true, message: "Logged Out"})
        _ -> conn |> render(ApiWeb.ErrorView, "error.json", %{status: 500, error: "Interal Server Error. Canno't create user"})
      end
    end
  end

  defp get_token(conn) do
    bearer = get_req_header(conn, "authorization") |> List.first()
    if(bearer == nil) do
      ""
    else
      bearer |> String.split(" ") |> List.last()
    end
  end

end
