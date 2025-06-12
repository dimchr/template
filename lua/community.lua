return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  {
    "Mofiqul/vscode.nvim",
    init = function()
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
      vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
    end,
  },
  { import = "astrocommunity.completion.codeium-vim" },
  { import = "astrocommunity.completion.codeium-nvim" },
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  { import = "astrocommunity.git.mini-diff" },
}
