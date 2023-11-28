-- handling oracles for *Ironsworn* rpg

--[[
    - include setup that sets a default oracles directory
    - create usercommands
--]]
--

-- --------------------------------------------------
-- Oracle "class" stuff
--   we add this to the module later (I think I need to do that?)
local Result
local Oracle = {
    name = "", desc = "", path = "",
    m = 1, n = 100,
    results = {},
}

-- this can be initialized with the data from vim.json.decode
function Oracle:new (o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

-- return a table of results
function Oracle:roll_table()
    -- return table will all the results
    local results = {}

    local r
    local roll = math.random(self.m, self.n)


    for _,v in ipairs(self.results) do
        if roll >= v.m and roll <= v.n then
            r = Result:new {
                src = self.name,
                roll = roll,
                m = v.m,
                n = v.n,
                value = v.value,
            }
            if v.oracle ~= nil then
                results = Oracle.roll_table(v.oracle)
            end
            break
        end
    end

    table.insert(results,r)

    return results
end

-- =================================================================
Result = {
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

-- --------------------------------------------------
-- Modules stuff
M = {}
-- M.Oracle = Oracle
-- M.Result = Result
M.oraclesdir = "/home/jason/nvfe.nvim/oracles"

-- a list of tables containing the oracles
M.oracles = {}

-- TODO: take a fully qualified path - let the caller do the messy work
M.loadoracle = function(filename)
    local f = assert(io.open(M.oraclesdir .. "/" .. filename, "r"))
    local j = f:read("*all")
    f:close()

    local t = Oracle:new(vim.json.decode(j))
    table.insert(M.oracles, t)
end

-- TODO: validate dirpath
M.loaddir = function (dirpath)
    -- get the list of files in the dirpath
    local files = vim.fn.readdir(dirpath)
    for _,f in ipairs(files) do
        -- for each file call `loadoracle`
        M.loadoracle(f)
        print(f)
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
    -- local results = M.roll_table(oracle)
    local results = oracle:roll_table()

    for _,r in ipairs(results) do
        print(r:get_string())
    end
end


return M
