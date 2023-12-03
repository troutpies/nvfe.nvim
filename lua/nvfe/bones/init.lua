M = {}

-- basic roll function
M.roll = function(d, n, a)
    local results = {}
    for _=1,n do
        table.insert(results, math.random(d))
        print(results[#results])
    end
    print(string.format("Roll: %s, %s, %s", d, n, a))
end

-- make a challenge roll
--   return a table of the results
M.challenge = function(a)
    local result = {
        first = math.random(10),
        second = math.random(10),
        action = math.random(6),
        adds = a,
        outcome = "miss",
    }
    if result.first == result.second then
        result.match = "match"
    else
        result.match = "no match"
    end

    -- strong hit
    if (result.action + result.adds > result.first and result.action + result.adds > result.second) then
        result.outcome = "strong"
    -- weak hit
    elseif (result.action + result.adds > result.first or result.action + result.adds > result.second) then
        result.outcome = "weak"
    end
    -- miss is the default: it's a rough life in the ironlands

    print(string.format("Result: %s",result.outcome))
    print(string.format("  Challenges: %s, %s [%s]", result.first, result.second, result.match))
    print(string.format("  Action: %s (%s[dice] + %s[adds])", result.action + result.adds, result.action, result.adds))
end

return M
