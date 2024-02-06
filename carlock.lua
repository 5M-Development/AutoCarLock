ESX = nil
ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicles = ESX.Game.GetVehiclesInArea(coords, 100.0)

        for _, vehicle in ipairs(vehicles) do
            if NetworkGetEntityIsNetworked(vehicle) then
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver ~= playerPed and not IsPedAPlayer(driver) then
                    local vehicleName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
                    if IsVehicleOnAllWheels(vehicle) then
                        if IsVehicleInConfig(vehicleName) then
                            SetVehicleDoorsLocked(vehicle, 2) -- 2 sperrt das Fahrzeug ab
                        else
                            SetVehicleDoorsLocked(vehicle, 0) -- 0 entsperrt das Fahrzeug
                        end
                    end
                end
            end
        end
    end
end)

function IsVehicleInConfig(vehicleName)
    for _, configVehicle in ipairs(Config.LockedVehicles) do
        if string.lower(configVehicle) == string.lower(vehicleName) then
            return true
        end
    end
    return false
end