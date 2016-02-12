scriptname SimplyKnockInteriorState extends ObjectReference

Actor property PlayerRef auto
int property NegotiationState = 0 auto hidden
Location property InteriorLocation auto hidden
ReferenceAlias property OwnerAlias auto
ReferenceAlias property DoorAlias auto
GlobalVariable property _SK_Setting_LastResultValue auto 	; 1 = Failed, 2 = Succeeded
GlobalVariable property _SK_Setting_SuccessTimeoutDuration auto
GlobalVariable property _SK_Setting_FailureTimeoutDuration auto
GlobalVariable property _SK_Setting_LogLevel auto


; NegotiationState enum
; nsReady 			= 0
; nsSuccess 		= 1
; nsInitialFailure	= 2
; nsFailure 		= 3

Event OnInit()
	RegisterForModEvent("SimplyKnockPlayerLocationChange", "PlayerLocationChange")
	SetTimeout()
EndEvent

Event OnUpdateGameTime()
	DebugLog(0, self + " duration timed out, deleting.")
	; Give the player's followers time to exit.
	RegisterForSingleUpdate(8)
EndEvent

Event OnUpdate()
	ClearAllowedEntryAndDelete()
EndEvent

Event PlayerLocationChange(Form akOldLocation)
	DebugLog(0, "State marker: location changed.")
	if (akOldLocation as Location) == InteriorLocation
		DebugLog(0, "Clear entry and delete.")
		; Give the player's followers time to exit.
		RegisterForSingleUpdate(8)
	endif
endEvent

function SetTimeout()
	int result_value = _SK_Setting_LastResultValue.GetValueInt()
	float timeout_duration
	if result_value == 1
		timeout_duration = _SK_Setting_FailureTimeoutDuration.GetValue()
	elseif result_value == 2
		timeout_duration = _SK_Setting_SuccessTimeoutDuration.GetValue()
	endif
	RegisterForSingleUpdateGameTime(timeout_duration)
	DebugLog(0, "New Interior State marker registering for deletion in " + timeout_duration + " hours.")
endFunction

function ClearAllowedEntryAndDelete()
	Actor owner = OwnerAlias.GetActorRef()
	if owner
		OwnerAlias.Clear()
		; Force to re-eval package stack. Should cause door to get locked behind player.
		owner.EvaluatePackage()
	endif

	if DoorAlias.GetRef()
		DoorAlias.GetRef().GetParentCell().SetPublic(false)
		DoorAlias.Clear()
	endif

	; DEPRECATED ver. 1.0.1
	if EntryFaction
		PlayerRef.RemoveFromFaction(EntryFaction)
	endif
	EntryFaction = None

	InteriorLocation = None
	NegotiationState = 0
	
	UnregisterForAllModEvents()
	UnregisterForUpdateGameTime()
	UnregisterForUpdate()

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

; DEPRECATED ver. 1.0.1
Faction property EntryFaction auto hidden