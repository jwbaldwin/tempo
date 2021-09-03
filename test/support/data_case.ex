defmodule Mmentum.DataCase do
  # credo:disable-for-this-file

  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use Mmentum.DataCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Mmentum.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Mmentum.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Mmentum.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Mmentum.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end

  @doc """
  Reverse a preload.
  ## Example
      site = Repo.get!(Site, 1) |> Repo.preload(:user)
      Repo.forget(site, :user)
  ## References
  + https://stackoverflow.com/a/52323877
  + https://stackoverflow.com/a/49997873
  + https://github.com/thoughtbot/ex_machina/issues/295#issuecomment-433264227
  """
  def unload_all(struct) do
    associations = resolve_associations(struct)
    unload(struct, associations)
  end

  def unload(struct, associations) when is_list(associations) do
    associations
    |> Enum.reduce(struct, fn association, struct ->
      unload(struct, association)
    end)
  end

  def unload(structs, association) when is_list(structs) do
    Enum.map(structs, fn struct ->
      unload(struct, association)
    end)
  end

  def unload(struct, association) do
    %{
      struct
      | association => build_not_loaded(struct, association)
    }
  end

  defp resolve_associations(%{__struct__: schema}) do
    schema.__schema__(:associations)
  end

  defp build_not_loaded(%{__struct__: schema}, association) do
    %{
      cardinality: cardinality,
      field: field,
      owner: owner
    } = schema.__schema__(:association, association)

    %Ecto.Association.NotLoaded{
      __cardinality__: cardinality,
      __field__: field,
      __owner__: owner
    }
  end
end
