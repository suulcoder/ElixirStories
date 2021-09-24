defmodule HackerNews.Repo do
  use Phoenix.Pagination, per_page: 10
  use Ecto.Repo,
    otp_app: :hacker_news,
    adapter: Ecto.Adapters.Postgres
end
