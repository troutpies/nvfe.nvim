-- handling oracles for *Ironsworn* rpg

--[[
    - include setup that sets a default oracles directory
    - create usercommands
--]]
--

local config = require("nvfe.config")
local log = require("nvfe.log")

-- ---------------------------------------------------------------------------
-- create a local version of Result
-- it will inherit defaults from log.Result
-- Modules stuff

M = {}

-- --------------------------------------------------
-- Oracle "class" stuff
--   we add this to the module later (I think I need to do that?)
local Oracle = {
    name = "oracle",
    desc = "",
    path = "",
    range = "100",
    values = {},
}


-- this can be initialized with the data from vim.json.decode
function Oracle:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- return a result from the Oracle
function Oracle:roll ()
    local m = 0
    local n = 0

    if tonumber(self.range) then
        m = tonumber(self.range)
        n = tonumber(self.range)
    else
        m, n = string.match(self.range, "(%d+)-(d+)")
    end

end

-- --------------------------------------------------
-- a list of tables containing the oracles
M.oracles = {}


M.initialize = function(opts)
    opts = opts or {}
    local odir = config.values.oraclepath

    M.loaddir(odir)
end

-- TODO: take a fully qualified path - let the caller do the messy work
M.load_oraclefile= function(filepath)
    local f = assert(io.open(filepath, "r"))
    local j = f:read("*all")
    f:close()

    -- local t = Oracle:new(vim.json.decode(j))
    -- table.insert(M.oracles, t)
    table.insert(M.oracles, Oracle:new(vim.json.decode(j)))
end

-- TODO: validate dirpath
M.loaddir = function (dirpath)
    -- get the list of files in the dirpath
    local files = vim.fn.readdir(dirpath)
    for _,f in ipairs(files) do
        -- for each file call `loadoracle`
        print(dirpath .. f)
        M.loadoracle(dirpath .. f)
    end
end

M.list_oracles = function()
    for i,v in ipairs(M.oracles) do
        print(string.format("%s  %s", i, v.name))
    end
end

-- TODO: provide different ways to index
-- Run an Oracle, stored in index
M.consult = function(o)
    local oracle = M.oracles[o]

    local r = oracle.roll_table()
    print( r.get_string() )
    -- log.push_result(oracle.roll_table())
end

return M
