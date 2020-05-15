ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function KeyboardInput2(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function depbank()
    local amount = KeyboardInput('AZX_DEP', ('Somme'), '', 8)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('azx_bank:déposer', amount)
        end
    end
end

function retbank()
    local amount = KeyboardInput2('AZX_RET', ('Somme'), '', 8)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('azx_bank:reti', amount)
        end
    end
end

local banka = {
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 255, 0}, Title = "Banque" },
	Data = { currentMenu = "Banque", "Test" },
	Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			local slide = btn.slidenum
			local btn = btn.name
			local check = btn.unkCheckbox
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            if btn == "Déposer de l'argent" then

                depbank()

            end
                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			if btn == "Retirer de l'argent" then

                retbank()

            end

            if btn == "Solde : " then
                
                TriggerServerEvent('azx_bank:solde')

            end
	end,
    },

	Menu = {

		["Banque"] = {
			b = {
                {name = "Solde : ", ask = "Compte Bancaire", askX = true},
                {name = "Déposer de l'argent", ask = ">", askX = true},
				{name = "Retirer de l'argent", ask = ">", askX = true},
			}
        },
    }
}

local shops = {
    {x=150.266, y=-1040.203, z=29.374},
    {x=-1212.980, y=-330.841, z=37.787},
	{x=-2962.582, y=482.627, z=15.703},
	{x=-112.202, y=6469.295, z=31.626},
	{x=314.187, y=-278.621, z=54.170},
	{x=-351.534, y=-49.529, z=49.042}
}

local blips = {

    {title="Banque", colour=2, id=108, x=150.266, y=-1040.203, z=29.374},
    {title="Banque", colour=2, id=108, x=-1212.980, y=-330.841, z=37.787},
    {title="Banque", colour=2, id=108, x=-2962.582, y=482.627, z=15.703},
    {title="Banque", colour=2, id=108, x=-112.202, y=6469.295, z=31.626},
    {title="Banque", colour=2, id=108, x=314.187, y=-278.621, z=54.170},
    {title="Banque", colour=2, id=108, x=-351.534, y=-49.529, z=49.042},
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(shops) do
            
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, shops[k].x, shops[k].y, shops[k].z)

            if dist <= 2 then
                if IsControlJustPressed(1,51) then 
                    CreateMenu(banka)
                end
            end
        end
    end
end)