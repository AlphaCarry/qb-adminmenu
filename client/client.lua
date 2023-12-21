local banlength = nil
local developermode = false
local showCoords = false
local vehicleDevMode = false
local banreason = 'Unknown'
local kickreason = 'Unknown'
local menuLocation = 'topright' -- e.g. topright (default), topleft, bottomright, bottomleft

-- Main Menus
local menu1 = MenuV:CreateMenu(false, Lang:t("menu.admin_menu"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test1')
local menu2 = MenuV:CreateMenu(false, Lang:t("menu.admin_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test2')
local menu3 = MenuV:CreateMenu(false, Lang:t("menu.manage_server"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test3')
local menu4 = MenuV:CreateMenu(false, Lang:t("menu.online_players"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test4')
local menu5 = MenuV:CreateMenu(false, Lang:t("menu.vehicle_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test5')
--local menu6 = MenuV:CreateMenu(false, Lang:t("menu.dealer_list"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test6')
local menu7 = MenuV:CreateMenu(false, Lang:t("menu.developer_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test7')

--Sub Menus
local menu8 = MenuV:CreateMenu(false, Lang:t("menu.weather_conditions"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test8')
local menu9 = MenuV:CreateMenu(false, Lang:t("menu.ban"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test9')
local menu10 = MenuV:CreateMenu(false, Lang:t("menu.kick"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test10')
local menu11 = MenuV:CreateMenu(false, Lang:t("menu.permissions"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test11')
local menu12 = MenuV:CreateMenu(false, Lang:t("menu.vehicle_categories"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test12')
local menu13 = MenuV:CreateMenu(false, Lang:t("menu.vehicle_models"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test13')
local menu14 = MenuV:CreateMenu(false, Lang:t("menu.entity_view_options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test14')
local menu15 = MenuV:CreateMenu(false, Lang:t("menu.spawn_weapons"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test15')
local menu16 = MenuV:CreateMenu(false, Lang:t("menu.jobs"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test16')
local menu17 = MenuV:CreateMenu(false, Lang:t("menu.givecar"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test17')
local menu18 = MenuV:CreateMenu(false, Lang:t("menu.givecarcat"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test18')
local menu19 = MenuV:CreateMenu(false, Lang:t("menu.charactermenu"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test19')
local menu20 = MenuV:CreateMenu(false, Lang:t("menu.givecarcat"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test20')
local menu21 = MenuV:CreateMenu(false, Lang:t("menu.gangs"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv', 'test21')

RegisterNetEvent('qb-admin:client:openMenu', function()
    MenuV:OpenMenu(menu1)
end)

--[[
    Main menu buttons
--]]
-- Admin options
menu1:AddButton({
    icon = '😃',
    label = Lang:t("menu.admin_options"),
    value = menu2,
    description = Lang:t("desc.admin_options_desc")
})

--player management
local player_management = menu1:AddButton({
    icon = '🙍‍♂️',
    label = Lang:t("menu.player_management"),
    value = menu4,
    description = Lang:t("desc.player_management_desc")
})

--server management
menu1:AddButton({
    icon = '🎮',
    label = Lang:t("menu.server_management"),
    value = menu3,
    description = Lang:t("desc.server_management_desc")
})

--vehicle spawner
menu1:AddButton({
    icon = '🚗',
    label = Lang:t("menu.vehicles"),
    value = menu5,
    description = Lang:t("desc.vehicles_desc")
})

--dealer list
--[[
local menu1_dealer_list = menu1:AddButton({
    icon = '💊',
    label = Lang:t("menu.dealer_list"),
    value = menu6,
    description = Lang:t("desc.dealer_desc")
})
]]
--developer options
menu1:AddButton({
    icon = '🔧',
    label = Lang:t("menu.developer_options"),
    value = menu7,
    description = Lang:t("desc.developer_desc")
})

--[[
    Sub Menus for the above main menu's
--]]

-- Admin Options Menu Buttons
local menu2_admin_noclip = menu2:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    value = nil,
    description = Lang:t("desc.noclip_desc")
})

local menu2_admin_revive = menu2:AddButton({
    icon = '🏥',
    label = Lang:t("menu.revive"),
    value = 'revive',
    description = Lang:t("desc.revive_desc")
})

local menu_button14 = menu3:AddButton({
     icon = '🚘',
	 label = "Araçları Çek",
	 value = 'çek',
	 description = "Başı boş araçları çeker"
})


local menu2_admin_invisible = menu2:AddCheckbox({
    icon = '👻',
    label = Lang:t("menu.invisible"),
    value = nil,
    description = Lang:t("desc.invisible_desc")
})

local menu2_admin_god_mode = menu2:AddCheckbox({
    icon = '⚡',
    label = Lang:t("menu.god"),
    value = nil,
    description = Lang:t("desc.god_desc")
})

local menu2_admin_display_names = menu2:AddCheckbox({
    icon = '📋',
    label = Lang:t("menu.names"),
    value = nil,
    description = Lang:t("desc.names_desc")
})

local menu2_admin_display_blips = menu2:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.blips"),
    value = nil,
    description = Lang:t("desc.blips_desc")
})

--give weapons
menu2:AddButton({
    icon = '🎁',
    label = Lang:t("menu.spawn_weapons"),
    value = menu15,
    description = Lang:t("desc.spawn_weapons_desc")
})

-- Server Options Menu Buttons
local menu3_server_weather = menu3:AddButton({
    icon = '🌡️',
    label = Lang:t("menu.weather_options"),
    value = menu8,
    description = Lang:t("desc.weather_desc")
})

local menu3_server_time = menu3:AddSlider({
    icon = '⏲️',
    label = Lang:t("menu.server_time"),
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = Lang:t("menu.time")
    }, {
        label = '01',
        value = '01',
        description = Lang:t("menu.time")
    }, {
        label = '02',
        value = '02',
        description = Lang:t("menu.time")
    }, {
        label = '03',
        value = '03',
        description = Lang:t("menu.time")
    }, {
        label = '04',
        value = '04',
        description = Lang:t("menu.time")
    }, {
        label = '05',
        value = '05',
        description = Lang:t("menu.time")
    }, {
        label = '06',
        value = '06',
        description = Lang:t("menu.time")
    }, {
        label = '07',
        value = '07',
        description = Lang:t("menu.time")
    }, {
        label = '08',
        value = '08',
        description = Lang:t("menu.time")
    }, {
        label = '09',
        value = '09',
        description = Lang:t("menu.time")
    }, {
        label = '10',
        value = '10',
        description = Lang:t("menu.time")
    }, {
        label = '11',
        value = '11',
        description = Lang:t("menu.time")
    }, {
        label = '12',
        value = '12',
        description = Lang:t("menu.time")
    }, {
        label = '13',
        value = '13',
        description = Lang:t("menu.time")
    }, {
        label = '14',
        value = '14',
        description = Lang:t("menu.time")
    }, {
        label = '15',
        value = '15',
        description = Lang:t("menu.time")
    }, {
        label = '16',
        value = '16',
        description = Lang:t("menu.time")
    }, {
        label = '17',
        value = '17',
        description = Lang:t("menu.time")
    }, {
        label = '18',
        value = '18',
        description = Lang:t("menu.time")
    }, {
        label = '19',
        value = '19',
        description = Lang:t("menu.time")
    }, {
        label = '20',
        value = '20',
        description = Lang:t("menu.time")
    }, {
        label = '21',
        value = '21',
        description = Lang:t("menu.time")
    }, {
        label = '22',
        value = '22',
        description = Lang:t("menu.time")
    }, {
        label = '23',
        value = '23',
        description = Lang:t("menu.time")
    }}
})

-- Vehicle Spawner Menu Buttons
local menu5_vehicles_spawn = menu5:AddButton({
    icon = '🚗',
    label = Lang:t("menu.spawn_vehicle"),
    value = menu12,
    description = Lang:t("desc.spawn_vehicle_desc")
})

local menu5_vehicles_fix = menu5:AddButton({
    icon = '🔧',
    label = Lang:t("menu.fix_vehicle"),
    value = 'fix',
    description = Lang:t("desc.fix_vehicle_desc")
})

local menu5_vehicles_buy = menu5:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    value = 'buy',
    description = Lang:t("desc.buy_desc")
})

local menu5_vehicles_remove = menu5:AddButton({
    icon = '🗑️',
    label = Lang:t("menu.remove_vehicle"),
    value = 'remove',
    description = Lang:t("desc.remove_vehicle_desc")
})

local menu5_vehicles_max_upgrades = menu5:AddButton({
    icon = '⚡️',
    label = Lang:t("menu.max_mods"),
    value = 'maxmods',
    description = Lang:t("desc.max_mod_desc")
})

-- Developer Options Menu Buttons
local menu7_dev_copy_vec3 = menu7:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_vector3"),
    value = 'coords',
    description = Lang:t("desc.vector3_desc")
})

local menu7_dev_copy_vec4 = menu7:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_vector4"),
    value = 'coords',
    description = Lang:t("desc.vector4_desc")
})

local menu7_dev_copy_heading = menu7:AddButton({
    icon = '📋',
    label = Lang:t("menu.copy_heading"),
    value = 'heading',
    description = Lang:t("desc.copy_heading_desc")
})

local menu7_dev_toggle_coords = menu7:AddCheckbox({
    icon = '📍',
    label = Lang:t("menu.display_coords"),
    value = nil,
    description = Lang:t("desc.display_coords_desc")
})

local menu7_dev_vehicle_mode = menu7:AddCheckbox({
    icon = '🚘',
    label = Lang:t("menu.vehicle_dev_mode"),
    value = nil,
    description = Lang:t("desc.vehicle_dev_mode_desc")
})

local menu7_dev_info_mode = menu7:AddCheckbox({
    icon = '⚫',
    label = Lang:t("menu.hud_dev_mode"),
    value = nil,
    description = Lang:t("desc.hud_dev_mode_desc")
})

local menu7_dev_noclip = menu7:AddCheckbox({
    icon = '🎥',
    label = Lang:t("menu.noclip"),
    value = nil,
    description = Lang:t("desc.noclip_desc")
})

--create dev entity view
menu7:AddButton({
    icon = '🔍',
    label = Lang:t("menu.entity_view_options"),
    value = menu14,
    description = Lang:t("desc.entity_view_desc")
})

--[[
    QB Core Admin Menu button functions below.
--]]

--[[
    General Functions
--]]
local function LocalInput(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
    end

    if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
        return result
    end
end

local function LocalInputInt(text, number, windows)
    AddTextEntry("FMMC_MPM_NA", text)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return tonumber(result)
    end
end

--[[
    Admin Options functions
--]]
-- Toggle player name display
menu2_admin_display_names:On('change', function()
    TriggerEvent('qb-admin:client:toggleNames')
end)

-- Toggle player blip display
menu2_admin_display_blips:On('change', function()
    TriggerEvent('qb-admin:client:toggleBlips')
end)

-- Toggle NoClip
menu2_admin_noclip:On('change', function(_, _, _)
    ToggleNoClip()
	TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Noclip Açıldı', 'red', string.format('%s adlı oyuncu noclip açtı', GetPlayerName(src)), false)
end)

-- Revive Self
menu2_admin_revive:On('select', function(_)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

-- Invisible
local invisible = false
menu2_admin_invisible:On('change', function(_, _, _)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Godmode
local godmode = false
menu2_admin_god_mode:On('change', function(_, _, _)
    godmode = not godmode

    if godmode then
        while godmode do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

-- Weapons list
for _,v in pairs(QBCore.Shared.Weapons) do
QBCore.Functions.TriggerCallback('qb-admin:server:getgodperm', function(rank)
 if rank then
    menu15:AddButton({icon = '🎁',
        label = v.label ,
        value = v.value ,
        description = Lang:t("desc.spawn_weapons_desc"),
        select = function(_)
            TriggerServerEvent('qb-admin:giveWeapon', v.name)
            QBCore.Functions.Notify(Lang:t("success.spawn_weapon"))
        end
    })
	end
   end)
end


--[[
    Player Management Options functions
--]]
-- Player List
local function OpenPermsMenu(permsply)
    QBCore.Functions.TriggerCallback('qb-admin:server:getadminperm', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu11)
            menu11:ClearItems()
            menu11:AddSlider({
                icon = '',
                label = 'Yetki',
                value = 'user',
                values = {{
                    label = 'Oyuncu',
                    value = 'user',
                    description = 'Group'
                }, {
                    label = 'Admin',
                    value = 'admin',
                    description = 'Group'
                }, {
                    label = 'Yönetici',
                    value = 'god',
                    description = 'Group'
                }},
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "user", label = "Oyuncu"}
                    elseif vcal == 2 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "admin", label = "Admin"}
                    elseif vcal == 3 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "god", label = "Yönetici"}
                    end
                end
            })

            menu11:AddButton({
                icon = '',
                label = Lang:t("info.confirm"),
                value = "giveperms",
                description = 'Oyuncunun yetkisini düzenle',
                select = function(_)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('qb-admin:server:setPermissions', permsply.id, selectedgroup)
                        QBCore.Functions.Notify(Lang:t("success.changed_perm"), 'success')
                        selectedgroup = 'Unknown'
                    else
                        QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'info')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu1)
        end
    end)
end


-- Set vehicle Categories
local vehicles = {}
for k, v in pairs(QBCore.Shared.Vehicles) do
    local category = v["category"]
    if vehicles[category] == nil then
        vehicles[category] = { }
    end
    vehicles[category][k] = v
end

-- Car Categories
local function OpenCarModelsMenu(category)
    menu13:ClearItems()
    MenuV:OpenMenu(menu13)
    for k, v in pairs(category) do
        menu13:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function(_)
                TriggerServerEvent('QBCore:CallCommand', "car", { k })
				TriggerEvent('qb-log:server:CreateLog', 'adminmenu', 'Araç Çıkardı', 'red', string.format('%s adlı oyuncu  %s  model aracı çıkarttı', GetPlayerName(src), k), false)
            end
        })
    end
end

menu5_vehicles_spawn:On('Select', function(_)
    menu12:ClearItems()
    for k, v in pairs(vehicles) do
        menu12:AddButton({
            label = k,
            value = v,
            description = Lang:t("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)


local function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu10)
    menu10:ClearItems()
    menu10:AddButton({
        icon = '',
        label = Lang:t("info.reason"),
        value = "reason",
        description = Lang:t("desc.kick_reason"),
        select = function(_)
            kickreason = LocalInput(Lang:t("desc.kick_reason"), 255)
        end
    })

    menu10:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "kick",
        description = Lang:t("desc.confirm_kick"),
        select = function(_)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('qb-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                QBCore.Functions.Notify(Lang:t("error.missing_reason"), 'info')
            end
        end
    })
end

local function OpenJobsMenu(jobsply)
   QBCore.Functions.TriggerCallback('qb-admin:server:getadminperm', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu16)
            menu16:ClearItems()
            menu16:AddSlider({
                icon = '',
                label = 'Meslek',
                value = 'sivil',
                values = {{
                    label = 'Sivil',
                    value = 'unemployed',
                    description = 'Group'
				}, {
                    label = 'Polis',
                    value = 'police',
                    description = 'Group'
				}, {
                    label = 'EMS',
                    value = 'ambulance',
                    description = 'Group'
				},{
                    label = 'Adalet Bakanlığı',
                    value = 'lawyer',
                    description = 'Group'
				}, {
                    label = 'Bennys Mekanik',
                    value = 'mechanic1',
                    description = 'Group'
                }, {
                    label = 'Alpha Mekanik',
                    value = 'mechanic2',
                    description = 'Group'
				}, {
                    label = 'Super Mekanik',
                    value = 'mechanic3',
                    description = 'Group'
				}, {
                    label = 'Performans Mekanik',
                    value = 'mechanic4',
                    description = 'Group'
				}, {
                    label = 'DreamWork Mekanik',
                    value = 'mechanic5',
                    description = 'Group'
				}, {
                    label = 'East Customs Mekanik',
                    value = 'mechanic6',
                    description = 'Group'
				}, {
                    label = 'BurgerShot',
                    value = 'burgershot',
                    description = 'Group'
                },{
                    label = 'Bahamas',
                    value = 'bahamas',
                    description = 'Group'
                },{
                    label = 'Emlakçı',
                    value = 'realestate',
                    description = 'Group'
                },{
                    label = 'Taksi',
                    value = 'taxi',
                    description = 'Group'
                },{
                    label = 'Galerici',
                    value = 'cardealer',
                    description = 'Group'
                },{
                    label = 'Silahçı 1',
                    value = 'gunshop1',
                    description = 'Group'
                },{
                    label = 'Silahçı 2',
                    value = 'gunshop2',
                    description = 'Group'
                },{
                    label = 'Silahçı 3',
                    value = 'gunshop3',
                    description = 'Group'
                },{
                    label = 'Silahçı 4',
                    value = 'gunshop4',
                    description = 'Group'
                },{
                    label = 'Silahçı 5',
                    value = 'gunshop5',
                    description = 'Group'
                },{
                    label = 'Silahçı 6',
                    value = 'gunshop6',
                    description = 'Group'
                },{
                    label = 'Silahçı 7',
                    value = 'gunshop7',
                    description = 'Group'
                },{
                    label = 'Nargile',
                    value = 'hookah',
                    description = 'Group'
                },{
                    label = 'Esrar Satış',
                    value = 'esrar',
                    description = 'Group'
                },{
                    label = 'Esrar Satış 2',
                    value = 'esrar2',
                    description = 'Group'
                },{
                    label = 'Kokain Satış',
                    value = 'kokain',
                    description = 'Group'
                },{
                    label = 'Meth Satış',
                    value = 'meth',
                    description = 'Group'
                },{
                    label = 'Kaçakçı',
                    value = 'kacakcı',
                    description = 'Group'
                },{
                    label = 'Hurdacı',
                    value = 'hurdacı',
                    description = 'Group'
                }
				},
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "unemployed", label = "Sivil"}
					elseif vcal == 2 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "police", label = "Polis"}
					elseif vcal == 3 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "ambulance", label = "EMS"}
					elseif vcal == 4 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "lawyer", label = "Aadalet Bakanlığı"}
                    elseif vcal == 5 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mechanic1", label = "Bennys Mekanik"}
                    elseif vcal == 6 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mechanic2", label = "Alpha Mekanik"}
					elseif vcal == 7 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mechanic3", label = "Super Mekanik"}
					elseif vcal == 8 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mechanic4", label = "Performans Mekanik"}
					elseif vcal == 9 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mechanic5", label = "DreamWorks Mekanik"}
					elseif vcal == 10 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "mechanic6", label = "East Customs Mekanik"}
					elseif vcal == 11 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "burgershot", label = "Burgershot"}
					elseif vcal == 12 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "bahamas", label = "Bahamas"}
					elseif vcal == 13 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "realestate", label = "Emlakçı"}
					elseif vcal == 14 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "taxi", label = "Taksi"}
					elseif vcal == 15 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "cardealer", label = "Galerici"}
					elseif vcal == 16 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop1", label = "Silahçı 1"}
					elseif vcal == 17 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop2", label = "Silahçı 2"}
					elseif vcal == 18 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop3", label = "Silahçı 3"}
					elseif vcal == 19 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop4", label = "Silahçı 4"}
					elseif vcal == 20 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop5", label = "Silahçı 5"}
					elseif vcal == 21 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop6", label = "Silahçı 6"}
					elseif vcal == 22 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "gunshop7", label = "Silahçı 7"}
					elseif vcal == 23 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "hookah", label = "Nargile"}
					elseif vcal == 24 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "esrar", label = "Esrar Satış"}
					elseif vcal == 25 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "esrar2", label = "Esrar Satış 2"}
					elseif vcal == 26 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "kokain", label = "Kokain Satış"}
					elseif vcal == 27 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "meth", label = "Meth Satış"}
					elseif vcal == 28 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "kacakcı", label = "Kaçakçı"}
					elseif vcal == 29 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "hurdacı", label = "Hurdacı"}
                    end
                end
            })
			
			menu16:AddSlider({
                icon = '',
                label = 'Rütbe',
                value = '0',
                values = {{
                    label = '0',
                    value = '0',
                    description = 'Rütbe'
                }, {
                    label = '1',
                    value = '1',
                    description = 'Rütbe'
                }, {
                    label = '2',
                    value = '2',
                    description = 'Rütbe'
				}, {
                    label = '3',
                    value = '3',
                    description = 'Rütbe'
				}, {
                    label = '4',
                    value = '4',
                    description = 'Rütbe'
				}, {
                    label = '5',
                    value = '5',
                    description = 'Rütbe'
				}, {
                    label = '6',
                    value = '6',
                    description = 'Rütbe'
				}, {
                    label = '7',
                    value = '7',
                    description = 'Rütbe'
				}, {
                    label = '8',
                    value = '8',
                    description = 'Rütbe'
				}, {
                    label = '9',
                    value = '9',
                    description = 'Rütbe'
				}, {
                    label = '10',
                    value = '2',
                    description = 'Rütbe'
				}, {
                    label = '11',
                    value = '11',
                    description = 'Rütbe'
				}, {
                    label = '12',
                    value = '12',
                    description = 'Rütbe'
				}, {
                    label = '13',
                    value = '13',
                    description = 'Rütbe'
				}, {
                    label = '14',
                    value = '14',
                    description = 'Rütbe'
				}, {
                    label = '15',
                    value = '15',
                    description = 'Rütbe'
				}, {
                    label = '16',
                    value = '16',
                    description = 'Rütbe'
				}, {
                    label = '17',
                    value = '17',
                    description = 'Rütbe'
				}, {
                    label = '18',
                    value = '18',
                    description = 'Rütbe'
				}, {
                    label = '19',
                    value = '19',
                    description = 'Rütbe'
				}, {
                    label = '20',
                    value = '20',
                    description = 'Rütbe'
				}, {
                    label = '21',
                    value = '21',
                    description = 'Rütbe'
                }},
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "0", label = "0"}
                    elseif vcal == 2 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "1", label = "1"}
                    elseif vcal == 3 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "2", label = "2"}
					elseif vcal == 4 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "3", label = "3"}
					elseif vcal == 5 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "4", label = "4"}
					elseif vcal == 6 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "5", label = "5"}
					elseif vcal == 7 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "6", label = "6"}
					elseif vcal == 8 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "7", label = "7"}
					elseif vcal == 9 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "8", label = "8"}
					elseif vcal == 10 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "9", label = "9"}
					elseif vcal == 11 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "10", label = "10"}
					elseif vcal == 12 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "11", label = "11"}
					elseif vcal == 13 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "12", label = "12"}
					elseif vcal == 14 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "13", label = "13"}
					elseif vcal == 15 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "14", label = "14"}
					elseif vcal == 16 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "15", label = "15"}
					elseif vcal == 17 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "16", label = "16"}
					elseif vcal == 18 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "17", label = "17"}
					elseif vcal == 19 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "18", label = "18"}
					elseif vcal == 20 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "19", label = "19"}
					elseif vcal == 21 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "20", label = "20"}
					elseif vcal == 22 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "21", label = "21"}
                    end
                end
            })
            menu16:AddButton({
                icon = '',
                label = Lang:t("info.confirm"),
                value = "givejobs",
                description = 'Meslek ver',
                select = function(_)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('qb-admin:server:setJobs', jobsply.id, selectedgroup, selectedgrade )
			            QBCore.Functions.Notify(Lang:t("success.changed_job"), 'success')
                        selectedgroup = 'Unknown'
                    else
                        QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'info')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu)
        end
    end)
end


local function OpenGangsMenu(gangsply)
   QBCore.Functions.TriggerCallback('qb-admin:server:getadminperm', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu21)
            menu21:ClearItems()
            menu21:AddSlider({
                icon = '',
                label = 'Aile/Çete',
                value = 'sivil',
                values = {{
                    label = 'Yok',
                    value = 'none',
                    description = 'Group'
				}, {
                    label = 'Ballas',
                    value = 'ballas',
                    description = 'Group'
				}, {
                    label = 'Vagos',
                    value = 'vagos',
                    description = 'Group'
				}, {
                    label = 'Families',
                    value = 'families',
                    description = 'Group'
                }, {
                    label = 'Triads',
                    value = 'triads',
                    description = 'Group'
				}, {
                    label = 'Vamora Ailesi',
                    value = 'aile1',
                    description = 'Group'
				}, {
                    label = 'Milanov Ailesi',
                    value = 'aile2',
                    description = 'Group'
				}, {
                    label = 'Winchester Ailesi',
                    value = 'aile3',
                    description = 'Group'
				}, {
                    label = 'Sarsılmaz Ailesi',
                    value = 'aile4',
                    description = 'Group'
				}, {
                    label = 'Mendez Ailesi',
                    value = 'aile5',
                    description = 'Group'
                },{
                    label = 'Maraz Ailesi',
                    value = 'aile6',
                    description = 'Group'
                },{
                    label = 'Favela',
                    value = 'custom1',
                    description = 'Group'
                },{
                    label = 'Black',
                    value = 'custom2',
                    description = 'Group'
                },{
                    label = '35st',
                    value = 'custom3',
                    description = 'Group'
                }
				},
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "none", label = "Yok"}
					elseif vcal == 2 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "ballas", label = "Ballas"}
					elseif vcal == 3 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "vagos", label = "Vagos"}
                    elseif vcal == 4 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "families", label = "Families"}
                    elseif vcal == 5 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "triads", label = "Triads"}
					elseif vcal == 6 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "aile1", label = "Vamora Ailesi"}
					elseif vcal == 7 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "aile2", label = "Milanov Ailesi"}
					elseif vcal == 8 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "aile3", label = "Winchester Ailesi"}
					elseif vcal == 9 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "aile4", label = "Sarsılmaz Ailesi"}
					elseif vcal == 10 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "aile5", label = "Mendez Ailesi"}
					elseif vcal == 11 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "aile6", label = "Maraz Ailesi"}
					elseif vcal == 12 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "custom1", label = "Favela"}
					elseif vcal == 13 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "custom2", label = "Black"}
					elseif vcal == 14 then
                        selectedgroup = {}
                        selectedgroup[#selectedgroup+1] = {rank = "custom3", label = "35st"}
                    end
                end
            })
			
			menu21:AddSlider({
                icon = '',
                label = 'Rütbe',
                value = '0',
                values = {{
                    label = '0',
                    value = '0',
                    description = 'Rütbe'
                }, {
                    label = '1',
                    value = '1',
                    description = 'Rütbe'
                }, {
                    label = '2',
                    value = '2',
                    description = 'Rütbe'
				}, {
                    label = '3',
                    value = '3',
                    description = 'Rütbe'
				}},
                change = function(_, newValue, _)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "0", label = "0"}
                    elseif vcal == 2 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "1", label = "1"}
                    elseif vcal == 3 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "2", label = "2"}
					elseif vcal == 4 then
                        selectedgrade = {}
                        selectedgrade[#selectedgrade+1] = {rank = "3", label = "3"}
                    end
                end
            })
            menu21:AddButton({
                icon = '',
                label = Lang:t("info.confirm"),
                value = "givegangs",
                description = 'Aile/Çete ver',
                select = function(_)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('qb-admin:server:setGangs', gangsply.id, selectedgroup, selectedgrade )
			            QBCore.Functions.Notify(Lang:t("success.changed_gang"), 'success')
                        selectedgroup = 'Unknown'
                    else
                        QBCore.Functions.Notify(Lang:t("error.changed_perm_failed"), 'info')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu)
        end
    end)
end


local function OpenCharacterMenu(player)
menu19:ClearItems()
TriggerServerEvent('qb-adminmenu:server:character', player.id)
QBCore.Functions.TriggerCallback('qb-adminmenu:callback:getplayer', function(player)
MenuV:OpenMenu(menu19)
local elements = {
        [1] = {
            label = 'Adı: ' ..player.name,
            description = "Karakter Adı",
            value = 'name'
        },
        [2] = {
            label =  'Açlık: ' ..player.food.. '%',
            description = "Karakterin Açlığı",
            value = 'food'
        },
		[3] = {
            label = 'Susuzluk:' ..player.water.. '%',
            description = "Karakterin Susuzluğu",
            value = 'water'
        },
        [4] = {
            label = 'Stres: ' ..player.stress.. '%',
            description = "Karakterin Stresi",
            value = 'stress'
        },
        [5] = {
            label = 'Zırh: ' ..player.armor.. '%',
            description = "Karakterin Zırhı",
            value = 'armor'
        },
        [6] = {
            label = 'Telefon: ' ..player.phone,
            description = "Karakterin Telefon Numarası",
            value = 'phone'
        },
        [7] = {
            label = 'Nakit: ' ..player.cash..' $',
            description = "Karakterin Nakit Bakiyesi",
            value = 'cash'
        },
        [8] = {
            label = 'Banka: ' ..player.bank..' $',
            description = "Karakterin Banka Bakiyesi",
            value = 'bank'
        },
        [9] = {
            label = 'Meslek: ' ..player.job,
            description = "Karakterin Mesleği",
            value = 'job'
        },
        [10] = {
            label = 'Çete: ' ..player.gang,
            description = "Karakterin Bulunduğu Çete",
            value = 'gang'
        },
        [11] = {
            label = 'Fivem: ' ..player.license,
            description = "Karakterin Fivem Hesabı",
            value = 'license'
        },
        [12] = {
            label = 'Discord: ' ..player.discord,
            description = "Karakterin Discordu",
            value = 'discord'
        },
        [13] = {
            label = 'Steam: ' ..player.steam,
            description = "Karakterin Steamı",
            value = 'steam'
        },
    }
    for _, v in ipairs(elements) do
       menu19:AddButton({
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
        })
    end
  end)
end





local function OpenGiveCarModelsMenu(category, player)
    menu20:ClearItems()
    MenuV:OpenMenu(menu20)
    for k, v in pairs(category) do
        menu20:AddButton({
             label = v["name"],
             value = k,
             description = 'Spawn ' .. v["name"],
             select = function(_)
			 local ped = PlayerPedId(player)
			 local hash = GetHashKey(k)
			 if not IsModelInCdimage(hash) then return end
				RequestModel(hash)
				while not HasModelLoaded(hash) do
				Wait(100)
				end
				
				if IsPedInAnyVehicle(ped) then
				DeleteVehicle(vehicle)
				end
			 local vehicle = CreateVehicle(hash, GetEntityCoords(ped), GetEntityHeading(ped), true, false)
			 local plate = QBCore.Functions.GetPlate(vehicle)
			 TaskWarpPedIntoVehicle(ped, vehicle, -1)
			 exports['cc-fuel']:SetFuel(vehicle, 100)
			 local props = QBCore.Functions.GetVehicleProperties(vehicle)
				 TriggerServerEvent('qb-admin:server:givecar', player.id, k, props, plate)
				 print(player.id)
             end
        })
    end
end


local function OpenCarMenu(player)
QBCore.Functions.TriggerCallback('qb-admin:server:getgodperm', function(rank)
 if rank then
menu18:ClearItems()
 MenuV:OpenMenu(menu18)
    for k, v in pairs(vehicles) do
        menu18:AddButton({
            label = k,
            value = v,
            description = Lang:t("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenGiveCarModelsMenu(select, player)
            end
        })
    end
  end
  end)
end



local function OpenBanMenu(banplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    menu9:AddButton({
        icon = '',
        label = Lang:t("info.reason"),
        value = "reason",
        description = Lang:t("desc.ban_reason"),
        select = function(_)
            banreason = LocalInput(Lang:t("desc.ban_reason"), 255)
        end
    })

    menu9:AddSlider({
        icon = '⏲️',
        label = Lang:t("info.length"),
        value = '3600',
        values = {{
            label = Lang:t("time.1day"),
            value = '86400',
            description = Lang:t("time.ban_length")
        },{
            label = Lang:t("time.2day"),
            value = '172800',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.3day"),
            value = '259200',
            description = Lang:t("time.ban_length")
        },{
            label = Lang:t("time.5day"),
            value = '432000',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1week"),
            value = '604800',
            description = Lang:t("time.ban_length")
        },{
            label = Lang:t("time.2week"),
            value = '1209600',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1month"),
            value = '2678400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.3month"),
            value = '8035200',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.6month"),
            value = '16070400',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.1year"),
            value = '32140800',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.permenent"),
            value = '99999999999',
            description = Lang:t("time.ban_length")
        }, {
            label = Lang:t("time.self"),
            value = "self",
            description = Lang:t("time.ban_length")
        }},
        select = function(_, newValue, _)
            if newValue == "self" then
                banlength = LocalInputInt('Ban Length', 11)
            else
                banlength = newValue
            end
        end
    })

    menu9:AddButton({
        icon = '',
        label = Lang:t("info.confirm"),
        value = "ban",
        description = Lang:t("desc.confirm_ban"),
        select = function(_)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('qb-admin:server:ban', banplayer, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                QBCore.Functions.Notify(Lang:t("error.invalid_reason_length_ban"), 'info')
            end
        end
    })
end

local function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid .. " " ..Lang:t("info.options"), menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local elements = {
        [1] = {
            icon = '💀',
            label = Lang:t("menu.kill"),
            value = "kill",
            description = Lang:t("menu.kill").. " " .. player.cid
        },
        [2] = {
            icon = '🏥',
            label = Lang:t("menu.revive"),
            value = "revive",
            description = Lang:t("menu.revive") .. " " .. player.cid
        },
        [3] = {
            icon = '🥶',
            label = Lang:t("menu.freeze"),
            value = "freeze",
            description = Lang:t("menu.freeze") .. " " .. player.cid
        },
        [4] = {
            icon = '👀',
            label = Lang:t("menu.spectate"),
            value = "spectate",
            description = Lang:t("menu.spectate") .. " " .. player.cid
        },
        [5] = {
            icon = '➡️',
            label = Lang:t("info.goto"),
            value = "goto",
            description = Lang:t("info.goto") .. " " .. player.cid .. Lang:t("info.position")
        },
        [6] = {
            icon = '⬅️',
            label = Lang:t("menu.bring"),
            value = "bring",
            description = Lang:t("menu.bring") .. " " .. player.cid .. " " .. Lang:t("info.your_position")
        },
        [7] = {
            icon = '🚗',
            label = Lang:t("menu.sit_in_vehicle"),
            value = "intovehicle",
            description = Lang:t("desc.sit_in_veh_desc") .. " " .. player.cid .. " " .. Lang:t("desc.sit_in_veh_desc2")
        },
        [8] = {
            icon = '🎒',
            label = Lang:t("menu.open_inv"),
            value = "inventory",
            description = Lang:t("info.open") .. " " .. player.cid .. Lang:t("info.inventories")
        },
        [9] = {
            icon = '👕',
            label = Lang:t("menu.give_clothing_menu"),
            value = "cloth",
            description = Lang:t("desc.clothing_menu_desc") .. " " .. player.cid
        },
        [10] = {
            icon = '🥾',
            label = Lang:t("menu.kick"),
            value = "kick",
            description = Lang:t("menu.kick") .. " " .. player.cid .. " " .. Lang:t("info.reason")
        },
        [11] = {
            icon = '🚫',
            label = Lang:t("menu.ban"),
            value = "ban",
            description = Lang:t("menu.ban") .. " " .. player.cid .. " " .. Lang:t("info.reason")
        },
        [12] = {
            icon = '🎟️',
            label = Lang:t("menu.permissions"),
            value = "perms",
            description = Lang:t("info.give") .. " " .. player.cid .. " " .. Lang:t("menu.permissions")
        },
		[13] = {
            icon = '📋',
            label = Lang:t("menu.jobs"),
            value = "jobs",
            description = Lang:t("info.give") .. " " .. player.cid .. " " .. Lang:t("menu.jobs")
        },
		[14] = {
            icon = '📋',
            label = Lang:t("menu.gangs"),
            value = "gangs",
            description = Lang:t("info.give") .. " " .. player.cid .. " " .. Lang:t("menu.gangs")
        },
		[15] = {
            icon = '🚗',
            label = Lang:t("menu.givecar"),
            value = "givecarmenu",
            description = Lang:t("menu.givecar") .. " " .. player.cid
        },
		[16] = {
            icon = '🎟️',
            label = "Karakter",
            value = "character",
            description = "Karakter Bilgileri" .. " " .. player.cid
        }
    }
    for _, v in ipairs(elements) do
        Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values ~= "ban" and values ~= "kick" and values ~= "perms" and values ~= "jobs" and values ~= "gangs" and values ~= "givecarmenu" and values ~= "character" then
                    TriggerServerEvent('qb-admin:server:'..values, player)
                elseif values == "ban" then
                    OpenBanMenu(player)
                elseif values == "kick" then
                    OpenKickMenu(player)
                elseif values == "perms" then
                    OpenPermsMenu(player)
				elseif values == "jobs" then
                    OpenJobsMenu(player)
				elseif values == "gangs" then
                    OpenGangsMenu(player)
				elseif values == "givecarmenu" then
                    OpenCarMenu(player)
				elseif values == "character" then
                    OpenCharacterMenu(player)
                end
            end
        })
    end
end

player_management:On('select', function(_)
    menu4:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for _, v in pairs(players) do
            menu4:AddButton({
                label = Lang:t("info.id") .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = Lang:t("info.player_name"),
                select = function(btn)
                    local select = btn.Value -- get all the values from v!
                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            }) -- WORKS
        end
    end)
end)


--[[
    Server Options functions
--]]

-- Adjust weather on change
menu3_server_weather:On("select",function()
    menu8:ClearItems()
    local elements = {
        [1] = {
            icon = '☀️',
            label = Lang:t("weather.extra_sunny"),
            value = "EXTRASUNNY",
            description = Lang:t("weather.extra_sunny_desc")
        },
        [2] = {
            icon = '☀️',
            label = Lang:t("weather.clear"),
            value = "CLEAR",
            description = Lang:t("weather.clear_desc")
        },
        [3] = {
            icon = '☀️',
            label = Lang:t("weather.neutral"),
            value = "NEUTRAL",
            description = Lang:t("weather.neutral_desc")
        },
        [4] = {
            icon = '🌁',
            label = Lang:t("weather.smog"),
            value = "SMOG",
            description = Lang:t("weather.smog_desc")
        },
        [5] = {
            icon = '🌫️',
            label = Lang:t("weather.foggy"),
            value = "FOGGY",
            description = Lang:t("weather.foggy_desc")
        },
        [6] = {
            icon = '⛅',
            label = Lang:t("weather.overcast"),
            value = "OVERCAST",
            description = Lang:t("weather.overcast_desc")
        },
        [7] = {
            icon = '☁️',
            label = Lang:t("weather.clouds"),
            value = "CLOUDS",
            description = Lang:t("weather.clouds_desc")
        },
        [8] = {
            icon = '🌤️',
            label = Lang:t("weather.clearing"),
            value = "CLEARING",
            description = Lang:t("weather.clearing_desc")
        },
        [9] = {
            icon = '☂️',
            label = Lang:t("weather.rain"),
            value = "RAIN",
            description = Lang:t("weather.rain_desc")
        },

        [10] = {
            icon = '⛈️',
            label = Lang:t("weather.thunder"),
            value = "THUNDER",
            description = Lang:t("weather.thunder_desc")
        },
        [11] = {
            icon = '❄️',
            label = Lang:t("weather.snow"),
            value = "SNOW",
            description = Lang:t("weather.snow_desc")
        },
        [12] = {
            icon = '🌨️',
            label = Lang:t("weather.blizzard"),
            value = "BLIZZARD",
            description = Lang:t("weather.blizzed_desc")
        },
        [13] = {
            icon = '❄️',
            label = Lang:t("weather.light_snow"),
            value = "SNOWLIGHT",
            description = Lang:t("weather.light_snow_desc")
        },
        [14] = {
            icon = '🌨️',
            label = Lang:t("weather.heavy_snow"),
            value = "XMAS",
            description = Lang:t("weather.heavy_snow_desc")
        },
        [15] = {
            icon = '🎃',
            label = Lang:t("weather.halloween"),
            value = "HALLOWEEN",
            description = Lang:t("weather.halloween_desc")
        }
    }
    for _, v in ipairs(elements) do
        menu8:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
            local selection = btn.Value
            TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            QBCore.Functions.Notify(Lang:t("weather.weather_changed", {value = selection.label}))
        end})
    end
end)

-- Adjust time on change
menu3_server_time:On("select", function(_, value)
    TriggerServerEvent("qb-weathersync:server:setTime", value, value)
    QBCore.Functions.Notify(Lang:t("time.changed", {time = value}))
end)

--[[
    Vehicle Spawner functions
--]]



menu5_vehicles_fix:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

menu5_vehicles_buy:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

menu5_vehicles_remove:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)

menu5_vehicles_max_upgrades:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "maxmods", {})
end)

--[[
    Developer Options functions
--]]
local entity_view_distance = menu14:AddSlider({
    icon = '📏',
    label = Lang:t("menu.entity_view_distance"),
    value = GetCurrentEntityViewDistance(),
    values = {{
        label = '5',
        value = '5',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '10',
        value = '10',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '15',
        value = '15',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '20',
        value = '20',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '25',
        value = '25',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '30',
        value = '30',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '35',
        value = '35',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '40',
        value = '40',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '45',
        value = '45',
        description = Lang:t("menu.entity_view_distance")
    }, {
        label = '50',
        value = '50',
        description = Lang:t("menu.entity_view_distance")
    }}
})

local entity_view_copy_info = menu14:AddButton({
    icon = '📋',
    label = Lang:t("menu.entity_view_freeaim_copy"),
    value = 'freeaimEntity',
    description = Lang:t("desc.entity_view_freeaim_copy_desc")
})

local entity_view_freeaim = menu14:AddCheckbox({
    icon = '🔫',
    label = Lang:t("menu.entity_view_freeaim"),
    value = nil,
    description = Lang:t("desc.entity_view_freeaim_desc")
})

local entity_view_vehicle = menu14:AddCheckbox({
    icon = '🚗',
    label = Lang:t("menu.entity_view_vehicles"),
    value = nil,
    description = Lang:t("desc.entity_view_vehicles_desc")
})

local entity_view_ped = menu14:AddCheckbox({
    icon = '🧍‍♂‍',
    label = Lang:t("menu.entity_view_peds"),
    value = nil,
    description = Lang:t("desc.entity_view_peds_desc")
})

local entity_view_object = menu14:AddCheckbox({
    icon = '📦',
    label = Lang:t("menu.entity_view_objects"),
    value = nil,
    description = Lang:t("desc.entity_view_objects_desc")
})

menu7_dev_info_mode:On('change', function(_, _, _)
    developermode = not developermode
    TriggerEvent('qb-admin:client:ToggleDevmode')
    if developermode then
	SetPlayerInvincible(PlayerId(), true)
    else
	SetPlayerInvincible(PlayerId(), false)
    end
end)

entity_view_freeaim:On('change', function(_, _, _)
    ToggleEntityFreeView()
end)

local function CopyToClipboard(dataType)
    local ped = PlayerPedId()
    if dataType == 'coords2' then
        local coords = GetEntityCoords(ped)
        local x = QBCore.Shared.Round(coords.x, 2)
        local y = QBCore.Shared.Round(coords.y, 2)
        SendNUIMessage({
            string = string.format('vector2(%s, %s)', x, y)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'coords3' then
        local coords = GetEntityCoords(ped)
        local x = QBCore.Shared.Round(coords.x, 2)
        local y = QBCore.Shared.Round(coords.y, 2)
        local z = QBCore.Shared.Round(coords.z, 2)
        SendNUIMessage({
            string = string.format('vector3(%s, %s, %s)', x, y, z)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'coords4' then
        local coords = GetEntityCoords(ped)
        local x = QBCore.Shared.Round(coords.x, 2)
        local y = QBCore.Shared.Round(coords.y, 2)
        local z = QBCore.Shared.Round(coords.z, 2)
        local heading = GetEntityHeading(ped)
        local h = QBCore.Shared.Round(heading, 2)
        SendNUIMessage({
            string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
        })
        QBCore.Functions.Notify(Lang:t("success.coords_copied"), "success")
    elseif dataType == 'heading' then
        local heading = GetEntityHeading(ped)
        local h = QBCore.Shared.Round(heading, 2)
        SendNUIMessage({
            string = h
        })
        QBCore.Functions.Notify(Lang:t("success.heading_copied"), "success")
    elseif dataType == 'freeaimEntity' then
        local entity = GetFreeAimEntity()

        if entity then
            local entityHash = GetEntityModel(entity)
            local entityName = Entities[entityHash] or "Unknown"
            local entityCoords = GetEntityCoords(entity)
            local entityHeading = GetEntityHeading(entity)
            local entityRotation = GetEntityRotation(entity)
            local x = QBCore.Shared.Round(entityCoords.x, 2)
            local y = QBCore.Shared.Round(entityCoords.y, 2)
            local z = QBCore.Shared.Round(entityCoords.z, 2)
            local rotX = QBCore.Shared.Round(entityRotation.x, 2)
            local rotY = QBCore.Shared.Round(entityRotation.y, 2)
            local rotZ = QBCore.Shared.Round(entityRotation.z, 2)
            local h = QBCore.Shared.Round(entityHeading, 2)
            SendNUIMessage({
                string = string.format('Model Name:\t%s\nModel Hash:\t%s\n\nHeading:\t%s\nCoords:\t\tvector3(%s, %s, %s)\nRotation:\tvector3(%s, %s, %s)', entityName, entityHash, h, x, y, z, rotX, rotY, rotZ)
            })
            QBCore.Functions.Notify(Lang:t("success.entity_copy"), "success")
        else
            QBCore.Functions.Notify(Lang:t("error.failed_entity_copy"), "info")
        end
    end
end

RegisterNetEvent('qb-admin:client:copyToClipboard', function(dataType)
    CopyToClipboard(dataType)
end)

local function Draw2DText(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end

local function ToggleShowCoordinates()
    local x = 0.4
    local y = 0.025
    showCoords = not showCoords
    CreateThread(function()
        while showCoords do
            local coords = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local c = {}
            c.x = QBCore.Shared.Round(coords.x, 2)
            c.y = QBCore.Shared.Round(coords.y, 2)
            c.z = QBCore.Shared.Round(coords.z, 2)
            heading = QBCore.Shared.Round(heading, 2)
            Wait(0)
            Draw2DText(string.format('~w~'..Lang:t("info.ped_coords") .. '~b~ vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, heading), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
        end
    end)
end

local function ToggleVehicleDeveloperMode()
    local x = 0.4
    local y = 0.888
    vehicleDevMode = not vehicleDevMode
    CreateThread(function()
        while vehicleDevMode do
            local ped = PlayerPedId()
            Wait(0)
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local netID = VehToNet(vehicle)
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local eHealth = GetVehicleEngineHealth(vehicle)
                local bHealth = GetVehicleBodyHealth(vehicle)
                Draw2DText(Lang:t("info.vehicle_dev_data"), 4, {66, 182, 245}, 0.4, x + 0.0, y + 0.0)
                Draw2DText(string.format(Lang:t("info.ent_id") .. '~b~%s~s~ | ' .. Lang:t("info.net_id") .. '~b~%s~s~', vehicle, netID), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.025)
                Draw2DText(string.format(Lang:t("info.model") .. '~b~%s~s~ | ' .. Lang:t("info.hash") .. '~b~%s~s~', modelName, hash), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.050)
                Draw2DText(string.format(Lang:t("info.eng_health") .. '~b~%s~s~ | ' .. Lang:t("info.body_health") .. '~b~%s~s~', QBCore.Shared.Round(eHealth, 2), QBCore.Shared.Round(bHealth, 2)), 4, {255, 255, 255}, 0.4, x + 0.0, y + 0.075)
            end
        end
    end)
end

RegisterNetEvent('qb-admin:client:ToggleCoords', function()
    ToggleShowCoordinates()
end)

menu7_dev_copy_vec3:On("select", function()
    CopyToClipboard('coords3')
end)

menu7_dev_copy_vec4:On("select", function()
    CopyToClipboard('coords4')
end)

menu7_dev_copy_heading:On("select", function()
    CopyToClipboard('heading')
end)

entity_view_copy_info:On("select", function()
    CopyToClipboard('freeaimEntity')
end)

menu7_dev_vehicle_mode:On('change', function()
    ToggleVehicleDeveloperMode()
end)

menu7_dev_noclip:On('change', function(_, _, _)
    ToggleNoClip()
end)

menu7_dev_toggle_coords:On('change', function()
    ToggleShowCoordinates()
end)

entity_view_distance:On("select", function(_, value)
    SetEntityViewDistance(value)
    QBCore.Functions.Notify(Lang:t("info.entity_view_distance", {distance = value}))
end)

entity_view_vehicle:On('change', function()
    ToggleEntityVehicleView()
end)

entity_view_object:On('change', function()
    ToggleEntityObjectView()
end)

entity_view_ped:On('change', function()
    ToggleEntityPedView()
end)


--Araç Çek

menu_button14:On('select', function(_)
   TriggerEvent('okokDelVehicles:delete', -1)
end)

--[[
    Dealer List
--]]

--[[
local function OpenDealerMenu(dealer)
    local EditDealer = MenuV:CreateMenu(false, Lang:t("menu.edit_dealer") .. dealer["name"], menuLocation, 220, 20, 60, 'size-125', 'none', 'menuv')
    EditDealer:ClearItems()
    MenuV:OpenMenu(EditDealer)
    local elements = {
        [1] = {
            icon = '➡️',
            label = Lang:t("info.goto") .. " " .. dealer["name"],
            value = "goto",
            description = Lang:t("desc.dealergoto_desc") .. " " .. dealer["name"]
        },
        [2] = {
            icon = "☠",
            label = Lang:t("info.remove") .. " " .. dealer["name"],
            value = "remove",
            description = Lang:t("desc.dealerremove_desc") .. " " .. dealer["name"]
        }
    }
    for _, v in ipairs(elements) do
        EditDealer:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values == "goto" then
                    TriggerServerEvent('QBCore:CallCommand', "dealergoto", { dealer["name"] })
                elseif values == "remove" then
                    TriggerServerEvent('QBCore:CallCommand', "deletedealer", { dealer["name"] })
                    EditDealer:Close()
                    menu6:Close()
                end
            end
        })
    end
end



menu1_dealer_list:On('Select', function(_)
    menu6:ClearItems()
    QBCore.Functions.TriggerCallback('test:getdealers', function(dealers)
        for _, v in pairs(dealers) do
            menu6:AddButton({
                label = v["name"],
                value = v,
                description = Lang:t("menu.dealer_name"),
                select = function(btn)
                    local select = btn.Value
                    OpenDealerMenu(select)
                end
            })
        end
    end)
end)
]]