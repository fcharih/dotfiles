return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "pyright", -- or "pylsp" if you prefer
        "ruff_lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic", -- "off", "basic", or "strict"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
      },
    },
  },
}
