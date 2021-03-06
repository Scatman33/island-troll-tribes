library MedallionCourage initializer onInit requires ID, PublicLibrary

function Trig_Medallion_Courage_Conditions takes nothing returns boolean
  return GetSpellAbilityId() == SPELL_SUPERSUB_COURAGE
endfunction

//===========================================================================
function Trig_Medallion_Courage_Actions takes nothing returns nothing
  local unit COURAGEOUS_UNIT = GetSpellAbilityUnit()
  local integer UNIT_TYPE = GetUnitTypeId(COURAGEOUS_UNIT)
  local integer MEDAL_EU = 0

  if UNIT_TYPE == UNIT_GATHERER then
    if GetUnitAbilityLevelSwapped(ABILITY_MEU_OMNIGATHERER, COURAGEOUS_UNIT) == 0 then
      set MEDAL_EU = ABILITY_MEU_OMNIGATHERER
    endif
  elseif UNIT_TYPE == UNIT_THIEF then
    if GetUnitAbilityLevelSwapped(ABILITY_MEU_ASSASSIN, COURAGEOUS_UNIT) == 0 then
      set MEDAL_EU = ABILITY_MEU_ASSASSIN
    endif
  elseif UNIT_TYPE == UNIT_SCOUT then
    if GetUnitAbilityLevelSwapped(ABILITY_MEU_SPY, COURAGEOUS_UNIT) == 0 then
      set MEDAL_EU = ABILITY_MEU_SPY
    endif
  elseif UNIT_TYPE == UNIT_MAGE then
    if GetUnitAbilityLevelSwapped(ABILITY_MEU_DEMENTIA_MASTER, COURAGEOUS_UNIT) == 0 then
      set MEDAL_EU = ABILITY_MEU_DEMENTIA_MASTER
    endif
  elseif UNIT_TYPE == UNIT_PRIEST then
    if GetUnitAbilityLevelSwapped(ABILITY_MEU_SAGE, COURAGEOUS_UNIT) == 0 then
      set MEDAL_EU = ABILITY_MEU_SAGE
    endif
  endif

  if MEDAL_EU != 0 then
    call removeItem(COURAGEOUS_UNIT, ITEM_MEDALLION_COURAGE)
    call SetPlayerAbilityAvailableBJ( false, MEDAL_EU, GetOwningPlayer(COURAGEOUS_UNIT) )
    call UnitAddAbilityBJ( MEDAL_EU, COURAGEOUS_UNIT )
  endif

  set COURAGEOUS_UNIT = null
endfunction

//===========================================================================
private function onInit takes nothing returns nothing
    local trigger T = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(T, EVENT_PLAYER_UNIT_SPELL_CAST)
    call TriggerAddCondition( T, Condition(function Trig_Medallion_Courage_Conditions ) )
    call TriggerAddAction( T, function Trig_Medallion_Courage_Actions )

    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(0))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(1))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(2))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(3))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(4))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(5))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(6))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(7))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(8))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(9))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(10))
    call SetPlayerAbilityAvailableBJ(false, ABILITY_MEU_DUMMY, Player(11))
endfunction

endlibrary
