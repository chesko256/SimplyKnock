scriptname _SK_PlayerAliasScript extends ReferenceAlias

Actor property PlayerRef auto
Perk property _SK_KnockPerk auto
_SK_SkyUIConfigPanelScript property Config auto
SimplyKnockMainScript property Main auto

Event OnInit()
	Config.LoadProfileOnStartup()
	Main.RegisterForCrosshairRef()
	PlayerRef.AddPerk(_SK_KnockPerk)
	Main.BuildVoiceTypeArrays()
endEvent

Event OnPlayerLoadGame()
	Config.LoadProfileOnStartup()
	Main.RegisterForCrosshairRef()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	SendEvent_PlayerLocationChange(akOldLoc)
EndEvent

function SendEvent_PlayerLocationChange(Location akOldLocation)
	int handle = ModEvent.Create("SimplyKnockPlayerLocationChange")
	if handle
		ModEvent.PushForm(handle, akOldLocation)
		ModEvent.Send(handle)
	endif
endFunction