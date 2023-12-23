--[[ module: external.nvfe
--
--]]
--

local neorg = require('neorg.core')

local module = neorg.modules.create('external.nvfe')

module.config.public = {
    dirs = {

    }
}

module.load = function()
    local config = module.config.public
    print('NeoVim Fantasy Extensions')
end

return module
