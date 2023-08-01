local font = "gui=none "
local gitHighlight = 'guifg=black guibg=orange'
local normal = font .. "guifg=black guibg=" .. COLOR["blue"]
local insert = font .. "guifg=black guibg=yellow"
local select = font .. "guifg=white guibg=" .. COLOR["red1"]
local command = font .. "guifg=black guibg=#4AF626"
local window = font .. "guifg=black guibg=magenta"

function GitCurrentBranch()
    return vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
end

function SetGitBranch()
    vim.cmd('highlight Gitbranch ' .. gitHighlight)

    local currentBranch = GitCurrentBranch()

    if (currentBranch == '') then
        vim.opt.statusline = "%#FileStatus#%h%m%r%#StatusLine# #%n %-.79(%<%f%) %P %#Nontext#"
    else
        vim.opt.statusline = "%#Gitbranch# שׂ " ..
            currentBranch .. " %#FileStatus#%h%m%r%#StatusLine# #%n %-.79(%<%f%) %P %#Nontext#"
    end
end

function SetStatusLine( mode )
    if mode == "" then
        return false
    elseif mode == "i" then
        vim.cmd( "highlight Statusline " .. insert )
        return true
    elseif mode == "n" then
        vim.cmd( "highlight Statusline " .. normal )
        return true
    elseif mode == "w" then
        vim.cmd( "highlight StatusLine " .. window )
        return true
    elseif mode == "c" then
        vim.cmd( "highlight StatusLine " .. command )
        return true
    else
        vim.cmd( "highlight Statusline " .. select )
    end
end
