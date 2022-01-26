local once = true

Citizen.CreateThread(function()
	function text_overflow(x,y,z, text) 
		local onScreen,_x,_y=World3dToScreen2d(x,y,z)
		local px,py,pz=table.unpack(GetGameplayCamCoords())
		local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
	
		local scale = (1/dist)*1.5
		local fov = (1/GetGameplayCamFov())*130
		local scale = scale*fov
		
		if onScreen then
			SetTextScale(0.2*scale, 0.5*scale)
			SetTextFont(6)
			SetTextProportional(1)
			SetTextColour( 255, 255, 255, 255 )
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			SetTextCentre(1)
			AddTextComponentString(text)
			World3dToScreen2d(x,y,z, 0)
			DrawText(_x,_y)
		end
	end
	
	while true do
        local threads = 1000

		if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(table.unpack(config.coords))) < 20.0 then
			DrawMarker(6,config.coords[1],config.coords[2],config.coords[3]+0.2,0,0,0,0,0,0,1.0,1.0,1.0,30,30,30,200,1,1,0,1,0,0,0)
			DrawMarker(36,config.coords[1],config.coords[2],config.coords[3]+0.2,0,0,0,0,0,0,1.0,1.0,1.0,255,255,255,200,1,1,0,1,0,0,0)
			text_overflow(config.coords[1],config.coords[2],config.coords[3] + 1.15, config.message)
			
			if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(table.unpack(config.coords))) < 3.0 then
				SetTextComponentFormat("STRING")
				AddTextComponentString("Apasa ~INPUT_CONTEXT~ pentru a inchiria un vehicul!")
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				
				if once and IsControlJustPressed(1, 51) then
					if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					  SetNotificationTextEntry("STRING")
					  AddTextComponentString("U're already in a vehicle!")
					  SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Autovit.ro | Cumpara acum!")
					  DrawNotification(false, true)
					else
						TriggerServerEvent("rent_vehicle:payment")
					end
				end
			end

			threads = 0
        end

        Citizen.Wait(threads)
    end
end)

RegisterNetEvent("rent_vehicle:spawn")
AddEventHandler("rent_vehicle:spawn", function()
	local vehicle = GetHashKey(config.vehicle)
	once = false

	RequestModel(vehicle)
	while not HasModelLoaded(vehicle) do
		Citizen.Wait(1)
	end

	local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
	local spawned_car = CreateVehicle(vehicle, coords, GetEntityHeading(GetPlayerPed(-1)), true, false)

	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleNumberPlateText(spawned_car, "RENT")
	SetModelAsNoLongerNeeded(vehicle)
	SetPedIntoVehicle(GetPlayerPed(-1), spawned_car, -1)
	
	Citizen.Wait(10 * 60 * 1000)
	if DoesEntityExist(spawned_car) then
		DeleteVehicle(spawned_car)
		SetNotificationTextEntry( "STRING" )
		AddTextComponentString(  "Time's over!" )
		DrawNotification( false, false )
		once = true
	end
end)
