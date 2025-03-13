return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/neotest-plenary",
    "antoinemadec/FixCursorHold.nvim",
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/nvim-nio",
  },
  keys = {
    {
      "<leader>trr",
      "<cmd>lua require('neotest').run.run()<cr>",
      desc = "NeoTest run",
      remap = true,
    },
    {
      "<leader>tra",
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
      desc = "NeoTest run all",
      remap = true,
    },
    {
      "<leader>trs",
      "<cmd>lua require('neotest').run.stop()<cr>",
      desc = "NeoTest stop run",
      remap = true,
    },
    {
      "<leader>tso",
      "<cmd>lua require('neotest').summary.toggle()<cr>",
      desc = "NeoTest summary toggle",
      remap = true,
    },
    {
      "<leader>too",
      "<cmd>lua require('neotest').output.open()<cr>",
      desc = "NeoTest output open",
      remap = true,
    },
  },
  config = function()
    require("neotest").setup({
      library = { plugins = { "neotest" }, types = true },
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),

        require("neotest-vim-test")({
          ignore_file_types = { "ts" },
        }),
      },
    })
  end,
}
