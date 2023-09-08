defmodule CliTest do
    use ExUnit.Case
    import Issues.CLI, only: [ parse: 1 ]
    
    test ":help returned by option parsing with -h and --help options" do
        assert parse(["-h", "anything"]) == :help
        assert parse(["--help", "anything"]) == :help
    end
    
    test "three values returned if three given" do
        assert parse(["user", "project", "99"]) 
        == { "user", "project", 99 }
    end
    
    test "count is defaulted if two values given" do
        assert parse(["user", "project"]) == { "user", "project", 5 }
    end
end