return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.vscode-nvim" },
  { import = "astrocommunity.completion.codeium-vim" },
  { import = "astrocommunity.completion.codeium-nvim" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  -- { import = "astrocommunity.completion.avante-nvim" },
  {
    "Mofiqul/vscode.nvim",
    init = function()
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
      vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
    end,
  }

  
}
