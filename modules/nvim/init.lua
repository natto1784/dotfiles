vim.api.nvim_set_option("termguicolors", true)
local nvim_lsp = require('lspconfig')
local comm = vim.api.nvim_command
local bind = vim.api.nvim_set_keymap
local setvar = vim.api.nvim_set_var
local getvar = vim.api.nvim_get_var

function hi(hi_var, hi_value)
    comm("hi " .. hi_var .. " " .. hi_value)
end

--SETTINGS

comm("syntax enable")
comm("syntax sync minlines=100")
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
comm("set nowrap")
vim.o.conceallevel = 0
vim.o.tabstop = 4
vim.o.shiftwidth = 4
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
cdhbind('h', 'i')
cdhbind('j', 'm')
cdhbind('k', 'n')
cdhbind('l', 'e')
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
        ['c']         = 'gcc ' .. file .. ' -o ' .. noext .. ' && ' .. noext .. ' && rm ' .. noext,
        ['rust']      = 'rustc ' .. file .. ' -o ' .. noext .. ' && ' .. noext .. ' && rm ' .. noext,
        ['cpp']       = 'g++ -std=c++17 ' .. file .. ' -o ' .. noext .. ' && ' .. noext .. ' && rm ' .. noext,
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

vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_ignore_ft = { "startify" }
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_width_allow_resize = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_window_picker_exclude = {
    ['buftype'] = { 'terminal' }
}
bind('n', "<M-o>", ":NvimTreeToggle<CR>", {noremap=true, silent=true})
bind('n', "<Space>r", ":NvimTreeRefresh<CR>", {noremap=true, silent=true})
bind('n', "<Space>f", ":NvimTreeFindFile<CR>", {noremap=true, silent=true})

--gruvbox
vim.g.gruvbox_italic=1
vim.g.gruvbox_contrast_dark="hard"
vim.g.gruvbox_contrast_light="hard"
vim.o.background="dark"
comm("colorscheme gruvbox")

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
  ensure_installed = "all",
  highlight = {
    enable = true,            
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  }
}

--misc
require'colorizer'.setup()

--lsp and compe stuff i got from various places
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', {silent=true, noremap=true})
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {silent=true, noremap=true})
  buf_set_keymap('n', '<M-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', {silent=true, noremap=true})
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent=true, noremap=true})
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent=true, noremap=true})
  buf_set_keymap('n', "<M-f>", "<cmd>lua vim.lsp.buf.formatting()<CR>", {silent=true, noremap=true})
end

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    calc = true;
    spell = true;
    treesitter = true;
    nvim_lua = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-e>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

bind("i", "<Tab>", "v:lua.tab_complete()", {expr = true, silent = true})
bind("s", "<Tab>", "v:lua.tab_complete()", {expr = true, silent = true})
bind("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true, silent = true})
bind("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true, silent = true})
bind("i", "<CR>", "compe#confirm('<CR>')", {expr = true, silent = true})

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

hi("Light", "guibg=#fbf1c7 guifg=#1d2021")
hi("Dark", "guibg=#1d2021 guifg=#fbf1c7")
hi("Gray", "guifg=#fbf1c7 guibg=#665c54")

local function git()
    local branch = io.popen([[git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n']]):read("*a")
    return string.len(branch) > 0 and ' '.. branch or ''
end

local statusline = {
    '%#Light# ',
    mode():upper() .. ' ',
    '%#Dark#',
    string.len(git()) > 0 and ' ' .. git() .. ' ' or '',
    '%#Gray# ',
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

local servers = { "ccls", "rust_analyzer", "tsserver", "hls", "pylsp" }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { capabilities = capabilities, on_attach = on_attach }
end
