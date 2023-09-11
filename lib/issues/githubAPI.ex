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
    def getUrl(user repo), do 
        "https://api.github.com/repos/#{user}/#{project}/issues"
    end

    @doc """
    Read response status code to generate output atom
    """
    def handleResponse(%{status_code: 200, body: body}), do: { :ok, body }
    def handleResponse(%{status_code: ___, body: body}), do: { :error, body }
end