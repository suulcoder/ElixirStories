defmodule HackerNews.Periodically do
  use GenServer

  alias HackerNews.Repo
  alias HackerNews.Story.HackerNew

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()                                 # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    url = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body = String.replace(body, " ", "")
        body = String.replace(body, "]", "")
        body = String.replace(body, "[", "")
        body = String.split(body, ",")
        for id <- body do
          url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json?print=pretty"
          case HTTPoison.get(url) do
            {:ok, %HTTPoison.Response{status_code: 200, body: response_}} ->
              data = Jason.decode!(response_)
              Repo.get(HackerNew, id) ||
              Repo.insert! %HackerNew{
                id: data["id"],
                by: data["by"],
                descendants: data["descendants"],
                kids: data["kids"],
                score: data["score"],
                time: data["time"],
                title: data["title"],
                type: data["type"],
                url: data["url"]
              }
            {:ok, %HTTPoison.Response{status_code: 400}} ->
              IO.puts "Fetch error"
            {:error, %HTTPoison.Error{reason: reason}} ->
              IO.inspect reason
          end
        end
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        IO.puts "Fetch error"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end

    schedule_work()                                 # Reschedule once more
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 5 * 60 * 1000) # Every 5 minutes
  end
end