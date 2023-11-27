-- handling oracles for *Ironsworn* rpg

--[[
    - include setup that sets a default oracles directory
--]]
--

-- --------------------------------------------------
-- Oracle "class" stuff
-- this seems to be making things difficult - maybe return to it later
-- for now, just deal with plain tables
-- can I make a "class" a local member of the module?
local Oracle = {
    name = "", desc = "", path = "",
    m = 1, n = 100,
    results = {},
}



-- --------------------------------------------------
-- Modules stuff
M = {}
M.Oracle = Oracle
M.oraclesdir = "/home/jason/nvfe.nvim/oracles"

-- a list of tables containing the oracles
M.oracles = {}

M.loadoracle = function(filename)
    local f = assert(io.open(M.oraclesdir .. "/" .. filename, "r"))
    local j = f:read("*all")
    f:close()

    local t = vim.json.decode(j)
    M.oracles[t.slug] = t
end

M.list_oracles = function()
    for k in pairs(M.oracles) do
        print(k)
    end
end

-- roll a table
-- t: a table containing the contents of an oracle
--    tables with nested oracles should call recursively
-- return: a table of results
--      result: a table containing the result of a single roll
--      - src: where the roll is coming from - the "name" of the table
--      - roll: the "index" for the result
--      - value: the contents of the roll
M.roll_table = function(t)
    -- return table will all the results
    local results = {}

    local r = {
        src = t.name,
        roll = math.random(t.m, t.n),
    }

    for _,v in ipairs(t.results) do
        if r.roll >= v.m and r.roll <= v.n then
            r.val = v.value
            break
        end
    end

    table.insert(results,r)

    return results
end

-- TODO: provide different ways to index
M.consult = function(o)
    local oracle = M.oracles[o]
    local results = M.roll_table(oracle)

    for _,v in ipairs(results) do
        print(string.format("%s", v.src))
        print(string.format("Roll: %s, Value: %s", v.roll, v.val))
    end
end

return M
