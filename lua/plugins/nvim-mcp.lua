-- nvim-mcp: MCP server integration for Claude Code
return {
  dir = "~/repos/nvim-mcp",
  name = "nvim-mcp",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    require("nvim-mcp").setup({
      mcp = {
        auto_start = true,
        notify = true,
      },
    })
  end,
}
