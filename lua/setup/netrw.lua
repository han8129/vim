REMAP("n", "<leader>ff", ":lua SetNetrwWidth()<Enter>:Lex%:p:h<CR>")
REMAP("n", "<leader>fc", ":lua CloseNetrw()<Enter>")

function NetrwMapping()
    vim.cmd([[

    nmap <buffer> h -^
    nmap <buffer> l <Enter>
    nmap <buffer> . gh
    nmap <buffer> <leader>fc ;lua CloseNetrw()<Enter>
    nmap <buffer> v <nop>
    nmap <buffer> p <nop>
    nmap <buffer> o <nop>
    nmap <buffer> <C-w> <C-w>

    ]])
end

AUTOCMD_GROUP("netrw_mapping", {
    clear = true
})
AUTOCMD('FileType',
    {
        pattern = 'netrw',
        group = 'netrw_mapping',
        command = "lua NetrwMapping()"
    })

function SetNetrwWidth()
    local screenWidth = vim.fn.winwidth(0)

    if (screenWidth <= 106) then
        LET.netrw_winsize = 50
    else
        LET.netrw_winsize = 25
    end
end

function CloseNetrw()
    local bufferNumber = vim.fn.bufnr("$")
    while (bufferNumber >= 1) do
        if (vim.fn.getbufvar(bufferNumber, "&filetype") == "netrw") then
            vim.cmd("bwipeout" .. bufferNumber)
        end
        bufferNumber = bufferNumber - 1
    end
end

local netrwOptions = {
    netrw_banner = 0,
    netrw_browse_split = 4,
    netrw_liststyle = 0,
    netrw_preview = 1,
    netrw_altv = 1,
    netrw_localcopydircmd = 'cp -r',
}

for key, value in pairs(netrwOptions) do
    LET[key] = value
end
