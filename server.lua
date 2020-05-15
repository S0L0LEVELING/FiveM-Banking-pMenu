ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('azx_bank:solde')
AddEventHandler('azx_bank:solde', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', '', "Votre solde : ~g~"..balance.." $", 'CHAR_BANK_FLEECA', 0)
end)

RegisterServerEvent("azx_bank:déposer")
AddEventHandler("azx_bank:déposer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()

    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)

        TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', '', "Vous avez déposer : ~g~"..total.." $", 'CHAR_BANK_FLEECA', 0)
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', '', "Vous n'avez pas cette somme !", 'CHAR_BANK_FLEECA', 0)
    end
end)

RegisterServerEvent("azx_bank:reti")
AddEventHandler("azx_bank:reti", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getBank()

    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)

        TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', '', "Vous avez retirer : ~g~"..total.." $", 'CHAR_BANK_FLEECA', 0)
    else
        TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Bank', '', "Vous n'avez pas cette somme !", 'CHAR_BANK_FLEECA', 0)
    end
end)