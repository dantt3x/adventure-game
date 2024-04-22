local Players = {}
Players.__index = Players

function Players.Init()
    local new = {smth = 0}
    return setmetatable(new, Players)
end

function Players:Start()
    print("called")
end

return Players