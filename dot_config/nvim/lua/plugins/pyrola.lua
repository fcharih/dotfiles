return {
  "matarina/pyrola.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local pyrola = require("pyrola")

    pyrola.setup({
      -- python_path = "~/miniconda3/envs/ds/bin/python",
      kernel_map = {},
      split_horizontal = false,
      split_ratio = 0.65,
      image = {
        protocol = "sixel",
      },
    })

    vim.keymap.set("n", "<CR>", pyrola.send_statement_definition, { noremap = true })
    vim.keymap.set("v", "<leader>vs", pyrola.send_visual_to_repl, { noremap = true })
    vim.keymap.set("n", "<leader>vb", pyrola.send_buffer_to_repl, { noremap = true })
    vim.keymap.set("n", "<leader>is", pyrola.inspect, { noremap = true })
    vim.keymap.set("n", "<leader>ig", pyrola.show_globals, { noremap = true })
    vim.keymap.set("n", "<leader>ik", pyrola.interrupt_kernel, { noremap = true })
    vim.keymap.set("n", "<leader>im", pyrola.open_history_manager, { noremap = true })
  end,
}
