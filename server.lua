ESX = exports['es_extended']:getSharedObject()

-- HeadID System by DonaldWeed

-- Handshake: make players known to each other
RegisterNetEvent('headid:handshake', function(targetId)
    local sourceId = source
    local xPlayer = ESX.GetPlayerFromId(sourceId)
    local tPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer or not tPlayer then return end

    MySQL.insert(
        'INSERT IGNORE INTO player_relations (identifier, target_identifier) VALUES (?, ?)',
        { xPlayer.identifier, tPlayer.identifier }
    )

    MySQL.insert(
        'INSERT IGNORE INTO player_relations (identifier, target_identifier) VALUES (?, ?)',
        { tPlayer.identifier, xPlayer.identifier }
    )
end)

-- Check if players know each other
ESX.RegisterServerCallback('headid:isKnown', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(target)
    if not xPlayer or not tPlayer then return cb(false) end

    MySQL.scalar(
        'SELECT 1 FROM player_relations WHERE identifier = ? AND target_identifier = ?',
        { xPlayer.identifier, tPlayer.identifier },
        function(result)
            cb(result ~= nil)
        end
    )
end)

-- Admin invisibility check
ESX.RegisterServerCallback('headid:isAdminHidden', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return cb(false) end

    cb(xPlayer.getGroup() ~= 'user' and xPlayer.get('adminmode') == true)
end)


