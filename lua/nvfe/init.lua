--[[ TODO:
    - local messages log, just for plugin
    - insert results of challenges directly into buffer
    - [ ] implement oracles (in a separate file)
    - [ ] pull values directly from character sheet
    - highlight selected values in neorg character sheet
--]]

NvFE = {}

function NvFE.setup(opts)
    opts = opts or {}

    require("nvfe.config").set_opts(opts)
end

return NvFE
