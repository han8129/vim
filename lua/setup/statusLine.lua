local font = "gui=none "
local gitHighlight = 'guifg=black guibg=' .. COLOR.orange
local normal = font .. "guifg=black guibg=" .. COLOR.blue
local insert = font .. "guifg=black guibg=yellow"
local select = font .. "guifg=white guibg=" .. COLOR.red1
local command = font .. "guifg=black guibg=" .. COLOR.green
local window = font .. "guifg=black guibg=magenta"

vim.opt.statusline = "%#FileStatus#%h%m%r%#StatusLine# %-.79(%<%f%) %P %#Nontext#"

function GitCurrentBranch()
    return vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
end

function SetGitBranch()
    vim.cmd('highlight Gitbranch ' .. gitHighlight)

    local currentBranch = GitCurrentBranch()

    if (currentBranch == '') then
        vim.opt.statusline = "%#FileStatus#%h%m%r%#StatusLine# %-.79(%<%f%) %P %#Nontext#"
    else
        vim.opt.statusline = "%#Gitbranch# * " ..
            currentBranch .. " %#FileStatus#%h%m%r%#StatusLine# %-.79(%<%f%) %P %#Nontext#"
    end
end

function SetStatusLine( mode )
    mode = mode or vim.fn.mode()

    if mode == "i" then
        vim.cmd( "highlight Statusline " .. insert )

    elseif mode == "n" then
        vim.cmd( "highlight Statusline " .. normal )

    elseif mode == "w" then
        vim.cmd( "highlight StatusLine " .. window )

    elseif mode == "c" then
        vim.cmd( "highlight StatusLine " .. command )

    else
        vim.cmd( "highlight Statusline " .. select )
    end
end

SetStatusLine()
