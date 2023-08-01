local gitHighlight = 'guifg=black guibg=orange'
local font = "gui=none "

local normal = font .. "guifg=black guibg=" .. COLOR["blue"]
local insert = font .. "guifg=black guibg=yellow"
local select = font .. "guifg=white guibg=" .. COLOR["red1"]
local command = font .. "guifg=black guibg=#4AF626"
local window = font .. "guifg=black guibg=magenta"

function GitCurrentBranch()
    return vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
end

local function SetGitBranch()
    vim.cmd('highlight Gitbranch ' .. gitHighlight)

    local currentBranch = GitCurrentBranch()

    if (currentBranch == '') then
        vim.opt.statusline = "%#FileStatus#%h%m%r%#StatusLine# #%n %-.79(%<%f%) %P %#Nontext#"
    else
        vim.opt.statusline = "%#Gitbranch# שׂ " ..
            currentBranch .. " %#FileStatus#%h%m%r%#StatusLine# #%n %-.79(%<%f%) %P %#Nontext#"
    end
end

function SetStatusLine()
    if WindowMode == "active" then
        vim.cmd( "highlight StatusLine " .. window )

        return
    end

    local mode = vim.fn.mode()

    if mode == "i" then
        vim.cmd( "highlight Statusline " .. insert )

    elseif mode == "n" then
        vim.cmd( "highlight Statusline " .. normal )

    elseif mode == "c" then
        vim.cmd( "highlight StatusLine " .. command )

    else
        vim.cmd( "highlight Statusline " .. select )
    end
end

AUTOCMD_GROUP( 'StatusLine', { clear = true, });

AUTOCMD( "BufEnter", {
    group = "StatusLine"
    ,callback = function()
        SetGitBranch()
    end
})

AUTOCMD('ModeChanged', {
    group = "StatusLine"
    ,command = 'lua SetStatusLine()'
})

SetStatusLine()
