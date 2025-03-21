-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local frozen = false
local permissions = {
    ['kill'] = 'admin',
    ['ban'] = 'admin',
    ['noclip'] = 'admin',
    ['kickall'] = 'god',
    ['kick'] = 'admin',
    ["revive"] = "admin",
    ["freeze"] = "admin",
    ["goto"] = "admin",
    ["spectate"] = "admin",
    ["intovehicle"] = "admin",
    ["bring"] = "admin",
    ["inventory"] = "admin",
    ["clothing"] = "admin"
}
local players = {}

-- Get Dealers
QBCore.Functions.CreateCallback('test:getdealers', function(_, cb)
    cb(exports['qb-drugs']:GetDealers())
end)

-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(_, cb) -- WORKS
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getgodperm', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'god') or IsPlayerAceAllowed(source, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-admin:server:getadminperm', function(source, cb)
    if QBCore.Functions.HasPermission(source, 'admin') or IsPlayerAceAllowed(source, 'command') then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions
local function tablelength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

local function BanPlayer(src)
    MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(src),
        QBCore.Functions.GetIdentifier(src, 'license'),
        QBCore.Functions.GetIdentifier(src, 'discord'),
        QBCore.Functions.GetIdentifier(src, 'ip'),
        "Trying to revive theirselves or other players",
        2147483647,
        'qb-adminmenu'
    })
    TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(src), 'qb-adminmenu', "Trying to trigger admin options which they dont have permission for"), true)
    DropPlayer(src, 'You were permanently banned by the server for: Exploiting')
end

-- Events
RegisterNetEvent('qb-admin:server:GetPlayersForBlips', function()
    local src = source
    TriggerClientEvent('qb-admin:client:Show', src, players)
	TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Blipleri Açtı', 'red', string.format('%s adlı oyuncu blipleri açtı', GetPlayerName(src)), false)
end)

RegisterNetEvent('qb-admin:server:kill', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['kill']) or IsPlayerAceAllowed(src, 'command')  then
	TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncu Öldürüldü', 'red', string.format('%s adlı oyuncu %s tarafından öldürüldü', GetPlayerName(player.id), GetPlayerName(src)), false)
        TriggerClientEvent('hospital:client:KillPlayer', player.id)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:revive', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['revive']) or IsPlayerAceAllowed(src, 'command')  then
	TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncu Canlandırıldı', 'red', string.format('%s adlı oyuncu %s tarafından canlandırıldı', GetPlayerName(player.id), GetPlayerName(src)), false)
        TriggerClientEvent('hospital:client:Revive', player.id)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:kick', function(player, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command')  then
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), false)
        DropPlayer(player.id, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. QBCore.Config.Server.Discord)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:ban', function(player, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
        time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date('*t', banTime)
        MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
            GetPlayerName(player.id),
            QBCore.Functions.GetIdentifier(player.id, 'license'),
            QBCore.Functions.GetIdentifier(player.id, 'discord'),
            QBCore.Functions.GetIdentifier(player.id, 'ip'),
            reason,
            banTime,
            GetPlayerName(src)
        })
      --  TriggerClientEvent('chat:addMessage', -1, {
      --      template = "<div class=chat-message server'><strong>DUYURU |id: {0} banlandı</strong> {1}</div>",
      --      args = {GetPlayerName(player.id), reason}
      --  })
        TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), false)
        if banTime >= 2147483647 then
            DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. QBCore.Config.Server.Discord)
        else
            DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discord for more information: ' .. QBCore.Config.Server.Discord)
        end
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:spectate', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['spectate']) or IsPlayerAceAllowed(src, 'command') then
        local targetped = GetPlayerPed(player.id)
        local coords = GetEntityCoords(targetped)
        TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncu İzleniyor', 'red', string.format('%s adlı oyuncu %s tarafından izleniyor', GetPlayerName(player.id), GetPlayerName(src)), false)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:freeze', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['freeze']) or IsPlayerAceAllowed(src, 'command') then
        local target = GetPlayerPed(player.id)
        if not frozen then
            frozen = true
            FreezeEntityPosition(target, true)
			TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncu Donduruldu', 'red', string.format('%s adlı oyuncu %s tarafından donduruldu', GetPlayerName(player.id), GetPlayerName(src)), false)
        else
            frozen = false
            FreezeEntityPosition(target, false)
        end
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:goto', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['goto']) or IsPlayerAceAllowed(src, 'command') then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(GetPlayerPed(player.id))
        SetEntityCoords(admin, coords)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncuya Işınlanıldı', 'red', string.format('%s adlı oyuncuya %s tarafından ışınlanıldı', GetPlayerName(player.id), GetPlayerName(src)), false)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:intovehicle', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['intovehicle']) or IsPlayerAceAllowed(src, 'command') then
        local admin = GetPlayerPed(src)
        local targetPed = GetPlayerPed(player.id)
        local vehicle = GetVehiclePedIsIn(targetPed,false)
        local seat = -1
        if vehicle ~= 0 then
            for i=0,8,1 do
                if GetPedInVehicleSeat(vehicle,i) == 0 then
                    seat = i
                    break
                end
            end
            if seat ~= -1 then
                SetPedIntoVehicle(admin,vehicle,seat)
                TriggerClientEvent('QBCore:Notify', src, Lang:t("sucess.entered_vehicle"), 'success', 5000)
				TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncunun Aracına Bindi', 'red', string.format('%s adlı oyuncunun aracına %s tarafından binildi', GetPlayerName(player.id), GetPlayerName(src)), false)
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_free_seats"), 'info', 5000)
            end
        end
    else
        BanPlayer(src)
    end
end)


RegisterNetEvent('qb-admin:server:bring', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['bring']) or IsPlayerAceAllowed(src, 'command') then
        local admin = GetPlayerPed(src)
        local coords = GetEntityCoords(admin)
        local target = GetPlayerPed(player.id)
        SetEntityCoords(target, coords)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncu Çekildi', 'red', string.format('%s adlı oyuncu %s tarafından yanına çekildi', GetPlayerName(player.id), GetPlayerName(src)), false)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:inventory', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['inventory']) or IsPlayerAceAllowed(src, 'command') then
        TriggerClientEvent('qb-admin:client:inventory', src, player.id)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncunun Envanteri açıldı', 'red', string.format('%s adlı oyuncunun envanteri %s tarafından açıldı', GetPlayerName(player.id), GetPlayerName(src)), true)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:cloth', function(player)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions['clothing']) or IsPlayerAceAllowed(src, 'command') then
        TriggerClientEvent('qb-clothing:client:openMenu', player.id)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncuya kıyafet menüsü verildi', 'red', string.format('%s adlı oyuncuya %s tarafından kıyafet menüsü verildi', GetPlayerName(player.id), GetPlayerName(src)), false)
    else
        BanPlayer(src)
    end
end)

RegisterNetEvent('qb-admin:server:setPermissions', function(targetId, group)
    local src = source
    if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
        QBCore.Functions.AddPermission(targetId, group[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.rank_level")..group[1].label)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncuya yetki verildi', 'red', string.format('%s adlı oyuncuya %s tarafından %s yetkisi verildi', GetPlayerName(targetId), GetPlayerName(src), group[1].label), true)
    else
        BanPlayer(src)
    end
end)


RegisterNetEvent('qb-admin:server:setJobs', function(targetId, group, grade)
    local src = source
	local Player = QBCore.Functions.GetPlayer(targetId)
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
       Player.Functions.SetJob(group[1].rank, grade[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.job_level")..group[1].label)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncuya meslek verildi', 'red', string.format('%s adlı oyuncuya %s tarafından %s  %s mesleği verildi', GetPlayerName(targetId), GetPlayerName(src), group[1].label, grade[1].rank), true)
end
end)

RegisterNetEvent('qb-admin:server:setGangs', function(targetId, group, grade)
    local src = source
	local Player = QBCore.Functions.GetPlayer(targetId)
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
       Player.Functions.SetGang(group[1].rank, grade[1].rank)
        TriggerClientEvent('QBCore:Notify', targetId, Lang:t("info.gang_level")..group[1].label)
		TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncuya çete verildi', 'red', string.format('%s adlı oyuncuya %s tarafından %s  %s çetesi verildi', GetPlayerName(targetId), GetPlayerName(src), group[1].label, grade[1].rank), true)
end
end)


RegisterNetEvent('qb-admin:server:givecar', function(player, car, mods, plate)
local cid = QBCore.Functions.GetPlayer(player)
TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Oyuncuya araç verildi', 'red', string.format('%s adlı oyuncuya %s tarafından %s  plakalı  %s  model araç verildi', cid.PlayerData.name, GetPlayerName(source), plate, car), true)
  MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, drivingdistance, state) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            cid.PlayerData.license,
            cid.PlayerData.citizenid,
            car,
            GetHashKey(car),
			json.encode(mods),
            plate,
            753779,
            0
        })
end)

--[[
RegisterNetEvent('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chat:addMessage', src, {
                color = {255, 0, 0},
                multiline = true,
                args = {Lang:t("info.admin_report")..name..' ('..targetSrc..')', msg}
            })
        end
    end
end)
]]

--[[
RegisterServerEvent('qb-admin:giveWeapon', function(weapon)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(weapon, 1)
    else
        BanPlayer(src)
    end
end)
]]


RegisterNetEvent('qb-admin:server:SaveCar', function(mods, vehicle, _, plate)
    local src = source
    if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
        local Player = QBCore.Functions.GetPlayer(src)
        local result = MySQL.query.await('SELECT plate FROM player_vehicles WHERE plate = ?', { plate })
        if result[1] == nil then
            MySQL.insert('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)', {
                Player.PlayerData.license,
                Player.PlayerData.citizenid,
                vehicle.model,
                vehicle.hash,
                json.encode(mods),
                plate,
                0
            })
            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.success_vehicle_owner"), 'success', 5000)
			TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Aracı kendi databasesine verdi', 'red', string.format('%s adlı oyuncu kendisine  %s  plakalı  %s  model aracı databasesine verdi', GetPlayerName(src), plate, vehicle), true)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("error.failed_vehicle_owner"), 'info', 3000)
        end
    else
        BanPlayer(src)
    end
end)

-- Commands

QBCore.Commands.Add('maxmods', Lang:t("desc.max_mod_desc"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:maxmodVehicle', src)
end, 'admin')

QBCore.Commands.Add('blips', Lang:t("commands.blips_for_player"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleBlips', src)
end, 'admin')

QBCore.Commands.Add('names', Lang:t("commands.player_name_overhead"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:toggleNames', src)
end, 'admin')

QBCore.Commands.Add('coords', Lang:t("commands.coords_dev_command"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleCoords', src)
end, 'admin')

QBCore.Commands.Add('noclip', Lang:t("commands.toogle_noclip"), {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:ToggleNoClip', src)
end, 'admin')

QBCore.Commands.Add('admincar', Lang:t("commands.save_vehicle_garage"), {}, false, function(source, _)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, 'admin')

--[[
QBCore.Commands.Add('announce', Lang:t("commands.make_announcement"), {}, false, function(_, args)
    local msg = table.concat(args, ' ')
    if msg == '' then return end
    TriggerClientEvent('chat:addMessage', -1, {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Announcement", msg}
    })
end, 'admin')
]]

QBCore.Commands.Add('admin', Lang:t("commands.open_admin"), {}, false, function(source, _)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, 'admin')

--[[
QBCore.Commands.Add('report', Lang:t("info.admin_report"), {{name='message', help='Message'}}, true, function(source, args)
    local src = source
    local msg = table.concat(args, ' ')
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(src), src, msg)
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report', 'green', '**'..GetPlayerName(source)..'** (CitizenID: '..Player.PlayerData.citizenid..' | ID: '..source..') **Report:** ' ..msg, false)
end)
]]

--[[
QBCore.Commands.Add('staffchat', Lang:t("commands.staffchat_message"), {{name='message', help='Message'}}, true, function(source, args)
    local msg = table.concat(args, ' ')
    local name = GetPlayerName(source)

    local plrs = QBCore.Functions.GetPlayers()

    for i = 1, #plrs, 1 do
        local plr = plrs[i]
        if QBCore.Functions.HasPermission(plr, 'admin') or IsPlayerAceAllowed(plr, 'command') then
            if QBCore.Functions.IsOptin(plr) then
                TriggerClientEvent('chat:addMessage', plr, {
                    color = {255, 0, 0},
                    multiline = true,
                    args = {Lang:t("info.staffchat")..name, msg}
                })
            end
        end
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('givenuifocus', Lang:t("commands.nui_focus"), {{name='id', help='Player id'}, {name='focus', help='Set focus on/off'}, {name='mouse', help='Set mouse on/off'}}, true, function(_, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, 'admin')
]]

--[[
QBCore.Commands.Add('warn', Lang:t("commands.warn_a_player"), {{name='ID', help='Player'}, {name='Reason', help='Mention a reason'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local warnId = 'WARN-'..math.random(1111, 9999)
    if targetPlayer ~= nil then
		TriggerClientEvent('chat:addMessage', targetPlayer.PlayerData.source, { args = { "SYSTEM", Lang:t("info.warning_chat_message")..GetPlayerName(source).."," .. Lang:t("info.reason") .. ": "..msg }, color = 255, 0, 0 })
		TriggerClientEvent('chat:addMessage', source, { args = { "SYSTEM", Lang:t("info.warning_staff_message")..GetPlayerName(targetPlayer.PlayerData.source)..", for: "..msg }, color = 255, 0, 0 })
        MySQL.insert('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (?, ?, ?, ?)', {
            senderPlayer.PlayerData.license,
            targetPlayer.PlayerData.license,
            msg,
            warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('checkwarns', Lang:t("commands.check_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = MySQL.query.await('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has '..tablelength(result)..' warnings!')
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = MySQL.query.await('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', targetPlayer.PlayerData.name..' has been warned by '..sender.PlayerData.name..', Reason: '..warnings[selectedWarning].reason)
        end
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('delwarn', Lang:t("commands.delete_player_warning"), {{name='id', help='Player'}, {name='Warning', help='Number of warning, (1, 2 or 3 etc..)'}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = MySQL.query.await('SELECT * FROM player_warns WHERE targetIdentifier = ?', { targetPlayer.PlayerData.license })
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        TriggerClientEvent('chat:addMessage', source, 'SYSTEM', 'warning', 'You have deleted warning ('..selectedWarning..') , Reason: '..warnings[selectedWarning].reason)
        MySQL.query('DELETE FROM player_warns WHERE warnId = ?', { warnings[selectedWarning].warnId })
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('reportr', Lang:t("commands.reply_to_report"), {{name='id', help='Player'}, {name = 'message', help = 'Message to respond with'}}, false, function(source, args)
    local src = source
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, ' ')
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if msg == '' then return end
    if not OtherPlayer then return TriggerClientEvent('QBCore:Notify', src, 'Player is not online', 'error') end
    if not QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') ~= 1 then return end
    TriggerClientEvent('chat:addMessage', playerId, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Admin Response', msg}
    })
    TriggerClientEvent('chat:addMessage', src, {
        color = {255, 0, 0},
        multiline = true,
        args = {'Report Response ('..playerId..')', msg}
    })
    TriggerClientEvent('QBCore:Notify', src, 'Reply Sent')
    TriggerEvent('qb-log:server:CreateLog', 'report', 'Report Reply', 'red', '**'..GetPlayerName(src)..'** replied on: **'..OtherPlayer.PlayerData.name.. ' **(ID: '..OtherPlayer.PlayerData.source..') **Message:** ' ..msg, false)
end, 'admin')
]]

--[[
QBCore.Commands.Add('setmodel', Lang:t("commands.change_ped_model"), {{name='model', help='Name of the model'}, {name='id', help='Id of the Player (empty for yourself)'}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= '' then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_online"), 'error')
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_model"), 'error')
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('setspeed', Lang:t("commands.set_player_foot_speed"), {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.failed_set_speed"), 'error')
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('reporttoggle', Lang:t("commands.report_toggle"), {}, false, function(source, _)
    local src = source
    QBCore.Functions.ToggleOptin(src)
    if QBCore.Functions.IsOptin(src) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.receive_reports"), 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.no_receive_report"), 'error')
    end
end, 'admin')
]]

--[[
QBCore.Commands.Add('kickall', Lang:t("commands.kick_all"), {}, false, function(source, args)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        if QBCore.Functions.HasPermission(src, 'god') or IsPlayerAceAllowed(src, 'command') then
            if reason and reason ~= '' then
                for _, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player then
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t("info.no_reason_specified"), 'error')
            end
        end
    else
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player then
                DropPlayer(Player.PlayerData.source, Lang:t("info.server_restart") .. QBCore.Config.Server.Discord)
            end
        end
    end
end, 'god')
]]

QBCore.Commands.Add('setammo', Lang:t("commands.ammo_amount_set"), {{name='amount', help='Mermi miktarı, mesela: 20'}, {name='weapon', help='Silahın adı, mesela: WEAPON_VINTAGEPISTOL'}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, 'current', amount)
    end
end, 'admin')

QBCore.Commands.Add('vector2', 'Copy vector2 to clipboard (Admin only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:copyToClipboard', src, 'coords2')
end, 'admin')

QBCore.Commands.Add('vector3', 'Copy vector3 to clipboard (Admin only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:copyToClipboard', src, 'coords3')
end, 'admin')

QBCore.Commands.Add('vector4', 'Copy vector4 to clipboard (Admin only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:copyToClipboard', src, 'coords4')
end, 'admin')

QBCore.Commands.Add('heading', 'Copy heading to clipboard (Admin only)', {}, false, function(source)
    local src = source
    TriggerClientEvent('qb-admin:client:copyToClipboard', src, 'heading')
end, 'admin')

CreateThread(function()
    while true do
        local tempPlayers = {}
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local targetped = GetPlayerPed(v)
            local ped = QBCore.Functions.GetPlayer(v)
            tempPlayers[#tempPlayers + 1] = {
                name = (ped.PlayerData.charinfo.firstname or '') .. ' ' .. (ped.PlayerData.charinfo.lastname or '') .. ' | (' .. (GetPlayerName(v) or '') .. ')',
                id = v,
                coords = GetEntityCoords(targetped),
                cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
                citizenid = ped.PlayerData.citizenid,
                sources = GetPlayerPed(ped.PlayerData.source),
                sourceplayer = ped.PlayerData.source

            }
        end
        -- Sort players list by source ID (1,2,3,4,5, etc) --
        table.sort(tempPlayers, function(a, b)
            return a.id < b.id
        end)
        players = tempPlayers
        Wait(1500)
    end
end)


RegisterServerEvent('qb-adminmenu:server:character')
AddEventHandler('qb-adminmenu:server:character', function(TargetId)
QBCore.Functions.CreateCallback('qb-adminmenu:callback:getplayer', function(target, cb)
    local ped = QBCore.Functions.GetPlayer(TargetId)
    local player = {
        id = TargetId,
        cid = ped.PlayerData.citizenid,
        name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(TargetId) .. ')',
        food = ped.PlayerData.metadata['hunger'],
        water = ped.PlayerData.metadata['thirst'],
        stress = ped.PlayerData.metadata['stress'],
        armor = ped.PlayerData.metadata['armor'],
        phone = ped.PlayerData.charinfo.phone,
        cash = ped.PlayerData.money['cash'],
        bank = ped.PlayerData.money['bank'],
        job = ped.PlayerData.job.label .. ' | ' .. ped.PlayerData.job.grade.level,
        gang = ped.PlayerData.gang.label or 'Yok',
		license = QBCore.Functions.GetIdentifier(TargetId, 'license') or 'Bulunamadı',
        discord = QBCore.Functions.GetIdentifier(TargetId, 'discord') or 'Bulunamadı',
        steam = QBCore.Functions.GetIdentifier(TargetId, 'steam') or 'Bulunamadı',
    }
    cb(player)
  end)
end)