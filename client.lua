local ESX = exports['es_extended']:getSharedObject()

-- HeadID System by DonaldWeed

local knownCache = {}
local voiceDistance = 8.0     -- Display only within this distance
local drawDistance = 15.0
local maskComponent = 1       -- GTA mask component

local function HasMask(ped)
    return GetPedDrawableVariation(ped, maskComponent) ~= 0
end

local function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoords()
    local dist = #(coords - camCoords)

    local scale = (1 / dist) * 2
    scale = scale * (1 / GetGameplayCamFov()) * 100

    SetTextScale(0.0 * scale, 0.5 * scale)
    SetTextFont(0)
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 210)

    SetTextEntry("STRING")
    AddTextComponentString(text)
    SetDrawOrigin(coords.x, coords.y, coords.z + 1.0, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        Wait(0)

        local myPed = PlayerPedId()
        local myCoords = GetEntityCoords(myPed)
        local myPlayerId = PlayerId()

        for _, player in ipairs(GetActivePlayers()) do
            if player ~= myPlayerId then
                local ped = GetPlayerPed(player)
                local coords = GetEntityCoords(ped)
                local distance = #(coords - myCoords)

                if distance <= voiceDistance then
                    ESX.TriggerServerCallback('headid:isAdminHidden', function(isHidden)
                        if isHidden then return end

                        local serverId = GetPlayerServerId(player)

                        if knownCache[serverId] == nil then
                            ESX.TriggerServerCallback('headid:isKnown', function(known)
                                knownCache[serverId] = known
                            end, serverId)
                        end

                        local displayName = 'Stranger'

                        if knownCache[serverId] then
                            displayName = GetPlayerName(player)
                        end

                        if HasMask(ped) then
                            displayName = 'Unknown (Mask)'
                        end

                        DrawText3D(coords,
                            displayName ..
                            '\nID: ' .. serverId
                        )
                    end)
                end
            end
        end
    end
end)

-- Handshake command
RegisterCommand('handshake', function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if player ~= -1 and distance <= 3.0 then
        local serverId = GetPlayerServerId(player)
        TriggerServerEvent('headid:handshake', serverId)
        knownCache[serverId] = true
        ESX.ShowNotification('You now know this person.')
    end
end)


