local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.settings')
load('user.commands')
load('user.keymaps')
load('user.plugins')

require('onedark').setup {
	style = 'deep'
}
require('onedark').load()
