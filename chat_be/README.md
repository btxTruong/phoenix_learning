# PhoenixChat

## Initial Setup
- Start project `mix phx.new chat_be --module PhoenixChat --app phoenix_chat --no-html --no-gettext --no--assets`
- Create auth: `mix phx.gen.json Accounts User users email:string encrypted_password:string username:string`
- Add index in `create_users` migration:

```elixir
 create unique_index(:users, [:email])
 create unique_index(:users, [:username])
```

- Add `bcrypt_elixir` to `mix.exs` and run`mix deps.get`

```elixir
{:bcrypt_elixir, "~> 3.0"}
```

- Add port in `config/dev.exs` to `7432` and run migrate `mix ecto.setup`

## To start your Phoenix server

- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
 Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Dev change
### Sign-up
- Add new changeset for registration in `lib/accounts/user.ex`

  The primary reason for separate changeset is so we can validate and hash passwords only when necessary
```elixir
def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_email(opts)
    |> validate_password(opts)
  end
```

- Because we use repo arch, so we will update `lib/accounts.ex` to implement db call module. Another module will call this module to interact with db

### CORS
- Add `{:corsica, "~> 1.0"}` to `mix.exs` and run `mix deps.get`
- Add `plug Corsica, allow_headers: ~w(Accept Content-Type Authorization)` in `lib/chat_be/endpoint.ex` before it hits our Router
