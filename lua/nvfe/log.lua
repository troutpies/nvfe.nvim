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
