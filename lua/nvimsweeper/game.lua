local Buffer = require('nvimsweeper.buffer')
local State = require('nvimsweeper.state')
local Controller = require('nvimsweeper.controller')

local Game = {}

function Game.launch()
    local buffer = Buffer:new()
    local state = State:init()
    local controller = Controller:set(state, buffer)

end

return Game
