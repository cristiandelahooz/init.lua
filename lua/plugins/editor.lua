return {
  {
    "folke/snacks.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for snacks.nvim
    },
    ---@param opts snacks.config
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.enabled = true
      opts.picker.layout = "vertical"
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = opts.picker.sources.explorer or {}
      opts.picker.sources.explorer.layout = "vertical"
      opts.picker.prompt = ":: "
      opts.picker.win.input.keys = vim.tbl_extend("force", opts.picker.win.input.keys or {}, {
        ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
        ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
      })
    end,
    keys = {
      {
        ";;",
        function()
          require("snacks").picker.resume()
        end,
        desc = "Resume the previous snacks picker",
      },
      {
        ";f",
        function()
          require("snacks").picker.files({
            hidden = true,
            no_ignore = false,
            file_ignore_patterns = { "%.git/" },
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";F",
        function()
          require("snacks").picker.files({
            cwd = vim.fn.getcwd(-1, -1), -- Use root directory
            hidden = true,
            no_ignore = false,
            file_ignore_patterns = { "%.git/" },
          })
        end,
        desc = "Lists files in the root directory, respects .gitignore",
      },
      {
        ";r",
        function()
          require("snacks").picker.grep({
            additional_args = { "--hidden" },
          })
        end,
        desc = "Search for a string in your current working directory, respects .gitignore",
      },
      {
        "\\\\",
        function()
          require("snacks").picker.buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";h",
        function()
          require("snacks").picker.help()
        end,
        desc = "Lists available help tags and opens help on <cr>",
      },
      {
        ";z",
        function()
          require("snacks").picker.zoxide()
        end,
        desc = "Lists directories from zoxide",
      },
      {
        ";e",
        function()
          require("snacks").picker.diagnostics()
        end,
        desc = "Lists diagnostics for all open buffers",
      },
      {
        ";s",
        function()
          require("snacks").picker.lsp_symbols()
        end,
        desc = "Lists function names, variables from Treesitter",
      },
      {
        "<leader>n",
        function()
          require("snacks").notifier.show_history()
        end,
        desc = "Show the history of notifications",
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },

  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local utils = require("solarized-osaka.hsl")
            --- @type string, string, string
            local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            ---@diagnostic disable-next-line
            local hex_color = utils.hslToHex(h, s, l)
            ---@diagnostic disable-next-line
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = function()
      if vim.fn.exists("$TMUX") == 1 then
        return "VeryLazy"
      end
    end,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },

  {
    "mbbill/undotree",
    event = "BufReadPre",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>U",
        vim.cmd.UndotreeToggle,
        { noremap = true, silent = true, desc = "Toggle undotree panel" }
      )
    end,
  },
}
