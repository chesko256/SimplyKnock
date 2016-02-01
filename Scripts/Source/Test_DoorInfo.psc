scriptname Test_DoorInfo extends ReferenceAlias

import SimplyKnockSKSEScript

Event OnInit()
	RegisterForCrosshairRef()
EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	debug.trace("Crosshair ref changed to " + ref)
	debug.trace("-----------------------------------------------")
	debug.trace("Actor owner: " + ref.GetActorOwner())
	debug.trace("Faction owner: " + ref.GetFactionOwner())
	debug.trace("Lock level: " + ref.GetLockLevel())
	debug.trace("Linked ref: " + ref.GetLinkedRef())
	debug.trace("Key: " + ref.GetKey())
	debug.trace("Linked door: " + GetLinkedDoor(ref))
EndEvent