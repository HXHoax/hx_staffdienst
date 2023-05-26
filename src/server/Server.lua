Duty = {}
StaffOnDuty = {}

ESX = exports['es_extended']:getSharedObject()

RegisterCommand("staffdienst", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" then
        if Duty:CheckOnDuty(source) then 
            Duty:SetOffDuty(source)
            return TriggerClientEvent('esx:showNotification', source, 'Je bent uitdienst gegaan [❌]')
        else
            Duty:SetInDuty(source)
            return TriggerClientEvent('esx:showNotification', source, 'Je bent indienst gegaan [✅]')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Jij bent geen staff. [❌]')
    end
end)

function Duty:SetInDuty(id)
    if not Duty:CheckOnDuty(id) then
        Player(id).state.indienst = true
       return table.insert(StaffOnDuty, id)
    end

    return false
end

function Duty:SetOffDuty(id) 
    for k,v in pairs(StaffOnDuty) do 
        if StaffOnDuty[k] == id then
            Player(id).state.indienst = false
           return table.remove(StaffOnDuty, k)
        end
    end

    return false
end

function Duty:CheckOnDuty(id)
    for key, value in pairs(StaffOnDuty) do
        print('key', key)
        print('value', value)
        print('id', id)

        if key == value and key == id and value == id and key ~= nil then 
            Player(id).state.indienst = true
            return true
        else
            Player(id).state.indienst = false
            return false
        end
    end

    return false
end

function GetOnDutyStaff()
    local ActiveStaff = {}
    for k,v in pairs(StaffOnDuty) do 
        if k == v then
            local format = 'Name' .. GetPlayerName(k) .. ' ID: ' .. k
            table.insert(ActiveStaff, format)

            return ActiveStaff
        end
    end
end



