--- @type LazySpec
return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },

  {
    "saghen/blink.cmp",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "folke/lazydev.nvim",
      "mikavilpas/blink-ripgrep.nvim",
      "hrisgrieser/nvim-scissors",
      { "xzbdmw/colorful-menu.nvim", opts = {} },

      -- ✅ 换成纯 Lua 版
      { "echasnovski/mini.pairs", version = "*", event = "InsertEnter", config = true },

      "kristijanhusak/vim-dadbod-completion",
      "MattiasMTS/cmp-dbee",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      fuzzy = { implementation = "lua" }, -- ❌ 不用 Rust
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- 其余 sources 保持你原来不动
      },
      completion = {
        accept = {
          auto_brackets = { enabled = true, default_brackets = { "(", ")" } },
        },
        list = { max_items = 500, selection = { preselect = false, auto_insert = false } },
        menu = {
          border = "rounded",
          auto_show = true,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local lspkind = require("lspkind")
                  lspkind.init({ symbol_map = { Copilot = "" } })
                  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then icon = dev_icon end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                  end
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then hl = dev_hl end
                  end
                  return hl
                end,
              },
            },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
      },
      cmdline = {
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false, auto_insert = true } },
        },
        keymap = { preset = "inherit" },
      },
      keymap = {
        preset = "none",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<A-.>"] = { "show" },
        ["<A-,>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            -- 去掉 Copilot 相关，只保留 cmp + sidekick
            if cmp.is_visible() then
              return cmp.select_next()
            elseif require("sidekick").nes_jump_or_apply() then
              return true
            elseif cmp.snippet_active({ direction = 1 }) then
              return cmp.snippet_forward()
            end
            return false
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
