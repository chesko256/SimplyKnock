scriptname SimplyKnockMainScript extends Quest

import SimplyKnockSKSE
import math

SimplyKnockConditions property Conditions auto

int property FormType_kNPC = 43 autoReadOnly

Actor property PlayerRef auto
Activator property _SK_InteriorStateMarker auto
GlobalVariable property _SK_Setting_LogLevel auto
GlobalVariable property _SK_Setting_SpeechSuccessChance auto
GlobalVariable property _SK_Setting_LastResultValue auto
Keyword property LocTypeHouse auto
Keyword property LocTypeDwelling auto
Keyword property LocTypeFarm auto
Keyword property ActorTypeNPC auto
Message property _SK_AltMenu auto
Message property _SK_NoAnswerMsg auto
Quest property _SimplyKnockDialogueQuest auto
ReferenceAlias property PlayerAlias auto
ReferenceAlias property TalkingDoorAlias auto
ReferenceAlias property FriendAlias auto
ReferenceAlias property OwnerAlias auto
ReferenceAlias property DoorAlias auto
Sound property _SK_DoorKnockSM auto
Sound property _SK_UnlockSound auto
Topic property TimeToGo auto hidden
FormList property VoicesChild auto

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
VoiceType property MaleChild auto
VoiceType property FemaleChild auto

TalkingActivator property _SK_Door_MaleEvenTonedAccented auto
TalkingActivator property _SK_Door_MaleCommonerAccented auto
TalkingActivator property _SK_Door_MaleGuard auto
TalkingActivator property _SK_Door_MaleForsworn auto
TalkingActivator property _SK_Door_MaleBandit auto
TalkingActivator property _SK_Door_MaleNordCommander auto
TalkingActivator property _SK_Door_MaleSoldier auto
TalkingActivator property _SK_Door_FemaleShrill auto
TalkingActivator property _SK_Door_FemaleDarkElf auto
TalkingActivator property _SK_Door_MaleDarkElf auto
TalkingActivator property _SK_Door_FemaleElfHaughty auto
TalkingActivator property _SK_Door_MaleElfHaughty auto
TalkingActivator property _SK_Door_FemaleArgonian auto
TalkingActivator property _SK_Door_MaleArgonian auto
TalkingActivator property _SK_Door_FemaleKhajiit auto
TalkingActivator property _SK_Door_MaleKhajiit auto
TalkingActivator property _SK_Door_FemaleOrc auto
TalkingActivator property _SK_Door_MaleOrc auto
TalkingActivator property _SK_Door_FemaleNord auto
TalkingActivator property _SK_Door_MaleNord auto
TalkingActivator property _SK_Door_FemaleCoward auto
TalkingActivator property _SK_Door_FemaleCondescending auto
TalkingActivator property _SK_Door_FemaleCommander auto
TalkingActivator property _SK_Door_FemaleOldGrumpy auto
TalkingActivator property _SK_Door_FemaleOldKindly auto
TalkingActivator property _SK_Door_FemaleSultry auto
TalkingActivator property _SK_Door_FemaleCommoner auto
TalkingActivator property _SK_Door_FemaleEvenToned auto
TalkingActivator property _SK_Door_FemaleYoungEager auto
TalkingActivator property _SK_Door_MaleCoward auto
TalkingActivator property _SK_Door_MaleBrute auto
TalkingActivator property _SK_Door_MaleCondescending auto
TalkingActivator property _SK_Door_MaleCommander auto
TalkingActivator property _SK_Door_MaleOldGrumpy auto
TalkingActivator property _SK_Door_MaleSlyCynical auto
TalkingActivator property _SK_Door_MaleDrunk auto
TalkingActivator property _SK_Door_MaleCommoner auto
TalkingActivator property _SK_Door_MaleEvenToned auto
TalkingActivator property _SK_Door_MaleYoungEager auto
TalkingActivator property _SK_Door_MaleChild auto
TalkingActivator property _SK_Door_FemaleChild auto
TalkingActivator property _SK_Door_MaleIndistinct auto
TalkingActivator property _SK_Door_FemaleIndistinct auto

; NegotiationState enum
int nsReady 		 = 0
int nsSuccess 		 = 1
int nsInitialFailure = 2
int nsFailure 		 = 3

; If a friend is in the cell, the friend always wins.
; If the door has a specific actor owner, look for that actor.
; If the door has a faction owner, look for actors in that faction.

VoiceType[] AllVoiceTypes
TalkingActivator[] AllTalkingActivators

ObjectReference property CurrentDoor auto hidden
Actor property CurrentSpeaker auto hidden

bool using_controller = false
bool property usingController hidden
	function Set(bool abUsingController)
		if abUsingController != using_controller
			DebugLog(0, "Switching using controller to " + abUsingController)
		endif
		using_controller = abUsingController
	endFunction

	bool function Get()
		return using_controller
	endFunction
endProperty

function BuildVoiceTypeArrays()
	AllVoiceTypes = new VoiceType[64]
	AllTalkingActivators = new TalkingActivator[64]

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
	AllVoiceTypes[39] = MaleChild
	AllVoiceTypes[40] = FemaleChild

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
	AllTalkingActivators[39] = _SK_Door_MaleChild
	AllTalkingActivators[40] = _SK_Door_FemaleChild
	AllTalkingActivators[41] = _SK_Door_MaleIndistinct
	AllTalkingActivators[42] = _SK_Door_FemaleIndistinct
endFunction

Event OnCrosshairRefChange(ObjectReference ref)
	if ref
		if ref.GetBaseObject() as Door
			ObjectReference linked_door = GetLinkedDoor(ref)
			if linked_door
				Location linked_door_location = linked_door.GetCurrentLocation()
				if linked_door_location.HasKeyword(LocTypeHouse) || linked_door_location.HasKeyword(LocTypeDwelling) || linked_door_location.HasKeyword(LocTypeFarm)
					Conditions.IsKnockableDoor = true
				else
					Conditions.IsKnockableDoor = false
				endif
				CurrentDoor = ref
			else
				Conditions.IsKnockableDoor = false
				CurrentDoor = ref
			endif
		endif
	endif
EndEvent

; Called from replace default Unlock perk option
function DelegateActivation(ObjectReference akDoor)
	; Wait to exit menu mode.
	Utility.Wait(0.1)

	_SK_PlayerAliasScript Compatibility = PlayerAlias as _SK_PlayerAliasScript
	
    if Compatibility.isSKYRELoaded
    	DebugLog(0, "Activate using SkyRe.")
    	Perk passive_fingersmith = Game.GetFormFromFile(0x0A3756, "SkyRe_Main.esp") as Perk
    	(passive_fingersmith as xxx_PRKF_xxxPassiveFingersmit_020A3756).Fragment_0(akDoor, None)
    elseif Compatibility.isPERMALoaded
    	DebugLog(0, "Activate using PerMa.")
    	Perk passive_lockpicking = Game.GetFormFromFile(0x112B24, "PerkusMaximus_Master.esp") as Perk
    	(passive_lockpicking as xS2__PRKF_xMAPassiveFingersmi_05112B24).Fragment_0(akDoor, None)
    else
    	DebugLog(0, "Activate standard.")
    	akDoor.Activate(PlayerRef)
    endif
endFunction

; Called from Perk
function KnockOnDoor(ObjectReference akDoor)
	ResetFlags()

	DebugLog(0, "Knocking...")
	_SK_DoorKnockSM.Play(akDoor)

	; Wait, then respond
	Utility.Wait(1.5)

	ObjectReference linked_door = GetLinkedDoor(akDoor)
	if !linked_door
		DebugLog(2, "Why was I allowed to knock on " + akDoor + "? This door isn't linked!")
		return
	endif
	
	ActorBase actor_owner = linked_door.GetActorOwner()
	if !actor_owner
		actor_owner = linked_door.GetParentCell().GetActorOwner()
	endif
	Actor found_actor = None
	if actor_owner
		found_actor = KnockOnDoor_ActorOwner(linked_door, actor_owner)
	else
		found_actor = KnockOnDoor_FactionOwner(linked_door)
	endif

	if found_actor
		CurrentSpeaker = found_actor
		Activator talking_door = GetTalkingDoor(found_actor.GetVoiceType(), found_actor.GetActorBase().GetSex())
		ObjectReference my_talking_door = akDoor.PlaceAtMe(talking_door)
		TalkingDoorAlias.ForceRefTo(my_talking_door)
		
		; Set the current negotiation state flags
		bool allow_dialogue = true
		int current_state
		ObjectReference state_marker = GetStateMarker(akDoor)
		if state_marker
			current_state = (state_marker as SimplyKnockInteriorState).NegotiationState
			if current_state == nsInitialFailure
				Conditions.NegotiationInitiallyFailed = true
			elseif current_state == nsFailure
				allow_dialogue = false
			endif
		endif

		; Move the talking activator away from the player, to give the sense that the
		; sound is muffled and coming through the door.
		float[] talking_door_pos = GetOffsets(PlayerRef, 1400.0)
		my_talking_door.MoveTo(PlayerRef, talking_door_pos[0], talking_door_pos[1])
		
		int i = 0
		while !my_talking_door.Is3DLoaded() && i < 50
			Utility.Wait(0.1)
			i += 1
		endWhile

		if allow_dialogue
			my_talking_door.Activate(PlayerRef)
		else
			; Beat it!
			; Have to resolve this manually. CK won't let you link automatic topics.
			TimeToGo = Game.GetFormFromFile(0x0006AEA2, "Skyrim.esm") as Topic
			(my_talking_door as _SK_TalkingDoor).SayGoAway(TimeToGo)
		endif
	else
		NoAnswer()
	endif
endFunction

Actor function KnockOnDoor_ActorOwner(ObjectReference linked_door, ActorBase actor_owner)
	Cell linked_cell = linked_door.GetParentCell()
	Actor actor_owner_ref_in_cell = GetActorOwnerInCell(actor_owner, linked_cell)
	if actor_owner_ref_in_cell
		if IsFriendsWithPlayer(actor_owner_ref_in_cell)
			DebugLog(1, "I found actor owner " + actor_owner.GetName() + " inside owned cell " + linked_cell + ". We're friends!")
			FriendAlias.ForceRefTo(actor_owner_ref_in_cell)
			Conditions.FriendInside = true
			return actor_owner_ref_in_cell
		else
			DebugLog(1, "I found actor owner " + actor_owner.GetName() + " inside owned cell " + linked_cell + ".")
			FriendAlias.Clear()
			Conditions.FriendInside = false
			return actor_owner_ref_in_cell
		endif
	else
		DebugLog(1, "I couldn't find the owner inside.")
		return None
	endif
endFunction

TalkingActivator function GetTalkingDoor(VoiceType akVoiceType, int aiSex)
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
		; Indistinct Female
		return AllTalkingActivators[42]
	else
		; Indistinct Male
		return AllTalkingActivators[41]
	endif
endFunction

Actor function KnockOnDoor_FactionOwner(ObjectReference linked_door)
	Cell linked_cell = linked_door.GetParentCell()
	Faction faction_owner = linked_door.GetFactionOwner()
	
	Actor[] present_owners = GetCellFactionOwnersInCell(faction_owner, linked_cell)
	if !present_owners
		DebugLog(1, "I couldn't find any faction owners inside.")
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
			DebugLog(1, "I found actor owner " + chosen_owner.GetActorBase().GetName() + " of faction " + faction_owner + " inside owned cell " + linked_cell + ". We're friends!")
			FriendAlias.ForceRefTo(chosen_owner)
			Conditions.FriendInside = true
			return chosen_owner
		else
			DebugLog(1, "I found actor owner " + chosen_owner.GetActorBase().GetName() + " of faction " + faction_owner + " inside owned cell " + linked_cell + ".")
			FriendAlias.Clear()
			Conditions.FriendInside = false
			return chosen_owner
		endif
	else
		return None
	endif
endFunction

function NoAnswer()
	DebugLog(1, "No answer...")
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
		if actor_ref.GetActorBase() == akActorBase && actor_ref.IsEnabled() && !actor_ref.IsDead()
			return actor_ref
		endif
		i += 1
	endWhile

	return None
endFunction

Actor[] function GetCellFactionOwnersInCell(Faction akFaction, Cell akCell)
	; Find all of the faction owners currently in this cell. Bias towards
	; returning friends of the player. Return children only if no other option available.

	Actor[] found_actors = new Actor[16]
	Actor[] found_friends = new Actor[16]
	Actor[] found_children = new Actor[16]

	int actor_count = akCell.GetNumRefs(FormType_kNPC)
	DebugLog(0, "There were " + actor_count + " actors in " + akCell)
	if actor_count == 0
		; Return the empty array
		return found_actors
	endif

	int i = 0
	while i < actor_count
		Actor possible_owner = akCell.GetNthRef(i, FormType_kNPC) as Actor
		
		bool is_child 
		if possible_owner.IsChild() || VoicesChild.HasForm(possible_owner.GetVoiceType())
			is_child = true
		else
			is_child = false
		endif

		; The actor must be a member of the owner faction, enabled, alive, and a human.
		if possible_owner.IsInFaction(akFaction) && possible_owner.IsEnabled() && !possible_owner.IsDead() && possible_owner.HasKeyword(ActorTypeNPC)
			; Normal adult owner
			if !is_child
				int idx = ArrayCount(found_actors)
				if idx < 16
					found_actors[idx] = possible_owner
				endif
			endif	
			; Is this a friend?
			if IsFriendsWithPlayer(possible_owner)
				int jdx = ArrayCount(found_friends)
				if jdx < 16
					found_friends[jdx] = possible_owner
				endif
			endif	
			; Is this a child?
			if is_child
				int kdx = ArrayCount(found_children)
				if kdx < 16
					found_children[kdx] = possible_owner
				endif
			endif
		endif
		i += 1
	endWhile

	if found_friends[0] != None
		return found_friends
	elseif found_actors[0] != None
		return found_actors
	else
		return found_children
	endif
endFunction

function SetSpeechResult(bool abUseSpeechcraft = false)
	float difficulty = 1.0 - _SK_Setting_SpeechSuccessChance.GetValue()
	float speech_factor = 0.0
	if abUseSpeechcraft
		speech_factor = PlayerRef.GetActorValue("Speechcraft") * 0.005
	endif
	float attempt = Utility.RandomFloat()
	if (attempt + speech_factor) > difficulty
		DebugLog(1, "Success: Rolled " + ((attempt + speech_factor) * 100) + "%, needed " + (difficulty * 100) + "% or higher.")
		Conditions.SpeechCheckSuccessful = true
	else
		DebugLog(1, "Failed: Rolled " + ((attempt + speech_factor) * 100) + "%, needed " + (difficulty * 100) + "% or higher.")
		Conditions.SpeechCheckSuccessful = false
	endif
endFunction

function SetResult_Succeeded()
	DebugLog(1, "Success!")
	_SK_Setting_LastResultValue.SetValueInt(2)
	ObjectReference state_marker = GetStateMarker(CurrentDoor)
	if !state_marker
		state_marker = GenerateStateMarker(CurrentDoor)
	else
		(state_marker as SimplyKnockInteriorState).SetTimeout()
	endif
	(state_marker as SimplyKnockInteriorState).NegotiationState = nsSuccess

	; Necessary to run a package.
	ObjectReference linked_door = GetLinkedDoor(CurrentDoor)
	(state_marker as SimplyKnockInteriorState).DoorAlias.ForceRefTo(linked_door)
	(state_marker as SimplyKnockInteriorState).OwnerAlias.ForceRefTo(CurrentSpeaker)

	; Necessary to know when we've left the area.
	(state_marker as SimplyKnockInteriorState).InteriorLocation = linked_door.GetCurrentLocation()	
	
	; Necessary to stop "Get Out" dialogue. We set it back to private when we leave.
	linked_door.GetParentCell().SetPublic()
	
	; Necessary to keep the door unlocked.
	CurrentDoor.Lock(false, true)
	
	Utility.Wait(1.0)
	_SK_UnlockSound.Play(CurrentDoor)
	RegisterForSingleUpdateGameTime(8.0)
endFunction

function SetResult_FailedInitial()
	DebugLog(1, "Initially failed!")
	_SK_Setting_LastResultValue.SetValueInt(1)
	ObjectReference state_marker = GetStateMarker(CurrentDoor)
	if !state_marker
		state_marker = GenerateStateMarker(CurrentDoor)
	else
		(state_marker as SimplyKnockInteriorState).SetTimeout()
	endif
	(state_marker as SimplyKnockInteriorState).NegotiationState = nsInitialFailure
endFunction

function SetResult_Failed()
	DebugLog(1, "Failed!")
	_SK_Setting_LastResultValue.SetValueInt(1)
	ObjectReference state_marker = GetStateMarker(CurrentDoor)
	if !state_marker
		state_marker = GenerateStateMarker(CurrentDoor)
	else
		(state_marker as SimplyKnockInteriorState).SetTimeout()
	endif
	(state_marker as SimplyKnockInteriorState).NegotiationState = nsFailure
endFunction

ObjectReference function GetStateMarker(ObjectReference akDoor)
	if !akDoor
		return None
	endif
	DebugLog(0, "Searching for state markers around door " + akDoor)
	ObjectReference state_marker = Game.FindClosestReferenceOfTypeFromRef(_SK_InteriorStateMarker, akDoor, 20.0)
	if state_marker
		DebugLog(0, "Found negotiation state marker " + state_marker)
	else
		DebugLog(0, "Couldn't find a negotiation state marker.")
	endif
	return state_marker
endFunction

ObjectReference function GenerateStateMarker(ObjectReference akDoor)
	DebugLog(0, "Generating new state marker.")
	ObjectReference state_marker = akDoor.PlaceAtMe(_SK_InteriorStateMarker)
	DebugLog(0, "Created new state marker " + state_marker)
	return state_marker
endFunction

function ResetFlags()
	Conditions.NegotiationInitiallyFailed = false
	Conditions.SpeechCheckSuccessful = false
	CurrentSpeaker = None
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