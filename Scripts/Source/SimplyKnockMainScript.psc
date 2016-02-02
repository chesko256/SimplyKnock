scriptname SimplyKnockMainScript extends Quest

import SimplyKnockSKSE
import math

Quest property _SimplyKnockDialogueQuest auto
ReferenceAlias property TalkingDoorAlias auto
ReferenceAlias property FriendAlias auto
Actor property PlayerRef auto
int property FormType_kNPC = 43 autoReadOnly
Perk property _SK_KnockPerk auto
SimplyKnockConditions property Conditions auto
Message property _SK_NoAnswerMsg auto

VoiceType property MaleEvenTonedAccented auto
VoiceType property MaleCommonerAccented auto
VoiceType property MaleGuard auto
VoiceType property MaleForsworn auto
VoiceType property MaleBandit auto
VoiceType property MaleNordCommander auto
VoiceType property MaleSoldier auto
VoiceType property FemaleShrill auto
VoiceType property FemaleDarkElf auto
VoiceType property MaleDarkElf auto
VoiceType property FemaleElfHaughty auto
VoiceType property MaleElfHaughty auto
VoiceType property FemaleArgonian auto
VoiceType property MaleArgonian auto
VoiceType property FemaleKhajiit auto
VoiceType property MaleKhajiit auto
VoiceType property FemaleOrc auto
VoiceType property MaleOrc auto
VoiceType property FemaleNord auto
VoiceType property MaleNord auto
VoiceType property FemaleCoward auto
VoiceType property FemaleCondescending auto
VoiceType property FemaleCommander auto
VoiceType property FemaleOldGrumpy auto
VoiceType property FemaleOldKindly auto
VoiceType property FemaleSultry auto
VoiceType property FemaleCommoner auto
VoiceType property FemaleEvenToned auto
VoiceType property FemaleYoungEager auto
VoiceType property MaleCoward auto
VoiceType property MaleBrute auto
VoiceType property MaleCondescending auto
VoiceType property MaleCommander auto
VoiceType property MaleOldGrumpy auto
VoiceType property MaleSlyCynical auto
VoiceType property MaleDrunk auto
VoiceType property MaleCommoner auto
VoiceType property MaleEvenToned auto
VoiceType property MaleYoungEager auto

Activator property _SK_Door_MaleEvenTonedAccented auto
Activator property _SK_Door_MaleCommonerAccented auto
Activator property _SK_Door_MaleGuard auto
Activator property _SK_Door_MaleForsworn auto
Activator property _SK_Door_MaleBandit auto
Activator property _SK_Door_MaleNordCommander auto
Activator property _SK_Door_MaleSoldier auto
Activator property _SK_Door_FemaleShrill auto
Activator property _SK_Door_FemaleDarkElf auto
Activator property _SK_Door_MaleDarkElf auto
Activator property _SK_Door_FemaleElfHaughty auto
Activator property _SK_Door_MaleElfHaughty auto
Activator property _SK_Door_FemaleArgonian auto
Activator property _SK_Door_MaleArgonian auto
Activator property _SK_Door_FemaleKhajiit auto
Activator property _SK_Door_MaleKhajiit auto
Activator property _SK_Door_FemaleOrc auto
Activator property _SK_Door_MaleOrc auto
Activator property _SK_Door_FemaleNord auto
Activator property _SK_Door_MaleNord auto
Activator property _SK_Door_FemaleCoward auto
Activator property _SK_Door_FemaleCondescending auto
Activator property _SK_Door_FemaleCommander auto
Activator property _SK_Door_FemaleOldGrumpy auto
Activator property _SK_Door_FemaleOldKindly auto
Activator property _SK_Door_FemaleSultry auto
Activator property _SK_Door_FemaleCommoner auto
Activator property _SK_Door_FemaleEvenToned auto
Activator property _SK_Door_FemaleYoungEager auto
Activator property _SK_Door_MaleCoward auto
Activator property _SK_Door_MaleBrute auto
Activator property _SK_Door_MaleCondescending auto
Activator property _SK_Door_MaleCommander auto
Activator property _SK_Door_MaleOldGrumpy auto
Activator property _SK_Door_MaleSlyCynical auto
Activator property _SK_Door_MaleDrunk auto
Activator property _SK_Door_MaleCommoner auto
Activator property _SK_Door_MaleEvenToned auto
Activator property _SK_Door_MaleYoungEager auto


; If a friend is in the cell, the friend always wins.
; If the door has a specific actor owner, look for that actor.
; If the door has a faction owner, look for actors in that faction.

VoiceType[] AllVoiceTypes
Activator[] AllTalkingActivators

; TEST CODE
Event OnInit()
	RegisterForCrosshairRef()
	PlayerRef.AddPerk(_SK_KnockPerk)
	BuildVoiceTypeArrays()
EndEvent

function BuildVoiceTypeArrays()
	AllVoiceTypes = new VoiceType[64]
	AllTalkingActivators = new Activator[64]

	AllVoiceTypes[0] = MaleEvenTonedAccented
	AllVoiceTypes[1] = MaleCommonerAccented
	AllVoiceTypes[2] = MaleGuard
	AllVoiceTypes[3] = MaleForsworn
	AllVoiceTypes[4] = MaleBandit
	AllVoiceTypes[5] = MaleNordCommander
	AllVoiceTypes[6] = MaleSoldier
	AllVoiceTypes[7] = FemaleShrill
	AllVoiceTypes[8] = FemaleDarkElf
	AllVoiceTypes[9] = MaleDarkElf
	AllVoiceTypes[10] = FemaleElfHaughty
	AllVoiceTypes[11] = MaleElfHaughty
	AllVoiceTypes[12] = FemaleArgonian
	AllVoiceTypes[13] = MaleArgonian
	AllVoiceTypes[14] = FemaleKhajiit
	AllVoiceTypes[15] = MaleKhajiit
	AllVoiceTypes[16] = FemaleOrc
	AllVoiceTypes[17] = MaleOrc
	AllVoiceTypes[18] = FemaleNord
	AllVoiceTypes[19] = MaleNord
	AllVoiceTypes[20] = FemaleCoward
	AllVoiceTypes[21] = FemaleCondescending
	AllVoiceTypes[22] = FemaleCommander
	AllVoiceTypes[23] = FemaleOldGrumpy
	AllVoiceTypes[24] = FemaleOldKindly
	AllVoiceTypes[25] = FemaleSultry
	AllVoiceTypes[26] = FemaleCommoner
	AllVoiceTypes[27] = FemaleEvenToned
	AllVoiceTypes[28] = FemaleYoungEager
	AllVoiceTypes[29] = MaleCoward
	AllVoiceTypes[30] = MaleBrute
	AllVoiceTypes[31] = MaleCondescending
	AllVoiceTypes[32] = MaleCommander
	AllVoiceTypes[33] = MaleOldGrumpy
	AllVoiceTypes[34] = MaleSlyCynical
	AllVoiceTypes[35] = MaleDrunk
	AllVoiceTypes[36] = MaleCommoner
	AllVoiceTypes[37] = MaleEvenToned
	AllVoiceTypes[38] = MaleYoungEager

	AllTalkingActivators[0] = _SK_Door_MaleEvenTonedAccented
	AllTalkingActivators[1] = _SK_Door_MaleCommonerAccented
	AllTalkingActivators[2] = _SK_Door_MaleGuard
	AllTalkingActivators[3] = _SK_Door_MaleForsworn
	AllTalkingActivators[4] = _SK_Door_MaleBandit
	AllTalkingActivators[5] = _SK_Door_MaleNordCommander
	AllTalkingActivators[6] = _SK_Door_MaleSoldier
	AllTalkingActivators[7] = _SK_Door_FemaleShrill
	AllTalkingActivators[8] = _SK_Door_FemaleDarkElf
	AllTalkingActivators[9] = _SK_Door_MaleDarkElf
	AllTalkingActivators[10] = _SK_Door_FemaleElfHaughty
	AllTalkingActivators[11] = _SK_Door_MaleElfHaughty
	AllTalkingActivators[12] = _SK_Door_FemaleArgonian
	AllTalkingActivators[13] = _SK_Door_MaleArgonian
	AllTalkingActivators[14] = _SK_Door_FemaleKhajiit
	AllTalkingActivators[15] = _SK_Door_MaleKhajiit
	AllTalkingActivators[16] = _SK_Door_FemaleOrc
	AllTalkingActivators[17] = _SK_Door_MaleOrc
	AllTalkingActivators[18] = _SK_Door_FemaleNord
	AllTalkingActivators[19] = _SK_Door_MaleNord
	AllTalkingActivators[20] = _SK_Door_FemaleCoward
	AllTalkingActivators[21] = _SK_Door_FemaleCondescending
	AllTalkingActivators[22] = _SK_Door_FemaleCommander
	AllTalkingActivators[23] = _SK_Door_FemaleOldGrumpy
	AllTalkingActivators[24] = _SK_Door_FemaleOldKindly
	AllTalkingActivators[25] = _SK_Door_FemaleSultry
	AllTalkingActivators[26] = _SK_Door_FemaleCommoner
	AllTalkingActivators[27] = _SK_Door_FemaleEvenToned
	AllTalkingActivators[28] = _SK_Door_FemaleYoungEager
	AllTalkingActivators[29] = _SK_Door_MaleCoward
	AllTalkingActivators[30] = _SK_Door_MaleBrute
	AllTalkingActivators[31] = _SK_Door_MaleCondescending
	AllTalkingActivators[32] = _SK_Door_MaleCommander
	AllTalkingActivators[33] = _SK_Door_MaleOldGrumpy
	AllTalkingActivators[34] = _SK_Door_MaleSlyCynical
	AllTalkingActivators[35] = _SK_Door_MaleDrunk
	AllTalkingActivators[36] = _SK_Door_MaleCommoner
	AllTalkingActivators[37] = _SK_Door_MaleEvenToned
	AllTalkingActivators[38] = _SK_Door_MaleYoungEager
endFunction

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
		Activator talking_door = GetTalkingDoor(found_actor.GetVoiceType(), found_actor.GetActorBase().GetSex())
		ObjectReference my_talking_door = akDoor.PlaceAtMe(talking_door)
		TalkingDoorAlias.ForceRefTo(my_talking_door)

		; Move the talking activator away from the player, to give the sense that the
		; sound is muffled and coming through the door.
		float[] talking_door_pos = GetOffsets(PlayerRef, 1400.0)
		my_talking_door.MoveTo(PlayerRef, talking_door_pos[0], talking_door_pos[1])

		Utility.Wait(1)
		my_talking_door.Activate(PlayerRef)
		Utility.Wait(30)
		my_talking_door.Disable()
		my_talking_door.Delete()
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
			FriendAlias.ForceRefTo(actor_owner_ref_in_cell)
			Conditions.FriendInside = true
			return actor_owner_ref_in_cell
		else
			debug.trace("I found actor owner " + actor_owner.GetName() + " inside owned cell " + linked_cell + ".")
			FriendAlias.Clear()
			Conditions.FriendInside = false
			return actor_owner_ref_in_cell
		endif
	else
		debug.trace("I couldn't find the owner inside.")
		return None
	endif
endFunction

Activator function GetTalkingDoor(VoiceType akVoiceType, int aiSex)
	int voice_type_count = VoiceTypeArrayCount(AllVoiceTypes)
	int i = 0
	while i < voice_type_count
		if AllVoiceTypes[i] == akVoiceType
			return AllTalkingActivators[i]
		endif
		i += 1
	endWhile

	; We didn't find a voice type match. Default to Even Toned.
	if aiSex == 1
		return AllTalkingActivators[27]
	else
		return AllTalkingActivators[37]
	endif
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
			FriendAlias.ForceRefTo(chosen_owner)
			Conditions.FriendInside = true
			return chosen_owner
		else
			debug.trace("I found actor owner " + chosen_owner.GetActorBase().GetName() + " of faction " + faction_owner + " inside owned cell " + linked_cell + ".")
			FriendAlias.Clear()
			Conditions.FriendInside = false
			return chosen_owner
		endif
	else
		return None
	endif
endFunction

function NoAnswer()
	debug.trace("No answer...")
	_SK_NoAnswerMsg.Show()
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

int function VoiceTypeArrayCount(VoiceType[] myArray) global
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

float[] function GetOffsets(Actor akSource, Float afDistance = 100.0, float afOffset = 0.0)
	Float A = akSource.GetAngleZ() + afOffset
	Float YDist = Sin(A)
	Float XDist = Cos(A)

	XDist *= afDistance
	YDist *= afDistance

	Float[] Offsets = New Float[2]
	Offsets[0] = YDist
	Offsets[1] = XDist
	Return Offsets
EndFunction