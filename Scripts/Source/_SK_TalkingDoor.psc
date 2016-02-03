scriptname _SK_TalkingDoor extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
	if akActionRef == Game.GetPlayer()
		Utility.Wait(1)
		while PlayerIsInDialogue()
			Utility.Wait(3)
		endWhile
		Utility.Wait(3)
		self.Disable()
		self.Delete()
	endif
EndEvent

function SayGoAway(Topic akTopic)
	self.Say(akTopic)
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