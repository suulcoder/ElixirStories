defmodule HackerNews.StoryWebSocket do

  # set 'otp_app' param like Ecto.Repo
  use Riverside, otp_app: :hacker_news

  alias HackerNews.Repo
  alias HackerNews.Story.HackerNew
  alias HackerNewsWeb.HackerNewView

  @impl Riverside
  def init(session, state) do
    top_stories =  Enum.take( 
      case HTTPoison.get("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body = String.replace(body, " ", "")
          body = String.replace(body, "]", "")
          body = String.replace(body, "[", "")
          body = String.split(body, ",")
          Enum.map(body, 
            fn id -> 
              id_ = String.replace(id,"\n", "")
              [Repo.get(HackerNew, id_) ||
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
          )
        {:ok, %HTTPoison.Response{status_code: 400}} ->
          IO.puts "Fetch error"
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end,50)
    new_stories = Enum.take(Enum.shuffle(
      case HTTPoison.get("https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body = String.replace(body, " ", "")
          body = String.replace(body, "]", "")
          body = String.replace(body, "[", "")
          body = String.split(body, ",")
          Enum.map(body, 
            fn id -> 
              id_ = String.replace(id,"\n", "")
              [Repo.get(HackerNew, id_) ||
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
          )
        {:ok, %HTTPoison.Response{status_code: 400}} ->
          IO.puts "Fetch error"
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end),50) 
    IO.puts "connection trought sockets"
    {:ok, 
      "#{inspect top_stories}", 
      "#{inspect new_stories}"
    }
  end

  def typeof(self) do
    cond do
      is_float(self)    -> "float"
      is_number(self)   -> "number"
      is_atom(self)     -> "atom"
      is_boolean(self)  -> "boolean"
      is_binary(self)   -> "binary"
      is_function(self) -> "function"
      is_list(self)     -> "list"
      is_tuple(self)    -> "tuple"
      true              -> "idunno"
    end    
  end

  @impl Riverside
  def handle_message(msg, session, state) do
    IO.puts msg
    #deliver_me(msg)
    {:ok, session, state}
  end

  @impl Riverside
  def handle_info(into, session, state) do
    IO.puts "on handle info"
    IO.inspect into
    # handle message sent to this process
    {:ok, session, state}
  end

  @impl Riverside
  def terminate(reason, session, state) do
    {:ok, session, state}
  end
end