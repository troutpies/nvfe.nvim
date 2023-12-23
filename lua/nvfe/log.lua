--[[
--  maintaining the log
--]]
--
local config = require("nvfe.config")

-- container for the "log" module
local log = {
    -- submodules
    result = require("nvfe.log.result"),

    -- ---------------
    results = {},       -- list of results
}

-- make the submodule accesible

-- =================================================================
-- the log functions
--

-- output the string to vim notify
log.notify = function (s)
    print(s)
end


-- write the string to the logfile
log.write_log = function (s)
    -- clean up the filepath
    local of = assert(io.open(config.values.logdir .. config.values.logfile, "a+"))
    of:write(s)
    of:close()
end

-- add the result to the log
log.push_result = function (r)
    table.insert(log.results, r)
end

-- put the last result into the buffer
log.put_last = function()
    local lines = {}
    for line in string.gmatch( log.results[#log.results]:get_formatted(), "[^\n]+") do
        table.insert(lines, "> " .. line)
    end
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines( 0, cursor[1], cursor[1], false, lines )
end

--[[
log.get_log_str = function(opts)
    local ls = string.format("-- %s -----\n", opts.title)
    ls = ls .. opts.value .. "\n"
    ls = ls .. "----------\n"
    return ls
end

log.push_result = function(r, opts)
    opts = opts or {}

    print( r.get_string() )
    -- table.insert(log.results, r)
end
--
--]]

return log
