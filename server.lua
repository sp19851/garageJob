local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('garageJob:server:GetVehicles')
AddEventHandler('garageJob:server:GetVehicles', function(data)
    local src = source
    --print('5', json.encode(data))
    local Player = QBCore.Functions.GetPlayer(source)
    local result = MySQL.query.await('SELECT * FROM  player_jobvehicles WHERE job = ? and garage = ? and state = 1 and rang <= ?',
    {
        data.job,
        data.garage,
        Player.PlayerData.job.grade.level
    })
    --print('13', json.encode(result))
    if result then
        --print(json.encode(result))
        TriggerClientEvent('garageJob:client:GetVehicles', src, result, data)
    end
end)

RegisterNetEvent('garageJob:server:TakeVehicle')
AddEventHandler('garageJob:server:TakeVehicle', function(plate)
    local src = source
    --print('5', json.encode(data))
    local Player = QBCore.Functions.GetPlayer(source)
    local result = MySQL.update.await('Update player_jobvehicles SET state = 0 where plate = ?',
    {
        plate
    })
    
end)

RegisterNetEvent('garageJob:server:ReturnVehicle')
AddEventHandler('garageJob:server:ReturnVehicle', function(data)
    local src = source
    local result = MySQL.update.await('UPDATE player_jobvehicles SET state = 1, fuel = ?, body = ?, engine = ? where plate = ?',
    {
        data.fuel,
        data.body,
        data.engine,
        data.plate
    })
    
end)

QBCore.Functions.CreateCallback('garageJob:server:CheckReturnVehicleGarage', function(source, cb, currentGar, plate)
    local result = MySQL.query.await('SELECT * FROM  player_jobvehicles WHERE garage = ? and plate = ?', {currentGar, plate})
    if result then
        cb(true)
    else
        cb(false)
    end

end)

CreateThread(function()
    for i, v in pairs(Config.Cars) do
        for index, value in pairs(v) do
            exports.oxmysql:execute('DELETE from player_jobvehicles WHERE job = ?', {i})
        end
    end
    Wait(1500)
    for i, v in pairs(Config.Cars) do
        for index, value in pairs(v) do
            exports.oxmysql:execute('INSERT INTO player_jobvehicles (model, plate, job, garage, fuel, engine, body, state, rang, type) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ? )', 
            {   value.model,
                value.plate,
                i,
                value.garage,
                100,
                1000,
                1000,
                1,
                value.rang,
                'car'
            })
        end
    end
end)
