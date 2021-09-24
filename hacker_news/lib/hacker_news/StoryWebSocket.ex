defmodule HackerNews.StoryWebSocket do

  # set 'otp_app' param like Ecto.Repo
  use Riverside, otp_app: :my_app

  alias HackerNews.Repo
  alias HackerNews.Story.HackerNew

  @impl Riverside
  def handle_message(msg, session, state) do
    deliver_me(msg)
    top_stories = []
    new_stories = []
    case HTTPoison.get("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body = String.replace(body, " ", "")
        body = String.replace(body, "]", "")
        body = String.replace(body, "[", "")
        body = String.split(body, ",")
        for id <- body do
          IO.puts id
          top_stories = top_stories ++ [Repo.get(HackerNew, id) ||
                              case HTTPoison.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json?print=pretty") do
                                {:ok, %HTTPoison.Response{status_code: 200, body: response_}} ->
                                  data = Jason.decode!(response_)
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
                              end]
        end
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        IO.puts "Fetch error"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
    case HTTPoison.get("https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body = String.replace(body, " ", "")
        body = String.replace(body, "]", "")
        body = String.replace(body, "[", "")
        body = String.split(body, ",")
        for id <- body do
          top_stories = top_stories ++ [Repo.get(HackerNew, id) ||
                              case HTTPoison.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json?print=pretty") do
                                {:ok, %HTTPoison.Response{status_code: 200, body: response_}} ->
                                  data = Jason.decode!(response_)
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
                              end]
        end
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        IO.puts "Fetch error"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end

    {:ok, top_stories, new_stories}
  end

end