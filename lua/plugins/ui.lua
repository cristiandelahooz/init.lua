return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
    keys = {},
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
        numbers = function(opts)
          return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
      },
      highlights = function()
        local M = {}
        local colors = require("solarized-osaka.colors").setup()
        M.buffer_selected = {
          fg = colors.orange500,
        }
        return M
      end,
    },
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end
          ---@diagnostic disable-next-line
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          ---@diagnostic disable-next-line
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      ---@diagnostic disable-next-line
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
    end,
  },
  -- cursor animation
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local set_hl = vim.api.nvim_set_hl
      set_hl(0, "SnacksInputNormal", { bg = "#001419", fg = "#849900" }) -- inner content input
      set_hl(0, "SnacksInputBorder", { bg = "#001419", fg = "#664c00" }) -- input border

      --Toggle
      Snacks.toggle.zoom():map(";m", { noremap = true, silent = true, desc = "toggle zoom mode" })

      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.header = [[
          --
          ███████╗.█████╗.██╗..██╗██╗██████╗..██████╗..█████╗.           
          ██╔════╝██╔══██╗██║.██╔╝██║██╔══██╗██╔═══██╗██╔══██╗           
          ███████╗███████║█████╔╝.██║██║..██║██║...██║███████║   ⟋|､',   
          ╚════██║██╔══██║██╔═██╗.██║██║..██║██║...██║██╔══██║  (°､ ｡ 7',
          ███████║██║..██║██║..██╗██║██████╔╝╚██████╔╝██║..██║  |､  ~ヽ, 
          ╚══════╝╚═╝..╚═╝╚═╝..╚═╝╚═╝╚═════╝..╚═════╝.╚═╝..╚═╝  じしf_,) 
          ....................................................           
                                        --                               
      ]]
    end,
  },
}
