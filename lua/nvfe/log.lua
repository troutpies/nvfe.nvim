--[[
--  maintaining the log
--]]
--
local config = require("nvfe.config")

local log = {}

-- =================================================================
local Result = {
    src = "", value = "",
}

function Result:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- TODO: handle different types of ranges
function Result:get_string()
    local s = string.format("%s\n", self.src)
    s = s .. string.format("Roll: %s - [%s-%s] %s", self.roll, self.m, self.n, self.value)

    return s
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

return log
