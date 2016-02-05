scriptname _SK_DoorAliasScript extends ReferenceAlias

Actor property PlayerRef auto
GlobalVariable property _SK_Setting_LogLevel auto

Event OnLockStateChanged()
	ObjectReference the_door = self.GetRef()
	if the_door.IsLocked()
		if the_door.GetParentCell() == PlayerRef.GetParentCell()
			; Try to keep the door unlocked when the player is in the cell. Actors may run packages that re-lock it from time to time.
			DebugLog(0, "Linked door was re-locked with player in cell. Unlocking door as owner.")
			the_door.Lock(false, true)
		endif
	endif
EndEvent

function DebugLog(int aiSeverity, string asLogMessage)
	int LOG_LEVEL = _SK_Setting_LogLevel.GetValueInt()
	if LOG_LEVEL <= aiSeverity
		if aiSeverity == 0
			debug.trace("[SimplyKnock][Debug] " + asLogMessage)
		elseif aiSeverity == 1
			debug.trace("[SimplyKnock][Info] " + asLogMessage)
		elseif aiSeverity == 2
			debug.trace("[SimplyKnock][Warning] " + asLogMessage)
		elseif aiSeverity == 3
			debug.trace("[SimplyKnock][ERROR] " + asLogMessage)
		endif
	endif
endFunction