-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    dev = {
        path = vim.fn.expand("~/code"),
        fallback = true,
    },
    checker = {
        enabled = true,
        notify = false,
        frequency = 3600, -- 检查频率降低到1小时，提升启动性能
    },
    change_detection = {
        -- 自动检查配置文件更改并重新加载ui
        enabled = false,
        notify = false, -- 发现更改时获得通知
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to improve startup time
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen", -- 禁用括号匹配高亮以提升性能
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    rocks = {
        hererocks = true, -- 您应该启用它以获得hererocks的支持
    },
})
