-- client loader

local client = script
local modules = {}
local classes = {}

local inMenu = false

local function startClasses()
    for name, class in pairs(classes) do
        class:Start(classes)
    end
end

local function loadClasses()
    for name, loadedMod: {} in pairs(modules) do
        if loadedMod["Init"] then
            classes[name] = loadedMod.Init()
        end
    end
end

local function loadModules()
    for index, module: ModuleScript in client:GetChildren() do 
        if module:IsA("ModuleScript") then
            modules[module.Name] = require(module) 
        end
    end
end

task.spawn(function()

    if inMenu then
        
    else
        loadModules()
        loadClasses()
        startClasses()
    end

end)