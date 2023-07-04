local packer = require 'ben-everly.plugins.packer'
if not packer.is_installed then
	packer.install()
end
packer.setup()
