--[[ TODO:
    - telescope support
    - handle nested oracles
    - handle multi-column oracles
--]]

local config = require("nvfe.config")
local result = require("nvfe.log.result")
local log = require("nvfe.log")
local divination = require("nvfe.oracle.divination")

-- -------------------------------------------------------------------
-- Oracle class
local Oracle = {}
function Oracle:new (o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

-- get an entry from an oracle
-- rolls randomly if no entry is provided
function Oracle:get_result (entryindex)
    entryindex = entryindex or self:roll_table()

    for _,entry in ipairs(self.entries) do
        if self.is_between(entryindex, entry.range) then
            return divination:new {
                roll = entryindex,
                value = entry.value,
                range = entry.range,
                title = self.name,
            }
        end
    end
end

function Oracle:put_oracle()
    log.push_result(self:get_result())
    log.put_last()
end

-- get a random entry index
function Oracle:roll_table (range)
    range = range or self:get_range()
    return math.random(range.m, range.n)
end

-- it's simple but it works
function Oracle.is_between(i, r) return i >= r.m and i <= r.n end

-- creates a range for the oracle if one doesn't exist
--      but really, this should be specified in the JSON file
function Oracle:get_range ()
    if self.range then return self.range end
    local m, n = 0, 0
    for entry in self.entries do
        local r = self.get_mn(entry.range)
        if m > 0 then
            m = math.min(m,r.m)
        else m = r.m
        end
        n = math.max(n,r.n)
    end
    self.range = {m=m,n=n}
    return self.range
end

-- TODO: this is probably redundant
--  refactor get_range()
function Oracle.get_mn(range)
    if type(range) == "number" then
        return { m = range, n = range }
    elseif type(range) == "string" then
        local m,n = string.match(range, "(%d+)-(%d+)")
        return { m = tonumber(m), n = tonumber(n) }
    end
end

-- -------------------------------------------------------------------
-- Module
local module = {
    Oracle = Oracle,
    oraclelist = {},
}

-- create a new oracle from the complete filepath
function module.read_oraclejson(filepath)
    local f = assert(io.open(filepath, "r"))
    local t = f:read("*all")
    f:close()

    return Oracle:new(vim.json.decode(t))
end

-- add a new oracle to the oracle list
function module.push_oracle(filepath)
    local o = module.read_oraclejson(filepath)
    module.oraclelist[o.name] = o
end

return module
