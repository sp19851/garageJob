local Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

local QBCore = exports['qb-core']:GetCoreObject()

local ReturnZone = nil
local currentGar = nil
local garageJobBlips = {}
--functions
local function CrPed(model, coords)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local ped = CreatePed(0, model, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
    return ped
end

local function createBlip(coords, sprite, color, label)
    --print('createBlip', coords, sprite, color, label)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.65)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
    return blip
end

local function createBlips()
   for _, v in pairs(garageJobBlips) do
        if DoesBlipExist(v) then
            RemoveBlip(v)
        end
   end
   for i, v in pairs(Config.Locations) do
        local PlayerData = QBCore.Functions.GetPlayerData()
       -- print('i', i, PlayerData.job.name)
        if i == PlayerData.job.name then
            for index, value in pairs(v) do
                local blip = createBlip(vec3(value.coords.x, value.coords.y, value.coords.z), Config.Blip.sprite, Config.Blip.color, Config.Blip.label)
                garageJobBlips[#garageJobBlips+1] = blip
            end
            break
        end
   end
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end


local function openMenu(data, dataGarage)
    --print('58', json.encode(dataGarage))
    local garageMenu = {
        {
            header = "Фракционный гараж",
            txt = "Фракция: "..dataGarage.job.. ", гараж: ".. dataGarage.garage
        }
    }
    for i, v in pairs(data) do
        --print(json.encode(v))
        garageMenu[#garageMenu+1] = {
            header = v.model..' - '.. v.plate,
            txt = "Бензин: " ..v.fuel.." кузов: " ..math.ceil(v.body/10).." двигатель: " ..math.ceil(v.engine/10),
            params = {
                event = "garageJob:client:TakeVehicle",
                args = {
                    model = v.model,
                    plate = v.plate,
                    fuel = v.fuel,
                    body = v.body,
                    engine = v.engine,
                    spawnCoords = dataGarage.spawnCoords,
                    returnCoords = dataGarage.returnCoords,
                    currentGarage = dataGarage.garage,
                    job = dataGarage.job,
                }
            }
        }
    end
   
   

    garageMenu[#garageMenu+1] = {
        header = "⬅ Закрыть меню",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(garageMenu)
end

local returnVehicle = {
    {
        header = 'Вернуть ТС в гараж',
        icon = "fa-solid fa-flag-checkered",
        params = {
            event = 'garageJob:client:ReturnVehicle'
        },
       

    }
}

local function createVehicleReturn(coords, currentGarage)
    --print('156',coords, currentGarage)
    ReturnZone = BoxZone:Create(
        coords,
        5.0,
        5.0,
    {
        name = "box_zone_ReturnZone"..currentGarage,
    })

    ReturnZone:onPlayerInOut(function(isPointInside)
        if isPointInside and IsPedInAnyVehicle(PlayerPedId()) then
			SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0)
            exports['qb-menu']:openMenu(returnVehicle)
        else
            exports['qb-menu']:closeMenu()
        end
    end)
end

local function CheckPlayers(vehicle)
    for i = -1, 5,1 do
        local seat = GetPedInVehicleSeat(vehicle,i)
        if seat ~= 0 then
            TaskLeaveVehicle(seat,vehicle,0)
            SetVehicleDoorsLocked(vehicle)
            Wait(1500)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
   end
end

local function SetCarItemsInfo(job)
    print('job', job)
    if Config.CarItems[job] then
        local items = {}
        for _, item in pairs(Config.CarItems[job]) do
            local itemInfo = QBCore.Shared.Items[item.name:lower()]
            items[item.slot] = {
                name = itemInfo["name"],
                amount = tonumber(item.amount),
                info = item.info,
                label = itemInfo["label"],
                description = itemInfo["description"] and itemInfo["description"] or "",
                weight = itemInfo["weight"],
                type = itemInfo["type"],
                unique = itemInfo["unique"],
                useable = itemInfo["useable"],
                image = itemInfo["image"],
                slot = item.slot,
            }
        end
        Config.JobCarItems = items
    end
	
end


--Events
RegisterNetEvent('garageJob:client:GetVehicles', function(data, dataGarage)
   -- print('97', json.encode(dataGarage))
    openMenu(data, dataGarage)
end)

RegisterNetEvent('garageJob:client:ReturnVehicle', function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then 
        local vehData = {}
        vehData.plate = GetVehicleNumberPlateText(veh)
        QBCore.Functions.TriggerCallback('garageJob:server:CheckReturnVehicleGarage', function(result)
          if result then
            vehData.body = math.ceil(GetVehicleBodyHealth(veh))
            vehData.engine = math.ceil(GetVehicleEngineHealth(veh))
            vehData.fuel = exports['LegacyFuel']:GetFuel(veh)
            TriggerServerEvent('garageJob:server:ReturnVehicle', vehData)
            CheckPlayers(veh)
            
          else
            QBCore.Functions.Notify('Это ТС приписано к другому гаражу')
          end  
        end, currentGar, vehData.plate)
    else
        QBCore.Functions.Notify('Вы должны быть за рулем..')
    end
    
end)



RegisterNetEvent('garageJob:client:TakeVehicle', function(data)
    if not IsAnyVehicleNearPoint(data.spawnCoords.x, data.spawnCoords.y, data.spawnCoords.z, 5.0) then 
        --print('99', json.encode(data))
        --print('99', data.job)
        QBCore.Functions.SpawnVehicle(data.model, function(veh)
            if DoesEntityExist(veh) then
                TriggerServerEvent('garageJob:server:TakeVehicle', data.plate)
                SetVehicleNumberPlateText(veh, data.plate)
                exports['LegacyFuel']:SetFuel(veh, data.fuel)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetCarItemsInfo(data.job)
                if #Config.JobCarItems > 0 then
                    TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.JobCarItems)
                end

                doCarDamage(veh, data)
                createVehicleReturn(data.returnCoords, data.currentGarage)
                currentGar = data.currentGarage
            end
        end, data.spawnCoords, false)
    else 
        QBCore.Functions.Notify("ТС не может быть досталено, зона не свободна", "error", 5000)
    end
end)

-- Threads
if Config.UseTarget  then
    CreateThread(function()
        for k, v in pairs(Config.Locations) do
            for index, value in pairs(v) do
                local model = value.ped_model
                local coords = value.coords 
                local ped = CrPed(model, coords)
                while not DoesEntityExist(ped) do
                    Wait(500)
                end
                --vehiclePolicePeds[i] = ped
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskStartScenarioInPlace(ped, value.scenario, true, true)
                local args = {
                    currentSelection = index,
                    job = k,
                    garage = value.name,
                    spawnCoords = value.spawnCoords,
                    returnCoords = value.returnCoords
                }
                exports['qb-target']:AddTargetEntity(ped, {
                    options = {
                        {
                            label = 'Взять фракционное ТС',
                            icon = 'fa-solid fa-car-alt',
                            action = function() -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                                TriggerServerEvent('garageJob:server:GetVehicles', args)-- Triggers a client event called testing:event and sends the argument 'test' with it
                            end,
                            job = {
                                [k] = 0,
                            }
                            
                        }
                    },
                    distance = 2.0
                })
            end
        end
    end)
else
    local GarageZones = {}
    for k, v in pairs(Config.Locations) do
        for index, value in pairs(v) do
            GarageZones[#GarageZones+1] = BoxZone:Create(
            vector3(vector3(value.coords.x, value.coords.y, value.coords.z)), 2.75, 3, {
            name="box_zone",
            debugPoly = false,
            minZ = value.coords.z - 1,
            maxZ = value.coords.z + 1,
        })
        end
    end

    local garageCombo = ComboZone:Create(GarageZones, {name = "garageCombo", debugPoly = false})
    garageCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            
            if not inGarage then
                exports['qb-core']:DrawText('[E]-открыть гараж','left')
            else
                exports['qb-core']:HideText()
            end
            inGarage = true
        else
            inGarage = false
            exports['qb-core']:HideText()
        end
    end)
end

CreateThread(function()
    while not LocalPlayer.state['isLoggedIn'] do
        Wait(1000)
    end
    if Config.Blip.need then 
        createBlips()
    end
end) 









            



    
