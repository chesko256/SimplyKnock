scriptname _SK_TalkingDoor extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
	if akActionRef == Game.GetPlayer()
		Utility.Wait(1)
		while PlayerIsInDialogue()
			Utility.Wait(3)
		endWhile

		; Make sure dialogue is completely finished playing.
		Utility.Wait(3)

		; A ReferenceAlias will prevent this object from being deleted
		; until the next Talking Door is generated. However, only one
		; will exist at any given time.
		self.Disable()
		self.Delete()
	endif
EndEvent

function SayGoAway(Topic akTopic)
	self.Say(akTopic)

	; Make sure dialogue is completely finished playing.
	Utility.Wait(5)

	self.Disable()
	self.Delete()
endFunction

bool function PlayerIsInDialogue()
	if UI.IsMenuOpen("Dialogue Menu")
		return true
	else
		return false
	endif
endFunction
