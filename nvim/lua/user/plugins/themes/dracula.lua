local dracula = require 'dracula'
local draculapro = require 'draculapro'

draculapro.setup({
  theme = 'morbius'
})

dracula.setup {
  dracula_pro = draculapro,
  colors = draculapro.colors
}

vim.cmd.colorscheme 'dracula'
