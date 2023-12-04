--[[
--  maintaining the log
--]]
--
local config = require("nvfe.config")

local log = {
    results = {},
}

-- =================================================================
local Result = {
    title="result",
    body = "",
}

function Result:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- TODO: handle different types of ranges
function Result:get_string()
    local lines = {
        self.title,
        self.body,
    }

    return table.concat(lines, '\n')
end

log.Result = Result

-- =================================================================

log.get_log_str = function(opts)
    local ls = string.format("-- %s -----\n", opts.title)
    ls = ls .. opts.value .. "\n"
    ls = ls .. "----------\n"
    return ls
end

log.write_log = function (s)
    local of = assert(io.open(config.values.logdir .. config.values.logfile, "a+"))
    of:write(s)
    of:close()
end

log.push_result = function(r, opts)
    opts = opts or {}

    print( r.get_string() )
    -- table.insert(log.results, r)
end

return log
