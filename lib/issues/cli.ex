defmodule Issues.CLI do
    @moduledoc """
    Handling of command line arguments for the app
    """
    @defaultIssues 5
    def run(argv) do
        argv
        |> parse
        |> process
    end
    
    @doc """
    Parses the CLI input
    argv can contain -h/--help for :help
    Otherwise, it contains github user, repo and
    number of issues to grab
    """
    def parse(argv) do
        argvParse = OptionParser.parse(argv, switches: [help: :boolean],
                                       aliases: [h: :help])
        
        case argvParse do
            #Checks if help was called
            {[help: true], _, _} 
                -> :help
            #Gets passed arguments
            {_, [user, repo, count], _}
                -> {user, repo, String.to_integer(count)}
            #Gets arguments and defaults the number of issues
            {_, [user, repo], _}
                -> {user, repo, @defaultIssues}
            #Defaults to help
            _ -> :help
        end
    end

    @doc """
    Handles the parsed CLI inputs

    Displays instructions if help was input

    Calls the API functionality for a normal set of inputs
    """
    def process(:help) do
        IO.puts """
        usage: issues <user> <project> [ count | #{@defaultIssues} ]
        """
        System.halt(0)
    end
    def process({user, repo, count}) do
        Issues.GithubAPI.fetch(user, repo)
        |> decodeResponse
        #|> convertList
        |> ascSort
        |> Enum.take(count)
        |> Issues.TableFormatter.printTable(["number", "created_at", "title"])
    end

    @doc """
    Decode the response from the Github API based on status atom
    """
    def decodeResponse({:ok, body}) do
        body
    end
    def decodeResponse({:error, error}) do
        {_, message} = List.keyfind(error, "message", 0)
        IO.puts "Error fetching from Github: #{message}"
        System.halt(2)
    end

    def convertList(list) do
        list
        |> Enum.map(&Enum.into(&1, HashDict.new))
    end
    
    def ascSort(list) do
        Enum.sort list,
        fn i1, i2 -> i1["created_at"] <= i2["created_at"] end
    end
end