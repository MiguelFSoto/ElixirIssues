defmodule Issues.CLI do
    @moduledoc """
    Handling of command line arguments for the app
    """
    
    def run(argv), do: parse(argv)
    @doc """
    argv can contain -h/--help for :help
    Otherwise, it contains github user, repo and
    number of issues to grab
    """
    def parse(argv) do
        argvParse = OptionParser.parse(argv, switches: [help: :boolean],
                                       aliases: [h: :help])
        defaultIssues = 5
        case argvParse do
            #Checks if help was called
            {[help: true], _, _} 
                -> :help
            #Gets passed arguments
            {_, [user, repo, count], _}
                -> {user, repo, String.to_integer(count)}
            #Gets arguments and defaults the number of issues
            {_, [user, repo], _}
                -> {user, repo, defaultIssues}
            #Defaults to help
            _ -> :help
        end
    end
end