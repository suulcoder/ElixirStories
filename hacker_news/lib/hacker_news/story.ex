defmodule HackerNews.Story do
  @moduledoc """
  The Story context.
  """

  import Ecto.Query, warn: false
  alias HackerNews.Repo

  alias HackerNews.Story.HackerNew

  @doc """
  Returns the list of hackernews.

  ## Examples

      iex> list_hackernews()
      [%HackerNew{}, ...]

  """
  def list_hackernews do
    Repo.all(HackerNew)
  end

  @doc """
  Gets a single hacker_new.

  Raises `Ecto.NoResultsError` if the Hacker new does not exist.

  ## Examples

      iex> get_hacker_new!(123)
      %HackerNew{}

      iex> get_hacker_new!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hacker_new!(id), do: Repo.get!(HackerNew, id)

  @doc """
  Creates a hacker_new.

  ## Examples

      iex> create_hacker_new(%{field: value})
      {:ok, %HackerNew{}}

      iex> create_hacker_new(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hacker_new(attrs \\ %{}) do
    %HackerNew{}
    |> HackerNew.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hacker_new.

  ## Examples

      iex> update_hacker_new(hacker_new, %{field: new_value})
      {:ok, %HackerNew{}}

      iex> update_hacker_new(hacker_new, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hacker_new(%HackerNew{} = hacker_new, attrs) do
    hacker_new
    |> HackerNew.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a hacker_new.

  ## Examples

      iex> delete_hacker_new(hacker_new)
      {:ok, %HackerNew{}}

      iex> delete_hacker_new(hacker_new)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hacker_new(%HackerNew{} = hacker_new) do
    Repo.delete(hacker_new)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hacker_new changes.

  ## Examples

      iex> change_hacker_new(hacker_new)
      %Ecto.Changeset{data: %HackerNew{}}

  """
  def change_hacker_new(%HackerNew{} = hacker_new, attrs \\ %{}) do
    HackerNew.changeset(hacker_new, attrs)
  end
end
