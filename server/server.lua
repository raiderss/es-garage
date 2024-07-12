Framework = nil

if Customize.Framework == 'ESX' then
    Citizen.CreateThread(function()
        while Framework == nil do
            TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
            Citizen.Wait(4)
        end
        
        RegisterNetEvent('Record', function(plate,table)
            if GetResourceState('mysql-async') == 'started' then
                MySQL.Async.execute('UPDATE owned_vehicles SET damage = ? WHERE plate = ?', {json.encode(table), plate})
            elseif GetResourceState('ghmattimysql') == 'started' then
                exports.ghmattimysql:execute('UPDATE owned_vehicles SET damage = ? WHERE plate = ?', {json.encode(table), plate})
            elseif GetResourceState('oxmysql') == 'started' then
                exports.oxmysql:execute('UPDATE owned_vehicles SET damage = ? WHERE plate = ?', {json.encode(table), plate})
            end
        end)
        
          RegisterNetEvent('State', function(state, plate)
            if GetResourceState('mysql-async') == 'started' then
                MySQL.Async.execute('UPDATE owned_vehicles SET state = ? WHERE plate = ?', {state, plate})
            elseif GetResourceState('ghmattimysql') == 'started' then
                exports.ghmattimysql:execute('UPDATE owned_vehicles SET state = ? WHERE plate = ?', {state, plate})
            elseif GetResourceState('oxmysql') == 'started' then
                exports.oxmysql:execute('UPDATE owned_vehicles SET state = ? WHERE plate = ?', {state, plate})
            end
        end)
        
        Framework.RegisterServerCallback("isPrice", function(source, cb, money)
            local Player = Framework.GetPlayerFromId(source)
            if Player.getMoney() >= 500 then 
                Player.removeMoney(500)
                cb(true)
            else
                cb(false)
            end
        end)

        Framework.RegisterServerCallback("IsVehOwned", function(source, cb, plate, extra)
            local Player = Framework.GetPlayerFromId(source)
            if GetResourceState('mysql-async') == 'started' then
            MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
                ["@plate"] = plate
            }, function(result)
                    if result[1] then 
                        cb(true) 
                    else 
                    cb(false) end
                end)
            elseif GetResourceState('ghmattimysql') == 'started' then
                exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
                    ["@plate"] = plate
                }, function(result)
                      if result[1] then 
                          cb(true) 
                      else 
                      cb(false) end
                    end)
             elseif GetResourceState('oxmysql') == 'started' then
                 exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE plate = @plate', {
                     ["@plate"] = plate
                 }, function(result)
                      if result[1] then 
                          cb(true) 
                      else 
                      cb(false) end
                 end)
             end
         end)
        
        Framework.RegisterServerCallback("getVehicles", function(source, cb)
            local xPlayer = Framework.GetPlayerFromId(source)
            if GetResourceState('oxmysql') == 'started' then
                exports.oxmysql:execute('SELECT * FROM owned_vehicles WHERE owner=@owner', {
                    ['@owner'] = xPlayer.identifier,
                }, function(result)
                    cb(result)
                end)
            elseif GetResourceState('ghmattimysql') == 'started' then
                exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner=@owner', {
                    ['@owner'] = xPlayer.identifier,
                }, function(result)
                    cb(result)
                end)
            elseif GetResourceState('mysql-async') == 'started' then
                MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner=@owner', {
                    ['@owner'] = xPlayer.identifier,
                }, function(result)
                    cb(result)
                end)
            end
        end)
        
    end)

elseif Customize.Framework == 'QBCore' or Customize.Framework == 'OLDQBCore'  then
    if Customize.Framework == "OLDQBCore" then
        while Framework == nil do
            TriggerEvent('QBCore:GetObject', function(obj) Framework = obj end)
            Citizen.Wait(4)
        end
    else  Framework = exports['qb-core']:GetCoreObject() end

    Framework.Functions.CreateCallback("isPrice", function(source, cb)
        local Player = Framework.Functions.GetPlayer(source)
		if Player.Functions.RemoveMoney(Customize.PriceType, Customize.GaragesPrice) then
			cb(true)
		else
			cb(false)
		end
    end)

    
    RegisterNetEvent('Record', function(plate,table)
        MySQL.Async.execute('UPDATE player_vehicles  SET damage = ? WHERE plate = ?', {json.encode(table), plate})
    end)
    
      RegisterNetEvent('State', function(state, plate)
        if GetResourceState('mysql-async') == 'started' then
            MySQL.Async.execute('UPDATE player_vehicles  SET state = ? WHERE plate = ?', {state, plate})
        elseif GetResourceState('ghmattimysql') == 'started' then
            exports.ghmattimysql:execute('UPDATE player_vehicles  SET state = ? WHERE plate = ?', {state, plate})
        elseif GetResourceState('oxmysql') == 'started' then
            exports.oxmysql:execute('UPDATE player_vehicles  SET state = ? WHERE plate = ?', {state, plate})
        end
    end)


    Framework.Functions.CreateCallback("IsVehOwned", function(source, cb, plate, extra)
        local Player = Framework.Functions.GetPlayer(source)
        if GetResourceState('mysql-async') == 'started' then
        MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = @plate', {
            ["@plate"] = plate
        }, function(result)
                if result[1] then 
                    cb(true) 
                else 
                cb(false) end
            end)
        elseif GetResourceState('ghmattimysql') == 'started' then
            exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE plate = @plate', {
                ["@plate"] = plate
            }, function(result)
                  if result[1] then 
                      cb(true) 
                  else 
                  cb(false) end
            end)
        elseif GetResourceState('oxmysql') == 'started' then
            exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE plate = @plate', {
                ["@plate"] = plate
            }, function(result)
                 if result[1] then 
                     cb(true) 
                 else 
                 cb(false) end
            end)
        end
    end)

    
    Framework.Functions.CreateCallback("getVehicles", function(source, cb)
        local xPlayer = Framework.Functions.GetPlayer(source)
        if GetResourceState('oxmysql') == 'started' then
            exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE citizenid = @citizenid', {
                ['@citizenid'] = xPlayer.PlayerData.citizenid,
            }, function(result)
                cb(result)
            end)
        elseif GetResourceState('ghmattimysql') == 'started' then
            exports.ghmattimysql:execute('SELECT * FROM player_vehicles WHERE citizenid = @citizenid', {
                ['@citizenid'] = xPlayer.PlayerData.citizenid,
            }, function(result)
                cb(result)
            end)
    
        elseif GetResourceState('mysql-async') == 'started' then
            MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = @citizenid', {
                ['@citizenid'] = xPlayer.PlayerData.citizenid,
            }, function(result)
                cb(result)
            end)
        end
    end)

end


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    Wait(100)
    if Customize.Framework == 'ESX' then
        if GetResourceState('mysql-async') == 'started' then
            MySQL.Async.execute('UPDATE owned_vehicles SET state = 1 WHERE state = 0', {})
        elseif GetResourceState('ghmattimysql') == 'started' then
            exports.ghmattimysql:execute('UPDATE owned_vehicles SET state = 1 WHERE state = 0', {})
        elseif GetResourceState('oxmysql') == 'started' then
            exports.oxmysql:execute('UPDATE owned_vehicles SET state = 1 WHERE state = 0', {})
        end
    else
        if GetResourceState('mysql-async') == 'started' then
            MySQL.Async.execute('UPDATE player_vehicles SET state = 1 WHERE state = 0', {})
        elseif GetResourceState('ghmattimysql') == 'started' then
            exports.ghmattimysql:execute('UPDATE player_vehicles SET state = 1 WHERE state = 0', {})
        elseif GetResourceState('oxmysql') == 'started' then
            exports.oxmysql:execute('UPDATE player_vehicles SET state = 1 WHERE state = 0', {})
        end
    end
  end)