defmodule Issues.GithubAPI do
    @moduledoc """
    Github API interaction via HTTP
    """
    @userAgent [{ "User-agent", "Elixir miguel@soto.net.co"}]

    @doc """
    Sends a GET HTTP request to the github API for the issues
    """
    def fetch(user, repo) do
        getUrl(user, repo)
        |> HTTPoison.get(@userAgent)
        |> handleResponse
    end

    @doc """
    Generate github URL for the given project
    """
    def getUrl(user, repo) do 
        "https://api.github.com/repos/#{user}/#{repo}/issues"
    end

    @doc """
    Read response status code to generate output atom
    Decode json from the body
    """
    def handleResponse({:ok, %HTTPoison.Response{body: body}}) do 
        { :ok, Jason.decode!(body) }
    end
    def handleResponse({:error, %HTTPoison.Error{reason: reason}}) do
        { :error, Jason.decode!(reason) }
    end
end