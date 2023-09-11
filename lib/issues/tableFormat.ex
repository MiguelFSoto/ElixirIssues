defmodule Issues.TableFormatter do
    import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]
    
    def printTable(rows, headers) do
        dataColumns = split(rows, headers)
        columnWidths = widths(dataColumns)
        format = formatWidth(columnWidths)
        putsLine headers, format
        IO.puts separator(columnWidths)
        putsColumns dataColumns, format
    end
    
    def split(rows, headers) do
        for header <- headers do
            for row <- rows, do: printable(row[header])
        end
    end
    
    def printable(str) when is_binary(str), do: str
    def printable(str), do: to_string(str)
    
    def widths(columns) do
        for column <- columns, do: column |> map(&String.length/1) |> max
    end
    
    def formatWidth(colWidth) do
        map_join(colWidth, " | ", fn width -> "~-#{width}s" end) <> "~n"
    end
    
    def separator(colWidth) do
        map_join(colWidth, "-+-", fn width -> List.duplicate("-", width) end)
    end
    
    def putsColumns(data, format) do
        data
        |> List.zip
        |> map(&Tuple.to_list/1)
        |> each(&putsLine(&1, format))
    end
    
    def putsLine(fields, format) do
        :io.format(format, fields)
    end
end
