defmodule HackerNews.New do
  @moduledoc """
  The New context.
  """

  import Ecto.Query, warn: false
  alias HackerNews.Repo

  alias HackerNews.New.NewController

  @doc """
  Returns the list of newcontrollers.

  ## Examples

      iex> list_newcontrollers()
      [%NewController{}, ...]

  """
  def list_newcontrollers do
    Repo.all(NewController)
  end

  @doc """
  Gets a single new_controller.

  Raises `Ecto.NoResultsError` if the New controller does not exist.

  ## Examples

      iex> get_new_controller!(123)
      %NewController{}

      iex> get_new_controller!(456)
      ** (Ecto.NoResultsError)

  """
  def get_new_controller!(id), do: Repo.get!(NewController, id)

  @doc """
  Creates a new_controller.

  ## Examples

      iex> create_new_controller(%{field: value})
      {:ok, %NewController{}}

      iex> create_new_controller(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_new_controller(attrs \\ %{}) do
    %NewController{}
    |> NewController.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a new_controller.

  ## Examples

      iex> update_new_controller(new_controller, %{field: new_value})
      {:ok, %NewController{}}

      iex> update_new_controller(new_controller, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_new_controller(%NewController{} = new_controller, attrs) do
    new_controller
    |> NewController.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a new_controller.

  ## Examples

      iex> delete_new_controller(new_controller)
      {:ok, %NewController{}}

      iex> delete_new_controller(new_controller)
      {:error, %Ecto.Changeset{}}

  """
  def delete_new_controller(%NewController{} = new_controller) do
    Repo.delete(new_controller)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking new_controller changes.

  ## Examples

      iex> change_new_controller(new_controller)
      %Ecto.Changeset{data: %NewController{}}

  """
  def change_new_controller(%NewController{} = new_controller, attrs \\ %{}) do
    NewController.changeset(new_controller, attrs)
  end
end
