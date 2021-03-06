
//
// real_random
//===========================================================================
//TESH.scrollpos=3
//TESH.alwaysfold=0
library GAMEMODULES requires PublicLibrary


function IncreaseMaxHeat takes nothing returns nothing
    if GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD) > 0 then
        call SetPlayerStateBJ( GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, udg_MAX_HEAT )
    endif
endfunction

function GameModes_Action takes string conStr, player p returns nothing
local integer pid = GetPlayerId(p)
local string s = StringCase(conStr,false)
local integer i = 0
local string display = ""
local string color = ENERGY_COLOR
local boolean bool = false

// POSITIVE
if s=="-safe" then
    set udg_STAT_LOWER_INTERVAL = 4.50 //normal 3
    set display = "Safe mode|r has been enabled. Stats degrade slower. 4.5 sec/decay."
elseif s=="-increase pets" then
    set udg_PET_CHANCE = 0.23 //.17
    set display = "Increased Pet|r mode has been enabled. Pets now appear way more frequently. 23%."
elseif s=="-rpg" then
    set udg_PET_GROWTH = 0.03
    set display = "Pet Growth Chance|r has been increased to 30%."
elseif s=="-lavish" and modeAllow[0] then
    set udg_FOOD_BASE = 1.80
    set udg_FOOD_FOR_KILL_PROPORTION = 1.30
    set udg_Lavish = true
    set display = "Reverse Famine|r has been enabled. More animals spawn and they give more food."
    set modeAllow[0] = false
elseif s=="-rfl" and modeAllow[2] then
    set udg_ANIMAL_MAX = 480
    set udg_FISH_MAX = 320
    set display = "Food limits|r have been increased. More animals and fish can be on the map at the same time."
    set modeAllow[2] = false
elseif s=="-fast" and modeAllow[3] then
    set udg_ITEM_BASE = 1.50
    set udg_FAST_MODE = true
    set display = "Fast mode|r has been enabled. More items spawn at once."
    set modeAllow[3] = false
elseif s=="-ril" and modeAllow[4] then
    set udg_ITEM_MAX = 700
    set display = "Item limits|r have been increased."
    set modeAllow[4] = false
elseif s=="-nil" and modeAllow[5]then
    set udg_ITEM_LIMIT_MODE = false
    set display = "Inventory Limits|r have been taken off. Trolls can now carry any number of axes/spells/armor."
    set modeAllow[5] = false
 
 
elseif s=="-cm" then // NEGATIVE
    set udg_HEAT_PER_CAST = 5
    set display = "|c00007bffCold mode|r has been enabled. Fires heat people up slower now. Heat per cast is 5."
elseif s=="-dh" then
    set udg_MAX_HEAT = 75
    call ForForce( bj_FORCE_ALL_PLAYERS, function IncreaseMaxHeat )
    set display = "|c00ff0000Heat Max|r has been |c00755d00decreased|r. Heat capacity is 75."
elseif s=="-survival" and modeAllow[8]then
    set udg_FOOD_BASE = 0.40
    set udg_FOOD_FOR_KILL_PROPORTION = 0.80
    set udg_ITEM_BASE = 0.80
    set udg_FAST_MODE = false
    set udg_HEAT_PER_CAST = 4
    set display = "Survival of the fittest has been activated. This mode combines famine, cold, and slow mode."
    set modeAllow[8] = false
elseif s=="-panic" and modeAllow[9]then
    set udg_STAT_LOWER_INTERVAL = 2.30
    set display = "|c00000000Panic mode|r has been enabled. Stats degrade faster now."
    set modeAllow[9] = false
elseif s=="-double" and modeAllow[10]then
    set udg_STAT_DEGRADE_AMOUNT = 2
    set display = "|c00140000Double Degrade| 2 has been enabled. Stats lower by twice as much."
    set modeAllow[10] = false
elseif s=="-famine" and modeAllow[11]then
    set udg_FOOD_BASE = 0.40
    set udg_FOOD_FOR_KILL_PROPORTION = 0.80
    set udg_Famine = true
    set display = "|c00800040Famine mode|r has been enabled. Animals spawn less."
    set modeAllow[11] = false
elseif s=="-famine2x" and modeAllow[12]then
    set udg_FOOD_BASE = 0.20
    set udg_FOOD_FOR_KILL_PROPORTION = 0.60
    set display = "|c00800040Ultra Famine|r mode has been enabled. Animals spawn less."
    set modeAllow[12] = false
elseif s=="-slow" and modeAllow[13]then
    set udg_ITEM_BASE = 0.80
    set udg_FAST_MODE = false
    set display = "|c00ae4946Slow mode|r has been enabled. Less items spawn at once."
    set modeAllow[13] = false
elseif s=="-decrease pets" and modeAllow[14]then
    set udg_PET_CHANCE = 0.07
    set display = "|c008a4a28Decreased Pet|r mode has been enabled. Pets now appear less frequently."
    set modeAllow[14] = false
elseif s=="-lfl" and modeAllow[15]then
    set udg_ANIMAL_MAX = 60
    set udg_FISH_MAX = 50
    set display = "Food limits have been |c00755d00decreased|r."
    set modeAllow[15] = false
elseif s=="-lil" and modeAllow[16]then
    set udg_ITEM_MAX = 250
    set display = "Item limits have been |c00755d00decreased|r."
    set modeAllow[16] = false


elseif s=="-no shields" and modeAllow[22] then
    set allow_Shields = false
    set display = "Shield type items have been disabled from creation."
    set modeAllow[22] = false
elseif s=="-test mode" and modeAllow[24] then
    set modeAllow[24] = false
    set i = 4
    loop
        exitwhen i > 11
        if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and GetPlayerController(Player(i)) == MAP_CONTROL_USER then
            call DisplayTimedTextToPlayer(p,0,0,7,"You can not enable this mode. It only works with no players in slots 5-12" )
            set bool = true
        endif
        set i = i + 1
    endloop
    if not bool then
        set display = "Test Mode has been enabled. There are now no win conditions: the game will not end. You will also be given a spirit ward to start with."
        set modeAllow[27] = false // disables 6v6
        set udg_NOOB_MODE = true
        call CreateItem( ITEM_SPIRIT_WARD_KIT, GetRectCenterX(gg_rct_revive_1), GetRectCenterY(gg_rct_revive_1) )
    endif
endif

if display != "" then
    call DisplayText(color+display+"|r")
    set currentModes = currentModes+color+display+"|r\n"
endif

endfunction

endlibrary

function GameModes_Conditions takes nothing returns boolean
    return not udg_STARTED and mode_enter
endfunction
    
function GameModes_Relay takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local string str = GetEventPlayerChatString()
    call GameModes_Action(str, p)
endfunction

globals
    boolean AllowTrade = true
    boolean allow_Shields = true
    boolean BETA = false
endglobals

globals
    player modePlayer
    boolean array modeAllow
    string currentModes = ""
endglobals

//call TriggerRegisterPlayerChatEvent( gg_trg_GameModes, modePlayer, "-", false )
//===========================================================================
function InitTrig_GameModes takes nothing returns nothing
    local integer i = 0
    loop
        exitwhen i > 40
        set modeAllow[i] = true
        set i = i + 1
    endloop
    call TriggerAddCondition( gg_trg_GameModes, Condition( function GameModes_Conditions ) )
    call TriggerAddAction( gg_trg_GameModes, function GameModes_Relay )
endfunction

//===========================================================================
