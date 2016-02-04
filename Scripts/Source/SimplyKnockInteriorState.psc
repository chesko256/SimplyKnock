scriptname SimplyKnockInteriorState extends ObjectReference

Actor property PlayerRef auto
int property NegotiationState = 0 auto hidden
Faction property EntryFaction auto hidden
Location property InteriorLocation auto hidden
ReferenceAlias property OwnerAlias auto
ReferenceAlias property DoorAlias auto
GlobalVariable property _SK_Setting_StateTimeoutDuration auto
GlobalVariable property _SK_Setting_LogLevel auto

; NegotiationState enum
; nsReady 			= 0
; nsSuccess 		= 1
; nsInitialFailure	= 2
; nsFailure 		= 3

Event OnInit()
	DebugLog(0, "New Interior State marker registering for deletion in " + _SK_Setting_StateTimeoutDuration.GetValueInt() + " hours.")
	RegisterForModEvent("SimplyKnockPlayerLocationChange", "PlayerLocationChange")
	RegisterForSingleUpdateGameTime(_SK_Setting_StateTimeoutDuration.GetValue())
EndEvent

Event OnUpdateGameTime()
	DebugLog(0, self + " duration timed out, deleting.")
	ClearAllowedEntryAndDelete()
EndEvent

Event PlayerLocationChange(Form akOldLocation)
	DebugLog(0, "State marker: location changed.")
	if (akOldLocation as Location) == InteriorLocation
		DebugLog(0, "Clear entry and delete.")
		ClearAllowedEntryAndDelete()
	endif
endEvent

function ClearAllowedEntryAndDelete()
	Actor owner = OwnerAlias.GetActorRef()
	if owner
		OwnerAlias.Clear()
		; Force to re-eval package stack. Should cause door to get locked behind player.
		owner.EvaluatePackage()
	endif

	DoorAlias.Clear()

	if EntryFaction
		PlayerRef.RemoveFromFaction(EntryFaction)
	endif
	EntryFaction = None
	InteriorLocation = None
	NegotiationState = 0
	
	UnregisterForAllModEvents()
	UnregisterForUpdateGameTime()

	DebugLog(0, self + ": Goodbye!")
	self.Disable()
	self.Delete()
endFunction

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