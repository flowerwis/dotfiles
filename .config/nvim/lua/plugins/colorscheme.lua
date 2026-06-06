return {
  {
    "Biscuit-Theme/nvim",
    name = "biscuit",
    lazy = false,
    priority = 1000, -- load before other plugins
    config = function()
      vim.cmd("colorscheme biscuit")
    end,
  },
}
