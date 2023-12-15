--[[ TODO:
    - local messages log, just for plugin
    - insert results of challenges directly into buffer
    - [ ] implement oracles (in a separate file)
    - [ ] pull values directly from character sheet
    - highlight selected values in neorg character sheet
--]]

local config = require("nvfe.config")

local nvfe = {}

function nvfe.setup(cfg)
    config.user_config = vim.tbl_deep_extend("force", config.user_config, cfg or {})
end

return nvfe
