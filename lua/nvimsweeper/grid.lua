local Cell = {
    value = false,
    cleared = false,
    flagged = false,
    marked = false,
}

function Cell:new(value)
    return setmetatable({value = value}, {__index = self})
end

local Grid = {
    width = 0,
    height = 0,
    mines = 0,
    cells = {},
    cleared = 0,
    flagged = 0,
    initialized = false,
}

function Grid:new(width, height, mines)
    local grid = setmetatable({
        width = width,
        height = height,
        mines = mines
    }, {__index = self})

    for i = 1, width*height do
        grid.cells[i] = Cell:new(0)
    end

    return grid
end



function Grid:grid_pos(x, y)
    return (y-1)*self.width + x
end


function Grid:init(start_x, start_y)
    math.randomseed(os.time())
    local mines = self.mines
    for i = 1, self.width*self.height do
        if i ~= Grid.grid_pos(self, start_x, start_y) then
            local random_p = math.random(0, self.width*self.height - i)
            if random_p < mines then
                self.cells[i].value = -1
                mines = mines - 1
                if i%self.width ~= 1 and self.cells[i-1].value ~= -1 then -- not left most column
                    self.cells[i-1].value = self.cells[i-1].value + 1
                end
                if i%self.width ~= 0 and self.cells[i+1].value ~= -1 then -- not right most column
                    self.cells[i+1].value = self.cells[i+1].value + 1
                end
                if math.floor((i-1)/self.width) ~= 0 and self.cells[i-self.width].value ~= -1 then -- not top row
                    self.cells[i-self.width].value = self.cells[i-self.width].value + 1
                end
                if math.floor((i-1)/self.width) ~= self.height-1 and self.cells[i+self.width].value ~= -1 then -- not bottom row
                    self.cells[i+self.width].value = self.cells[i+self.width].value + 1
                end
                if i%self.width ~= 1 and math.floor((i-1)/self.width) ~= 0 and self.cells[i-self.width-1].value ~= -1 then -- not top left corner
                    self.cells[i-self.width-1].value = self.cells[i-self.width-1].value + 1
                end
                if i%self.width ~= 1 and math.floor((i-1)/self.width) ~= self.height-1 and self.cells[i+self.width-1].value ~= -1 then -- not bottom left corner
                    self.cells[i+self.width-1].value = self.cells[i+self.width-1].value + 1
                end
                if i%self.width ~= 0 and math.floor((i-1)/self.width) ~= 0 and self.cells[i-self.width+1].value ~= -1 then -- not top right corner
                    self.cells[i-self.width+1].value = self.cells[i-self.width+1].value + 1
                end
                if i%self.width ~= 0 and math.floor((i-1)/self.width) ~= self.height-1 and self.cells[i+self.width+1].value ~= -1 then -- not bottom right corner
                    self.cells[i+self.width+1].value = self.cells[i+self.width+1].value + 1
                end
                if mines == 0 then
                    break
                end
            end
        end
    end
end


return Grid