return {
  'augmentcode/augment.vim',
  config = function()
    vim.g.augment_disable_tab_mapping = false
    vim.g.augment_workspace_folders = {'/Users/dchristodoulou/projects/mine/DVR-Scan'}
    vim.cmd("Augment disable")
  end,
}


