Citizen.CreateThread(function()
	while true do
		Wait(1)

		if config.rgb then
            local curtime = GetGameTimer() / 1000
            
            local r = math.floor(math.sin(curtime * frequency + 0) * 127 + 128)
            local g = math.floor(math.sin(curtime * frequency + 2) * 127 + 128)
            local b = math.floor(math.sin(curtime * frequency + 4) * 127 + 128)
            SetTextColour(r, g, b, config.transparency)
        else
            SetTextColour(255, 255, 255, config.transparency)
		end

        local text = config.message
        text = text:gsub("<NUMBER>", GetNumberOfPlayers())
        
		SetTextFont(config.font)
		SetTextScale(config.scale, config.scale)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(2, 2, 0, 0, 0)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(config.position.x, config.position.y)
	end
end)
