local M = {}

M.pane_id = nil

local function exec(cmd)
  return vim.fn.system(cmd):gsub('\n', '')
end

function M.toggle_tmux_pane()
  if not os.getenv 'TMUX' then
    vim.notify('Not inside a tmux session', vim.log.levels.ERROR)
    return
  end

  if M.pane_id == nil then
    local cwd = vim.fn.getcwd()

    local shell_cmd = string.format([[bash -c 'cd "%s" && opencode; exec $SHELL']], cwd)
    -- -h for vertical split, -f for full height, -p 25 for 25% width
    local tmux_cmd = string.format([[tmux split-window -h -f -p 25 -P -F "#{pane_id}" %s]], vim.fn.shellescape(shell_cmd))

    local pane_id = exec(tmux_cmd)
    if pane_id == '' or pane_id == nil then
      vim.notify('Failed to create tmux pane', vim.log.levels.ERROR)
      return
    end

    M.pane_id = pane_id
    vim.notify('AI TIME BABY: ' .. pane_id)
  else
    local existing = exec "tmux list-panes -F '#{pane_id}'"
    if string.find(existing, M.pane_id, 1, true) then
      exec('tmux kill-pane -t ' .. M.pane_id)
      M.pane_id = nil
    else
      M.pane_id = nil
      M.toggle_tmux_pane()
    end
  end
end

-- Register keymap once
vim.keymap.set('n', '<leader>oc', function()
  M.toggle_tmux_pane()
end, { desc = 'Toggle vertical tmux pane (¼ width)' })

return M
