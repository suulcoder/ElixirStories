defmodule HackerNews.Repo do
  use Ecto.Repo,
    otp_app: :hacker_news,
    adapter: Ecto.Adapters.Postgres
end
