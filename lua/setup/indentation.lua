local function HighlightGroup(number, color)
   return 'highlight IndentColumn'..  number .. ' guibg=' .. COLOR[color]
end

local Color  = {
    'blue',
    'green',
    'yellow',
    'orange',
    'red',
}

local target = "\\s\\{4}"

local function Pattern(numberOfPreceding)
return "\\(^\\(".. target .. "\\)\\{" .. (numberOfPreceding - 1) .. "}\\)\\@<=" .. target
end

local function setMatchAdd(number, pattern)
    vim.fn.matchadd('IndentColumn' .. number, pattern)
end

for i = 1, 5, 1 do
    local color = Color[i]

    local highlightGroup = HighlightGroup(i,color)

    local pattern = Pattern(i)
    vim.cmd(highlightGroup)

    setMatchAdd(i, pattern)
end
