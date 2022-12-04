vim.api.nvim_set_option("termguicolors", true)
local comm = vim.api.nvim_command
local bind = vim.api.nvim_set_keymap
local setvar = vim.api.nvim_set_var
local getvar = vim.api.nvim_get_var

function hi(hi_var, hi_value)
    comm("hi " .. hi_var .. " " .. hi_value)
end
--SETTINGS
vim.o.cmdheight = 1
vim.o.modifiable = true
vim.o.cursorline = true
vim.o.hidden = true
vim.o.encoding= "utf-8"
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.ruler = true
vim.o.cmdheight = 1
vim.o.mouse = "a"
vim.o.splitbelow = true
vim.o.splitright = true
--comm("set nowrap")
vim.o.conceallevel = 0
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.showtabline = 2
vim.o.updatetime = 300
vim.o.lazyredraw = true
vim.o.timeoutlen = 100
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect"
vim.o.cursorcolumn = true

--KEYBINDS

--Colemak-DH bind fuction for hjkl [mnei]) 
local function cdhbind(a, b) 
	bind('n', a:lower(),  b:lower(), { noremap = true})
	bind('n', a:upper(),  b:upper(), { noremap = true})
	bind('o', a:lower(),  b:lower(), { noremap = true})
	bind('o', a:upper(),  b:upper(), { noremap = true})
	bind('x', a:lower(),  b:lower(), { noremap = true})
	bind('x', a:upper(),  b:upper(), { noremap = true})
end

cdhbind('m', 'h')
cdhbind('n', 'j')
cdhbind('e', 'k')
cdhbind('i', 'l')
cdhbind('u', 'i')
cdhbind('l', 'u')
cdhbind('k', 'n')
cdhbind('f', 'e')
cdhbind('t', 'f')
cdhbind('j', 't')

bind('n', "<M-s>", ":w<CR>", {noremap=true})
bind('n', "<M-n>", ":resize -2<CR>", {noremap=true, silent=true})
bind('n', "<M-e>", ":resize +2<CR>", {noremap=true, silent=true})
bind('n', "<M-m>", ":vertical resize -2<CR>", {noremap=true, silent=true})
bind('n', "<M-i>", ":vertical resize +2<CR>", {noremap=true, silent=true})
bind('v', '<', "<gv", {noremap=true})
bind('v', '>', ">gv", {noremap=true})
bind('n', "<C-q>", "<C-w>q", {noremap=true})
bind('n', "<C-m>", "<C-w>h", {noremap=true})
bind('n', "<C-n>", "<C-w>j", {noremap=true})
bind('n', "<C-e>", "<C-w>k", {noremap=true})
bind('n', "<C-i>", "<C-w>l", {noremap=true})
bind('n', "<M-v>", ":vsplit<CR>", {noremap=true, silent=true})
bind('n', "<M-h>", ":split<CR>", {noremap=true, silent=true})

--RUN AND REPL (using vim-floaterm)

function _G.CompileRun()
    local file = vim.fn.expand('%:p')
    local noext = vim.fn.expand('%:p:r')
    local commandMap = {
        ['java']      = 'java ' .. file,
        ['lisp']      = 'clisp ' .. file,
        ['python']    = 'python3 ' .. file,
        ['c']         = 'gcc ' .. file .. ' -o ' .. noext ..  ' -Wno-unused-result ' .. ' && ' .. noext .. ' && rm ' .. noext,
        ['rust']      = 'rustc ' .. file .. ' -o ' .. noext .. ' && ' .. noext .. ' && rm ' .. noext,
        ['cpp']       = 'g++ -std=c++17 ' .. file .. ' -o ' .. noext .. ' -Wno-unused-result ' .. ' && ' .. noext .. ' && rm ' .. noext,
        ['haskell']   = 'ghc -dynamic ' .. file .. ' && ' .. noext .. ' && rm ' .. noext .. ' ' .. noext .. '.o ' .. noext .. '.hi',
        ['sh']        = 'sh ' .. file,
        ['javascript']= 'node ' .. file,
        ['typescript']= 'tsc ' .. file .. ' && node ' .. noext .. '.js && rm ' .. noext .. '.js'
    }
    filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if commandMap[filetype] ~= nil then comm("FloatermNew --autoclose=0 " .. commandMap[filetype]) end
end
 
function _G.Repl()
    local file = vim.fn.expand('%:p')
    local commandMap = {
        ['lisp']      = 'clisp',
        ['python']    = 'python3',
        ['haskell']   = 'ghci ' .. file,
        ['sh']        = 'sh',
        ['javascript']= 'node',
        ['typescript']= 'ts-node',
        ['nix']       = 'nix repl',
        ['lua']       = 'lua'
    }
    filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if commandMap[filetype] ~= nil then comm("FloatermNew " .. commandMap[filetype]) end
end
bind('n', "<F5>", ":call v:lua.CompileRun()<CR>", {silent=true})
bind('n', "<F6>", ":call v:lua.Repl()<CR>", {silent=true})



--PLUGINS CONFIG

--nvim-tree.lua

require'nvim-tree'.setup {
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  ignore_ft_on_setup = { "startify" },  
  renderer = {
    highlight_opened_files = "all",
    highlight_git = true
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
  },
  actions = {
	  open_file = {
	    quit_on_open = true,
	    resize_window = true,
	    window_picker = {
	      enable = true,
	      exclude = {
		filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
		buftype = { "nofile", "terminal", "help" },
	      },
	    },
	  },
  },
}
bind('n', "<M-o>", ":NvimTreeToggle<CR>", {noremap=true, silent=true})
bind('n', "<Space>r", ":NvimTreeRefresh<CR>", {noremap=true, silent=true})
bind('n', "<Space>f", ":NvimTreeFindFile<CR>", {noremap=true, silent=true})


--floaterm
vim.g.floaterm_keymap_toggle = '<F1>'
vim.g.floaterm_keymap_next   = '<F2>'
vim.g.floaterm_keymap_prev   = '<F3>'
vim.g.floaterm_keymap_new    = '<F4>'
vim.g.floaterm_gitcommit='floaterm'
vim.g.floaterm_autoinsert=1
vim.g.floaterm_shell="/usr/bin/env zsh"
vim.g.floaterm_position="bottom"
vim.g.floaterm_width=0.99
vim.g.floaterm_height=0.6

--closetag
vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml,*.js,*.erb,*.jsx"
vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx,*.js,*.erb"
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_shortcut = '>'

--nerdcommenter
bind('n',"<C-c>","<plug>NERDCommenterToggle", {noremap=true, silent=true})
bind('n',"<C-d>","<plug>NERDCommenterSexy", {noremap=true, silent=true})

--barbar
bind('n', "<M-,>", ":BufferPrevious<CR>", {silent=true, noremap=true})
bind('n', "<M-.>", ":BufferNext<CR>", {silent=true, noremap=true})
bind('n', "<M-<>", ":BufferMovePrevious<CR>", {silent=true, noremap=true})
bind('n', "<M->>", ":BufferMoveNext<CR>", {silent=true, noremap=true})
bind('n', "<M-w>", ":BufferClose<CR>", {silent=true, noremap=true})
for i = 1,8,1
do
    bind('n', string.format("<M-%d>", i), string.format(":BufferGoto %d<CR>", i), {silent=true, noremap=true})
end

--presence.nvim
vim.g.presence_neovim_image_text = "Ballin"
vim.g.presence_main_image = "file"

--treesitter-nvim
require'nvim-treesitter.configs'.setup {
  ensure_install = "all",
  highlight = {
    enable = true,            
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  }
}

--vim-latex-live-preview
vim.g.livepreview_previewer = "zathura"



require'colorizer'.setup()

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<M-k>', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', "<M-f>", function() vim.lsp.buf.format { async = true } end, bufopts)
end

local servers = { "clangd", "rust_analyzer", "tsserver", "hls", "pylsp", "texlab", "rnix", "terraform_lsp", "html", "cssls", "jsonls", "svelte", "gopls" }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local nvimlsp = require('lspconfig')
for _, lsp in ipairs(servers) do
  nvimlsp[lsp].setup { capabilities = capabilities, on_attach = on_attach }
end


--luasnip
local luasnip = require 'luasnip'
luasnip.snippets = {
  html = {}
}
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
require("luasnip/loaders/from_vscode").lazy_load()

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-e>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-q>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
    },
    sources = {
      { name = 'nvim_lsp'},
      { name = 'path'},
      { name = 'nvim_lua'},
      { name = 'luasnip'},
      { name = 'calc'},
      { name = 'emoji'},
      { name = 'buffer'},
      { name = 'look'},
    },
    formatting = {
      format = require('lspkind').cmp_format({
        with_text = true,
        menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
        })
      }),
    },
}

comm("set shortmess+=c")

--STATUSLINE
comm("set noruler")
vim.o.laststatus = 2
local function mode()
    local mode_map = {
        ['n'] = 'normal ',
        ['v'] = 'visual ',
        ['V'] = 'v·line ',
        [''] = 'v·block ',
        ['s'] = 'select ',
        ['S'] = 's·line ',
        [''] = 's·block ',
        ['i'] = 'insert ',
        ['Rv'] = 'v·replace ',
        ['c'] = 'command ',
        ['!'] = 'shell ',
        ['t'] = 'terminal '
    }
    local m = vim.api.nvim_get_mode().mode
    if mode_map[m] == nil then return m end
    return mode_map[m]
end

--theming
local dark = true
comm("colorscheme base16-solarized-dark")

hi("Light", "guibg=#eee8d5 guifg=#002b36")
hi("Misc", "guibg=#dc322f guifg=#fdf6e3")
hi("Dark", "guibg=#002b36 guifg=#839496")

local function git()
    local branch = io.popen([[git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n']]):read("*a")
    return string.len(branch) > 0 and ' '.. branch or ''
end


local statusline = {
    '%#Light# ',
    mode():upper() .. ' ',
    '%#Misc#',
    string.len(git()) > 0 and ' ' .. git() .. ' ' or '',
    '%#Dark# ',
    '%f ',
    '%#Light#',
    '%=',
    '%#Dark# ',
    '%y ',
    '%#Light# ',
    '%p%% ',
    ' ',
    '%l/%L ',
    ' ',
    '%c '
}
vim.o.statusline = table.concat(statusline)


function _G.ToggleTheme()
  if dark then
    comm("colorscheme base16-solarized-light")
  else
    comm("colorscheme base16-solarized-dark")
  end
  dark = not dark
  hi("Light", "guibg=#eee8d5 guifg=#002b36")
  hi("Dark", "guibg=#002b36 guifg=#839496")
  hi("Misc", "guibg=#dc322f guifg=#fdf6e3")
  vim.o.statusline = table.concat(statusline)
end
bind('n', "<F7>", ":call v:lua.ToggleTheme()<CR>", {silent=true})
vim.g.tex_flavor = "latex"
