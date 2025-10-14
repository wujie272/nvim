-- Neovim 基础配置（Termux + PC 通用）

--------------------------------------------------
-- 0. 局部变量
--------------------------------------------------
local o = vim.o
local g = vim.g

--------------------------------------------------
-- 1. 编码
--------------------------------------------------
o.encoding = "utf-8"
o.fileencoding = "utf-8"

--------------------------------------------------
-- 2. 显示与界面
--------------------------------------------------
o.number = true          -- 行号
o.relativenumber = true  -- 相对行号
o.cursorline = true      -- 高亮当前行
o.signcolumn = "yes"     -- 左侧 Git 等标记列
o.showmode = false       -- 底部模式提示
o.colorcolumn = "120"    -- 第 120 列竖线
o.wildmenu = true
o.pumheight = 10         -- 补全菜单最多 10 项
o.showtabline = 1        -- 仅当有多 tab 时显示

--------------------------------------------------
-- 3. 缩进与制表符（纯空格，4 格）
--------------------------------------------------
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.autoindent = true
o.smartindent = true
o.shiftround = true

--------------------------------------------------
-- 4. 搜索
--------------------------------------------------
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

--------------------------------------------------
-- 5. 文件与备份
--------------------------------------------------
o.hidden = true     -- 允许未保存切换 buffer
o.autoread = true   -- 外部修改自动加载
o.swapfile = false  -- 避免 sdcard 无法写 *.swp
o.backup = false
o.writebackup = false

--------------------------------------------------
-- 6. 折叠（基于 treesitter）
--------------------------------------------------
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 99
o.foldlevel = 99
o.foldenable = true
o.foldcolumn = "1"
o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
--------------------------------------------------
-- 7. 滚动与换行
--------------------------------------------------
o.sidescrolloff= 10                -- 水平滚动偏移
o.scrolloff = 5                   -- 光标距离边缘5行时开始滚动
o.sidescroll = 5                   -- 水平滚动步长
o.wrap = false                     -- 自动换行
o.whichwrap = "b,s,<,>,[,]"        -- 方向键跨行

--------------------------------------------------
-- 8. 性能
--------------------------------------------------
o.updatetime = 200  -- 比默认 4000 更快
o.timeoutlen = 300

--------------------------------------------------
-- 9. 分割方向
--------------------------------------------------
o.splitbelow = true
o.splitright = true

--------------------------------------------------
-- 10. 补全
--------------------------------------------------
o.completeopt = "menu,menuone,noselect,noinsert"

--------------------------------------------------
-- 11. 主题与鼠标
--------------------------------------------------
o.termguicolors = true
o.background = "dark"
o.mouse = "a"   -- Termux 长按复制 / 三指粘贴仍可用

--------------------------------------------------
-- 12. 禁用不需要的内置插件，加速启动
--------------------------------------------------
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

--------------------------------------------------
-- 13. 其他全局变量
--------------------------------------------------
g.zig_fmt_autosave = false
g.editorconfig = false   -- 禁用 .editorconfig 集成

--------------------------------------------------
-- 14. 命令行
--------------------------------------------------
o.cmdheight = 1   -- 命令行高度 1 行

