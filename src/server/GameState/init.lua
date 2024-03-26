local GameStateManager = {}
GameStateManager.__index = GameStateManager

local MonstersModule = require(script.Monsters)
local PlayersModule = require(script.Players)

type GameState = {
    Players: table,
    Monsters: table,
}


function GameStateManager.Init(): table 
    local newGameState: GameState = {
        Players =  PlayersModule.Init(),
        Monsters =  MonstersModule.Init(),
    }
    
    return setmetatable(
        newGameState,
        GameStateManager
    )
end

function GameStateManager:Start(classes: {[string]: table})
    local DataClass = classes.Data
    self.Players:Start(DataClass)
    self.Monsters:Start()
end

return GameStateManager