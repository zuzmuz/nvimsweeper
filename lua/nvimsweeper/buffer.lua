local Buffer = {
    bufnr = 0,
    winnr = 0,
}

function Buffer:new()
    local buffer = setmetatable({}, {__index = self})
    local bufnr = vim.api.nvim_create_buf(false, true)
    buffer.bufnr = bufnr

    vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(bufnr, 'swapfile', false)
    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)

    local stats = vim.api.nvim_list_uis()[1]
    local width = stats.width;
    local height = stats.height;
    local min_width = 50
    local min_height = 30
    local win_width = math.min(math.ceil(0.8 * width), min_width)
    local win_height = math.min(math.ceil(0.6 * height), min_height)

    buffer.winnr = vim.api.nvim_open_win(bufnr, true, {
        relative = 'editor',
        col = math.ceil(width - win_width)/2,
        row = math.ceil(height - win_height)/2,
        width = win_width,
        height = win_height,
        border = 'rounded',
        title = 'NVimSweeper',
        title_pos = 'center'
    })

    return buffer
end

function Buffer:set_lines(lines)
    print('lines', lines[1])
    vim.api.nvim_buf_set_option(self.bufnr, 'modifiable', true)
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(self.bufnr, 'modifiable', false)
end

return Buffer
