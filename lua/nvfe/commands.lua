M = {}

vim.api.nvim_create_user_command('NvFE',
    function(opts)
        local oracle = require("nvfe.oracle")

        print(opts.fargs[1])
        if opts.fargs[1] == "loaddir" then
            oracle.loaddir(opts.fargs[2])
        elseif opts.fargs[1] == "listoracles" then
            oracle.list_oracles()
        elseif opts.fargs[1] == "consult" then
            oracle.consult(tonumber(opts.fargs[2]))
        end
    end,
    {   nargs = "*",
        complete = function(ArgLead, CmdLine, CursorPos)
            return { "loaddir", "listoracles", "consult" }
        end,
    }
)

return M
