local plugins = {
    {
      "xero/evangelion.nvim",
      lazy = false,
      priority = 1000,
      opts = {
        overrides = {
          keyword = { fg = "#00ff00", bg = "#222222", undercurl = true },
          ["@boolean"] = { link = "Special" }, },
      },
      init = function()
        vim.cmd.colorscheme("evangelion")
      end,
    },
    -- Night Owl is the stylish theme you're currently using
--    {
--      "oxfist/night-owl.nvim",
--      lazy = false,
--      priority = 1000, -- load theme first
--      config = function()
--        vim.cmd.colorscheme("night-owl")
--      end,
--    },
    {
        "rhysd/vim-clang-format",
        lazy = true,
        ft = { "c", "cpp"}
    },
    {
        "psf/black",
        lazy = true,
        ft = "python"
    },
    {
        "neoclide/coc.nvim",
        lazy = false,
        config = function()
            require("plugins.configs.coc")
        end,
        build = "npm ci"
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        ensure_installed = {
            "black",
            "pyright",
            "rust_analyzer",
        }
    },
    {
      "christoomey/vim-tmux-navigator",
      lazy= false,
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'rust-lang/rust.vim',
        ft = { 'rust' },
    },
    {
        'leafOfTree/vim-svelte-plugin',
        ft = { 'svelte' },
        config = function()
            vim.g.vim_svelte_plugin_use_typescript = 1
        end,
    },
    {
        'hylang/vim-hy',
        ft = { 'hy' },
    },
    {
        'benknoble/vim-mips',
        ft = { 'asm' },
    },
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        "OmniSharp/omnisharp-vim",
        ft = { 'cs' },
    },
    {
        "tidalcycles/vim-tidal"
    }
}
return plugins
