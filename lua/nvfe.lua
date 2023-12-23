--[[ TODO:
    - local messages log, just for plugin
    - insert results of challenges directly into buffer
    - [ ] implement oracles (in a separate file)
    - [ ] pull values directly from character sheet
    - highlight selected values in neorg character sheet
--]]

local M = {
    config = require("nvfe.config"),
    log = require("nvfe.log")
}

function M.setup(cfg)
    M.config.user_config = vim.tbl_deep_extend("force", M.config.user_config, cfg or {})
end

return M
