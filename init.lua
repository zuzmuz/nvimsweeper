local Grid = require("game.grid")


local grid = Grid.new(10, 10, 10)

Grid.init(grid, 4, 2)

for i = 1, grid.width*grid.height do
    if grid.cells[i].value == -1 then
        io.write("X")
    else
        io.write(grid.cells[i].value)
    end
    if i % grid.width == 0 then
        io.write("\n")
    end
end


