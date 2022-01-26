RegisterServerEvent("rent_vehicle:payment")
AddEventHandler("rent_vehicle:payment", function()
    TriggerClientEvent("rent_vehicle:spawn", source)
end)