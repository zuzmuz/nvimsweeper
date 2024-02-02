local Grid = require('nvimsweeper.grid')

local State = {}

local modes = {
    'menu',
    'game',
    'lost',
}

local levels = {
    'easy',
    'intermediate',
    'hard'
}

local levels_info = {
    easy = {
        name = 'Easy',
        grid_size = {9, 9},
        nb_of_mines = 10,
    },
    intermediate = {
        name = 'Intermediate',
        grid_size = {16, 16},
        nb_of_mines = 40,
    },
    hard = {
        name = 'Hard',
        grid_size = {30, 16},
        nb_of_mines = 100,
    },
}

local function represent_grid(grid)
    -- I don't know if there's a better way to concatenate strings cause I'm on a plane
    local lines = {}
    print('dimensions', grid.width, grid.height)
    for j = 0, grid.height-1 do
        local line = ''
        for i = 1, grid.width do
            local cell = grid.cells[j*grid.height + i]
            local text_value
            if cell.cleared then
                if cell.value == 0 then
                    text_value = ' '
                elseif cell.value == -1 then
                    text_value = 'X'
                else
                    text_value = cell.value
                end
            elseif cell.flagged then
                text_value = 'F'
            elseif cell.marked then
                text_value = '?'
            else
                text_value = '_'
            end
            line = line .. text_value
        end
        lines[#lines+1] = line
    end
    return lines
end


function State:init()
    return setmetatable({
        mode = 'menu'
    }, {__index = self})
end

function State:get_menu()
    self.mode = 'menu'
    return levels
end

function State:create_game(level)
    local level_info = levels_info[levels[level]]
    local grid = Grid:new(level_info.grid_size[1],
                          level_info.grid_size[2],
                          level_info.nb_of_mines)
    self.mode = 'game'
    return represent_grid(grid)
end

function State:select_cell(position)
end

function State:flag_cell(position)
end

function State:question_mark_cell(position)
end

function State:clear_adjacent_cell(position)
end


return State
