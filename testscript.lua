local result = require("nvfe.result")
local log = require("nvfe.log")

local rone = result:new{title="title 1", body="lorem ipsum, and all that jazz"}
local rtwo = result:new{title="a second title", body="you know this is mostly a corrupted version of random pieces of Cicero, right?"}

log.push_result(rone)
log.push_result(rtwo)

print(log.results)
