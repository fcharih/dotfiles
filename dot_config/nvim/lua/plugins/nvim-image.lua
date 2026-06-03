return {
  {
    "3rd/image.nvim",
    lazy = false,
    config = function()
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_level = 0,
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
      })
    end,
  },
}
