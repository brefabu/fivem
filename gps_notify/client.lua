Citizen.CreateThread(function()
    while true do
        local threads = 1000

        for i,v in pairs(config) do
            if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(table.unpack(v.coords))) < v.radius then
                threads = 0
                SetNotificationTextEntry("STRING")
                AddTextComponentString(v.message)
                SetNotificationMessage(v.icon, v.icon, true, v.type, v.title, false, v.message)
                DrawNotification(false, true)

                Wait(1000 * 30)
            end
        end

        Wait(threads)
    end
end)