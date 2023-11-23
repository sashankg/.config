return {
  'rmagatti/auto-session',
  opts = {
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_use_git_branch = true
  },
  init = function()
    vim.keymap.set("n", "<leader>fs", require("auto-session.session-lens").search_session, {
      desc = "[Find] [S]ession"
    })
  end
}
