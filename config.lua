
Customize = {}

Customize.Framework = "QBCore" -- ESX or QBCore or OLDQBCore

Customize.GetVehFuel = function(Veh)
    return GetVehicleFuelLevel(Veh)-- exports["LegacyFuel"]:GetFuel(Veh)
end

Customize.SetVehFuel = function(Veh, Fuel)
    return GetVehicleFuelLevel(Veh) -- exports['LegacyFuel']:SetFuel(Veh, data.Table.fuel)
end

Customize.Carkeys = function(Plate)
    TriggerEvent('vehiclekeys:client:SetOwner', Plate) --   qb-core
end

Customize.PriceType = 'cash' -- cash - bank
Customize.GaragesPrice = 100
Customize.ImpoundGaragesPrice = 600

Customize.Garages = {
    {
        Blips = {
            Position = vector3(213.56, -809.54, 31.01),
            Label = "Car",
            Sprite = 357,
            Display = 4,
            Scale = 0.5,
            Color = 18,
        },
        Npc = {  Hash = "s_m_y_barman_01", Pos = vector3(213.56, -809.54, 31.01), Heading = 340.67 },
        Type = 'car', --car, air, sea
        UIName = 'Pilbox Garage',
        Camera = {
            vehSpawn = vector4(236.95, -783.71, 30.63, 179.64),
            location = { posX = 233.37, posY = -789.9, posZ = 30.6, rotX = 0.0, rotY = 0.0, rotZ = -32.0, fov = 50.0 },
        },
        VehPutPos = vector3(213.936, -792.53, 30.3523),
        VehSpawnPos = vector4(209.64, -791.39, 30.5, 248.63),
    },
    {
        Blips = {
            Position = vector3(463.75, -982.43, 43.69),
            Label = "Air",
            Sprite = 357,
            Display = 4,
            Scale = 0.5,
            Color = 18,
        },
        Npc = {  Hash = "s_m_y_barman_01", Pos = vector3(463.75, -982.43, 43.69), Heading = 89.74 },
        Type = 'air', --car, air, sea
        UIName = 'Test Pilbox Hill',
        Camera = {
            vehSpawn = vector4(-75.3122, -818.490, 326.17, 201.5),
            location = { posX = -58.0, posY = -828.5, posZ = 335.17, rotX = -25.0, rotY = 0.0, rotZ = 60.2, fov = 40.0 },
        },
        VehPutPos = vector3(449.76, -981.27, 43.69),
        VehSpawnPos = vector4(449.85, -981.23, 43.69, 93.23),
    },
    {
        Blips = {
            Position = vector3(-869.43, -1491.55, 5.17),
            Label = "Sea",
            Sprite = 357,
            Display = 4,
            Scale = 0.5,
            Color = 18,
        },
        Npc = {  Hash = "s_m_y_barman_01", Pos = vector3(-869.43, -1491.55, 5.17), Heading = 112.87 },
        Type = 'sea', --car, air, sea
        UIName = 'Test Pilbox Hill',
        Camera = {
            vehSpawn = vector4(-855.5, -1484.77, -0.47, 111.13),
            location = { posX = -868.0, posY = -1495.0, posZ = 6.31, rotX = -25.0, rotY = 0.0, rotZ = -40.0, fov = 40.0 },
        },
        VehPutPos = vector3(-858.29, -1475.77, 0.5),
        VehSpawnPos = vector4(-799.54, -1502.98, -0.08, 114.38),
    },

}




function GetFramework() -- eyw knk cözdüm
    local Get = nil
    if Customize.Framework == "ESX" then
        while Get == nil do
            TriggerEvent('esx:getSharedObject', function(Set) Get = Set end)
            Citizen.Wait(0)
        end
    end
    if Customize.Framework == "NewESX" then
        Get = exports['es_extended']:getSharedObject()
    end
    if Customize.Framework == "QBCore" then
        Get = exports["qb-core"]:GetCoreObject()
    end
    if Customize.Framework == "OLDQBCore" then
        while Get == nil do
            TriggerEvent('QBCore:GetObject', function(Set) Get = Set end)
            Citizen.Wait(200)
        end
    end
    return Get
end