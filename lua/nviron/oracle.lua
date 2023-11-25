-- handling oracles for *Ironsworn* rpg

--[[
    - include setup that sets a default oracles directory
--]]

M = {}
M.oraclesdir = "/home/jason/nviron.nvim/oracles"

M.getoracle = function(filename)
    local f = assert(io.open(M.oraclesdir .. "/" .. filename, "r"))
    local t = f:read("*all")
    f:close()

    return vim.json.decode(t)
end

M.consult = function(oracle)
    local roll = math.random(oracle.m, oracle.n)

    local result = {}
    for _,v in ipairs(oracle.results) do
        if roll >= v.m and roll <= v.n then
            result = v
            break
        end
    end

    print(oracle.name)
    print(string.format("Roll: %s, Value: %s", roll, result.value))
end

return M
