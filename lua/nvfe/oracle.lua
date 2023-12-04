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
local Result = log.Result:new{
    title = "oracle result",
    roll = 0, m=0, n=0, range=0,
    value = "",
}

function Result:get_string()
    local lines = {
        self.title,
        string.format("roll: %s", self.roll),
        string.format("%s [%s]", self.value, self.range)
    }

    return table.concat(lines, '\n')
end

-- Modules stuff
M = {}

-- --------------------------------------------------
-- Oracle "class" stuff
--   we add this to the module later (I think I need to do that?)
M.Oracle = {
    name = "oracle", desc = "", path = "",
    m = 1, n = 100,
    values = {},
}

-- this can be initialized with the data from vim.json.decode
function M.Oracle:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- returns a Result, the caller can do what they want with it
function M.Oracle:roll_table()
    local result = Result:new();
    result.roll = math.random(self.m, self.n)

    for _,v in ipairs(self.values) do
        if result.roll >= v.m and result.roll <= v.n then
            if v.m == v.n then
                result.range = string.format("%s", v.m)
            else
                result.range = string.format("%s-%s", v.m, v.n)
            end
            result.m = v.m
            result.n = v.n
            result.title = self.name
            result.value = v.value
        end
    end

    print(string.format("roll: %s, value: %s", result.roll, result.value))

    return result
end

-- return a table of results
function M.Oracle:roll_table_old()
    -- return table will all the results
    local results = {}

    local r
    local roll = math.random(self.m, self.n)


    for _,v in ipairs(self.values) do
        if roll >= v.m and roll <= v.n then
            r = log.Result:new {
                title = self.name,
                src = self.name,
                roll = roll,
                m = v.m,
                n = v.n,
                value = v.value,
            }
            if v.oracle ~= nil then
                results = M.Oracle.roll_table(v.oracle)
            end
            break
        end
    end

    table.insert(results,r)

    return results
end


-- --------------------------------------------------
-- M.Result = Result
M.oraclesdir = "/home/jason/nvfe.nvim/oracles"

-- a list of tables containing the oracles
M.oracles = {}

M.initialize = function(opts)
    opts = opts or {}
    local odir = config.values.oraclepath

    M.loaddir(odir)
end

-- TODO: take a fully qualified path - let the caller do the messy work
M.loadoracle = function(filepath)
    local f = assert(io.open(filepath, "r"))
    local j = f:read("*all")
    f:close()

    -- local t = Oracle:new(vim.json.decode(j))
    -- table.insert(M.oracles, t)
    table.insert(M.oracles, M.Oracle:new(vim.json.decode(j)))
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
