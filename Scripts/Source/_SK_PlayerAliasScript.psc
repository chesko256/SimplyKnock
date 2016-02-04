scriptname _SK_PlayerAliasScript extends ReferenceAlias

Actor property PlayerRef auto

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