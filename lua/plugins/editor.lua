return {
  {
    "folke/snacks.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for snacks.nvim
    },
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>pv",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      ---@diagnostic disable-next-line
      local fb_actions = require("telescope").extensions.file_browser.actions

      ---@diagnostic disable-next-line
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          -- disables netrw and use telescope-file-browser in its place
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ---@diagnostic disable-next-line
              ["N"] = fb_actions.create,
              ---@diagnostic disable-next-line
              ["h"] = fb_actions.goto_parent_dir,
              ---@diagnostic disable-next-line
              ["."] = fb_actions.toggle_hidden,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("file_browser")
    end,
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
