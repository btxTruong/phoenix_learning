defmodule PhoenixChat.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :encrypted_password, :string, redact: true
    field :username, :string
    field :password, :string, virtual: true, redact: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username])
    |> validate_required([:email, :username])
    |> validate_length(:username, min: 1, max: 20)
    |> update_change(:email, &String.downcase/1)
    |> validate_email(attrs)
    |> update_change(:username, &String.downcase/1)
    |> validate_password(hash_password: false)
  end

#   The primary reason for separate changeset is so we can validate and hash passwords only when necessary.
# Password hashing is an expensive operation in which a complex algorithm is used to convert our password
# into a non-reversible random string of characters and numbers.
  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_email(opts)
    |> validate_password(opts)
  end

  defp validate_email(changeset, opts) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> maybe_validate_unique_email(opts)
  end

  defp maybe_validate_unique_email(changeset, opts) do
    if Keyword.get(opts, :validate_email, true) do
      changeset
      |> unsafe_validate_unique(:email, BookStore.Repo)
      |> unique_constraint(:email)
    else
      changeset
    end
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72)
      # Examples of additional password validation:
      # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
      # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
      # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

    defp maybe_hash_password(changeset, opts) do
      hash_password? = Keyword.get(opts, :hash_password, true)
      password = get_change(changeset, :password)

      if hash_password? && password && changeset.valid? do
        changeset
        # If using Bcrypt, then further validate it is at most 72 bytes long
        |> validate_length(:password, max: 72, count: :bytes)
          # Hashing could be done with `Ecto.Changeset.prepare_changes/2`, but that
          # would keep the database transaction open longer and hurt performance.
        |> put_change(:encrypted_password, Bcrypt.hash_pwd_salt(password)) # put_change add a row to the changeset
        |> delete_change(:password)
      else
        changeset
      end
    end
end
