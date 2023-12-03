--[[ module: external.nvfe
--
--]]
--

local neorg = require('neorg.core')

local module = neorg.modules.create('external.nvfe')

module.load = function()
    print('NeoVim Fantasy Extensions')
end

return module
