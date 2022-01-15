--// Nikocado
--// oofblocks / 15/1/2022

local Nikocado = {}
Nikocado.__index = Nikocado

---------------------------

--// Settings

---------------------------



---------------------------
--// DO NOT EDIT BELOW UNLESS YOU KNOW WHAT UR DOING!!!!11!!1!
---------------------------

local TypeDefinitions = require(script.TypeDefinitions)

type NikocadoListener = TypeDefinitions.NikocadoListener
type Mukbang = TypeDefinitions.Mukbang

function Nikocado.new()
    return setmetatable({
        Mukbangs = {}
    }, Nikocado)
end

function Nikocado:GetTypeDefs()
    return TypeDefinitions
end

function Nikocado:CreateListener(Callback): NikocadoListener
    local Listener = {}
    Listener.Callback = Callback
    Listener.Active = true

    return Listener
end

function Nikocado:CreateMukbang(Instance: Instance, Callback): Mukbang
    local ClickDetector = Instance.new("ClickDetector")
    ClickDetector.Parent = Instance

    local Listener = self:CreateListener(Callback)
    Listener.Callback = function(...)
        if Listener.Active then
            Callback(...)
        end
    end

    local Mukbang = {}
    Mukbang.Instance = Instance
    Mukbang.NikocadoListener = Listener

    self.Mukbangs[Instance] = Mukbang

    return Mukbang
end

function Nikocado:RemoveMukbang(Instance: Instance)
    local Mukbang = self.Mukbangs[Instance]
    if Mukbang then
        self.Mukbangs[Instance] = nil 
        return
    end
    return warn("Nikocado: Mukbang does not exist!")
end

function Nikocado:ToggleMukbang(Instance: Instance)
    local Mukbang = self.Mukbangs[Instance]
    if Mukbang then
        Mukbang.NikocadoListener.Active = not Mukbang.NikocadoListener.Active
        return
    end
    return warn("Nikocado: Mukbang does not exist!")
end
