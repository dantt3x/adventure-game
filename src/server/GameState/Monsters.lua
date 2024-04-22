local Monsters = {}
Monsters.__index = Monsters

function Monsters.Init()
    local new = {}
    return setmetatable(new, Monsters)
end

function Monsters:Start()
    print("called")
end

return Monsters