
# FiveM Staffdienst Script

Met dit script kan jij jou staffleden in dienst laten gaan. Doormiddel gebruik te maken van het command "/staffdienst".



## Installatie

1. Download het script en plaats deze in jou server resources.

2. Doe zit dit als volgt in jou server.cfg

```bash
    ensure hx_staffdienst
```

## Het script laten werken
    
1.  Je moet de export gebruiken om te kijken of deze persoon in staffdienst is.


## Exports - Server Side

```lua
Command: /revive

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)

    -- Maakt een variable aan gelinkt aan de export.
	local inDienst = exports["hlm_staffdienst"]:isInDienst(xPlayer.source)

    -- Kijkt of staff niet indienst is.
	if not inDienst then 
    -- Staff is niet indienst dus returnen we het event en versturen we een bericht.
		return TriggerClientEvent('esx:showNotification', xPlayer.source, 'Je bent niet in dienst [❌]')
	else
    -- Staff is in dienst. Reviven gaat door.
		args.playerId.triggerEvent('esx_ambulancejob:revive')
	end
end, true, { help = TranslateCap('revive_help'), validate = true, arguments = {
	{ name = 'playerId', help = 'The player id', type = 'player' }
} })

```


## Exports - Client Side

```lua
RegisterCommand('fix', function() 
    local ped = GetPlayerPed(-1)
    local inDienst = exports["hlm_staffdienst"]:isInDienst(GetPlayerServerId(PlayerId()))

    if not inDienst then 
        return ESX.showNotification("Je bent niet in dienst [❌]")
    end

    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped)
        Fix(vehicle)
    end

end)

function Fix(veh)
    SetVehicleProperties(veh)
end

function SetVehicleProperties(vehicle)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
end
```




## Feedback

If you have any feedback make a merge request.


## Contributing

Contributions are always welcome!

Please adhere to this project's `code of conduct`.

