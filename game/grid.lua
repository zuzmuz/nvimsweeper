local cell = {
    new = function(value)
        return {
            value = value,
            cleared = false,
            flagged = false,
            marked = false,
        }
    end
}

Grid = {
    new = function(width, height, mines)
        local grid = {
            width = width,
            height = height,
            mines = mines,
            cells = {},
            cleared = 0,
            flagged = 0,
            initialized = false,
        }
        for i = 1, width*height do
            grid.cells[i] = cell.new(0)
        end
        return grid
    end,

    grid_pos = function(self, x, y)
        return (y-1)*self.width + x
    end,

    init = function(self, start_x, start_y)
        math.randomseed(os.time())
        local mines = self.mines
        for i = 1, self.width*self.height do
            if i ~= Grid.grid_pos(self, start_x, start_y) then
                local random_p = math.random(i, self.width*self.height)
                if random_p <= mines then
                    self.cells[i].value = -1
                    mines = mines - 1
                end
            end
        end
    end,
}


return Grid
