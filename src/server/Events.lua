AddEventHandler('playerDropped', function ()
    local _src = source

    if Duty:CheckOnDuty(_src) then 
        Duty:SetOffDuty(_src)
        return print("Player " .. GetPlayerName(_src) .. " has dropped and removed from staffduty table")
    end
end)

AddEventHandler("playerConnecting", function(...) 
    local player = source

    if Duty:CheckOnDuty(player) then
        return Duty:SetOffDuty(player)
    else
        return false
    end
end)

exports('isInDienst', function(id)
    return Duty:CheckOnDuty(id)
end)