scriptname _SK_PlayerAliasScript extends ReferenceAlias

Actor property PlayerRef auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	if !PlayerRef.IsInInterior()
		(self.GetOwningQuest() as SimplyKnockMainScript).ClearAllowedEntry()
	endif
EndEvent
