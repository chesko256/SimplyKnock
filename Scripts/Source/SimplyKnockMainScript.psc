scriptname SimplyKnockMainScript extends Quest

import SimplyKnockSKSE

function TalkToCellOwner()

endFunction

; If a friend is in the cell, the friend always wins.
; If the door has a specific actor owner, look for that actor.
; If the door has a faction owner, look for actors in that faction.

bool function IsActorOwnerInCell(Actor akActor, Cell akCell)
	int actor_count = akCell.GetNumRefs(FormType.kNPC)

	int i = 0
	while i < actor_count
		if akCell.GetNthRef(i, FormType.kNPC) == akActor
			return true
		endif
		i += 1
	endWhile

	return false
endFunction

Actor[] function GetCellFactionOwnersInCell(Faction akFaction, Cell akCell)
	; Find all of the faction owners currently in this cell. Bias towards
	; returning friends of the player.

	Actor[] found_actors = new Actor[16]
	Actor[] found_friends = new Actor[16]

	int actor_count = akCell.GetNumRefs(FormType.kNPC)
	if actor_count == 0
		return None
	endif

	int i = 0
	while i < actor_count && i < found_actors.Length && i < i < found_friends.Length
		Actor possible_owner = akCell.GetNthRef(i, FormType.kNPC)
		if possible_owner.IsInFaction(akFaction)
			found_actors[i] = possible_owner

			; Is this a friend?
			if possible_owner.GetRelationshipRank(PlayerRef) >= 1
				found_friends[i] = possible_owner
			endif
		endif
		i += 1
	endWhile

	if found_friends[0] != None
		return found_friends
	else
		return found_actors
	endif
endFunction

function MakeCellPublic()

endFunction