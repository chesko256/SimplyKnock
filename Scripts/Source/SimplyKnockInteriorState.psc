scriptname SimplyKnockInteriorState extends ObjectReference

int property NegotiationState = 0 auto hidden
GlobalVariable property _SK_Setting_StateTimeoutDuration auto
GlobalVariable property _SK_Setting_LogLevel auto

; NegotiationState enum
; nsReady 			= 0
; nsSuccess 		= 1
; nsInitialFailure	= 2
; nsFailure 		= 3

Event OnInit()
	DebugLog(0, "New Interior State marker registering for deletion in " + _SK_Setting_StateTimeoutDuration.GetValueInt() + " hours.")
	RegisterForSingleUpdateGameTime(_SK_Setting_StateTimeoutDuration.GetValue())
EndEvent

Event OnUpdateGameTime()
	DebugLog(0, self + " duration timed out, deleting.")
	self.Disable()
	self.Delete()
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