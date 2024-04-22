-- describes what region the player currently is in, useful for lighting and camera offset


local Region = {}
Region.__index  = Region

function Region.Init()
    local newRegionManager = {}

    return setmetatable(
        newRegionManager,
        Region
    )
end

function Region:Start()
    
end

return Region