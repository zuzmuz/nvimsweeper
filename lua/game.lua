local Game = {
}

function Game:launch_game()
    local stats = vim.api.nvim_list_uis()[1]
    local width = stats.width;
    local height = stats.height;
    local min_width = 100
    local min_height = 50
    local win_width = math.min(math.ceil(0.8 * width), min_width)
    local win_height = math.min(math.ceil(0.6 * height), min_height)
    vim.api.nvim_open_win(0, true, {
        relative = 'editor',
        col = math.ceil(width - win_width)/2,
        row = math.ceil(height - win_height)/2,
        width = win_width,
        height = win_height,
        border = 'rounded',
        title = 'NVimSweeper',
        title_pos = 'center'
    })
end

return Game
