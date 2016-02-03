scriptname SimplyKnockInteriorState extends ObjectReference

int property NegotiationState = 0 auto hidden
GlobalVariable property _SK_Setting_StateTimeoutDuration auto

; NegotiationState enum
; nsReady 			= 0
; nsSuccess 		= 1
; nsInitialFailure	= 2
; nsFailure 		= 3

Event OnInit()
	RegisterForSingleUpdateGameTime(_SK_Setting_StateTimeoutDuration.GetValue())
EndEvent

Event OnUpdateGameTime()
	self.Disable()
	self.Delete()
EndEvent
