scriptname SimplyKnockMainScript extends Quest

import SimplyKnockSKSE

Actor property PlayerRef auto
int property FormType_kNPC = 43 autoReadOnly
Perk property _SK_KnockPerk auto
SimplyKnockConditions property Conditions auto

VoiceType property FemaleYoungEager auto
VoiceType property MaleSlyCynical auto

Activator property _SK_Talk_FemaleYoungEager auto
Activator property _SK_Talk_MaleSlyCynical auto

; If a friend is in the cell, the friend always wins.
; If the door has a specific actor owner, look for that actor.
; If the door has a faction owner, look for actors in that faction.

; TEST CODE
Event OnInit()
	RegisterForCrosshairRef()
	PlayerRef.AddPerk(_SK_KnockPerk)
EndEvent

Event OnCrosshairRefChange(ObjectReference ref)
	if ref
		if ref.GetBaseObject() as Door
			if GetLinkedDoor(ref)
				Conditions.HasLinkedDoor = true
			else
				Conditions.HasLinkedDoor = false
			endif
		endif
	endif
EndEvent

; Called from Perk
function KnockOnDoor(ObjectReference akDoor)
	debug.trace("Knocking...")
	ObjectReference linked_door = GetLinkedDoor(akDoor)
	if !linked_door
		; Shouldn't get here; we should verify whether or not
		; the door has a linked door before we call KnockOnDoor().
		debug.trace("This door isn't linked!")
		return
	endif
	
	ActorBase actor_owner = linked_door.GetActorOwner()
	Actor found_actor = None
	if actor_owner
		found_actor = KnockOnDoor_ActorOwner(linked_door, actor_owner)
	else
		found_actor = KnockOnDoor_FactionOwner(linked_door)
	endif

	if found_actor
		Activator talking_door = GetTalkingDoor(found_actor.GetVoiceType())
		ObjectReference my_talking_door = akDoor.PlaceAtMe(talking_door)
		Utility.Wait(1)
		my_talking_door.Activate(PlayerRef)
	else
		NoAnswer()
	endif
endFunction

Actor function KnockOnDoor_ActorOwner(ObjectReference linked_door, ActorBase actor_owner)
	debug.trace("Looking for actor owner...")
	Cell linked_cell = linked_door.GetParentCell()
	Actor actor_owner_ref_in_cell = GetActorOwnerInCell(actor_owner, linked_cell)
	if actor_owner_ref_in_cell
		if IsFriendsWithPlayer(actor_owner_ref_in_cell)
			debug.trace("I found actor owner " + actor_owner.GetName() + " inside owned cell " + linked_cell + ". We're friends!")
			return actor_owner_ref_in_cell
		else
			debug.trace("I found actor owner " + actor_owner.GetName() + " inside owned cell " + linked_cell + ".")
			return actor_owner_ref_in_cell
		endif
	else
		debug.trace("I couldn't find the owner inside.")
		return None
	endif
endFunction

Activator function GetTalkingDoor(VoiceType akVoiceType)
	;/if akVoiceType == FemaleYoungEager
		return _SK_Talk_FemaleYoungEager
	elseif akVoiceType == MaleSlyCynical
		return _SK_Talk_MaleSlyCynical
	endif
	/;

	return _SK_Talk_FemaleYoungEager
endFunction

Actor function KnockOnDoor_FactionOwner(ObjectReference linked_door)
	debug.trace("Looking for faction owner...")
	Cell linked_cell = linked_door.GetParentCell()
	Faction faction_owner = linked_door.GetFactionOwner()

	if !faction_owner
		debug.trace("This door has no ownership!")
		return None
	endif
	
	Actor[] present_owners = GetCellFactionOwnersInCell(faction_owner, linked_cell)
	if !present_owners
		debug.trace("I couldn't find any faction owners inside.")
		return None
	endif

	int present_owner_count = ArrayCount(present_owners)
	if present_owner_count == 0
		return None
	endif

	int idx = Utility.RandomInt(0, present_owner_count - 1)
	Actor chosen_owner = present_owners[idx]

	if chosen_owner
		if IsFriendsWithPlayer(chosen_owner)
			debug.trace("I found actor owner " + chosen_owner.GetActorBase().GetName() + " of faction " + faction_owner + " inside owned cell " + linked_cell + ". We're friends!")
			return chosen_owner
		else
			debug.trace("I found actor owner " + chosen_owner.GetActorBase().GetName() + " of faction " + faction_owner + " inside owned cell " + linked_cell + ".")
			return chosen_owner
		endif
	else
		return None
	endif
endFunction

function TalkToCellOwner()

endFunction

function NoAnswer()
	debug.trace("No answer...")
endFunction

bool function IsFriendsWithPlayer(Actor akActor)
	if akActor.GetRelationshipRank(PlayerRef) >= 1
		return true
	else
		return false
	endif
endFunction

Actor function GetActorOwnerInCell(ActorBase akActorBase, Cell akCell)
	int actor_count = akCell.GetNumRefs(FormType_kNPC)

	int i = 0
	while i < actor_count
		Actor actor_ref = akCell.GetNthRef(i, FormType_kNPC) as Actor
		if actor_ref.GetActorBase() == akActorBase
			return actor_ref
		endif
		i += 1
	endWhile

	return None
endFunction

Actor[] function GetCellFactionOwnersInCell(Faction akFaction, Cell akCell)
	; Find all of the faction owners currently in this cell. Bias towards
	; returning friends of the player. Filter out children.

	Actor[] found_actors = new Actor[16]
	Actor[] found_friends = new Actor[16]

	int actor_count = akCell.GetNumRefs(FormType_kNPC)
	debug.trace("There were " + actor_count + " actors in " + akCell)
	if actor_count == 0
		; Return the empty array
		return found_actors
	endif

	int i = 0
	while i < actor_count
		Actor possible_owner = akCell.GetNthRef(i, FormType_kNPC) as Actor
		bool is_child = possible_owner.IsChild()
		if !is_child && possible_owner.IsInFaction(akFaction)
			int idx = ArrayCount(found_actors)
			if idx < 16
				found_actors[idx] = possible_owner
			endif

			; Is this a friend?
			if IsFriendsWithPlayer(possible_owner)
				int jdx = ArrayCount(found_friends)
				if jdx < 16
					found_friends[jdx] = possible_owner
				endif
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

int function ArrayCount(Actor[] myArray) global
; Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"
 
	int i = 0
	int myCount = 0
	while i < myArray.Length
		if myArray[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction