local result = require("nvfe.log.result")
local log = require("nvfe.log")
local oracle = require("nvfe.oracle")

oracle.push_oracle("/home/jason/newiron/ironsworn/oracles/01-action.json")
oracle.push_oracle("/home/jason/newiron/ironsworn/oracles/02-theme.json")
oracle.push_oracle("/home/jason/newiron/ironsworn/oracles/03-region.json")

for k,v in pairs(oracle.oraclelist) do
    print(string.format("consulting oracle: %s", k))
    v:put_oracle()
end
