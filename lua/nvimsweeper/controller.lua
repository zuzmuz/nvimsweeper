local Controller = {
}

local modes = {
    'menu',
    'game',
}

local action_names = {
    'select',
    'clear_adjacent',
    'flag',
    'mark',
    'back',
}

local actions = {
    menu = {
        select = function (position, state)
            return state:create_game(position[1])
        end,
    },
    game = {
        select = function (position, state)
            -- clear cell
        end,
        clear_adjacent = function (position, state)
        end,
        flag = function (position, state)
        end,
        mark = function (position, state)
        end,
        back = function (_, state)
            return state:get_menu()
        end
    },
}


function Controller:set(state, buffer)
    self.buffer = buffer
    self.state = state
    vim.api.nvim_buf_set_keymap(buffer.bufnr, 'n', '<CR>', '', { callback = function()
        self:on_select(action_names[1])
    end})
    vim.api.nvim_buf_set_keymap(buffer.bufnr, 'n', 'z', '', { callback = function()
        self:on_select(action_names[2])
    end})
    vim.api.nvim_buf_set_keymap(buffer.bufnr, 'n', 'x', '', { callback = function()
        self:on_select(action_names[3])
    end})
    vim.api.nvim_buf_set_keymap(buffer.bufnr, 'n', 'c', '', { callback = function()
        self:on_select(action_names[4])
    end})
    vim.api.nvim_buf_set_keymap(buffer.bufnr, 'n', '-', '', { callback = function()
        self:on_select(action_names[5])
    end})

    self.buffer:set_lines(self.state:get_menu())
end

function Controller:on_select(action_name)
    local action = actions[self.state.mode][action_name]
    if action then
        local position = vim.api.nvim_win_get_cursor(self.buffer.winnr)
        self.buffer:set_lines(action(position, self.state))
    end
end


return Controller
