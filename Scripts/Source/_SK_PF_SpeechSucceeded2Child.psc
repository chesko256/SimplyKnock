;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname _SK_PF_SpeechSucceeded2Child Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor current_speaker = (_SimplyKnockMainQuest as SimplyKnockMainScript).CurrentSpeaker
DialogueFavorGeneric.Bribe(current_speaker)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(_SimplyKnockMainQuest as SimplyKnockMainScript).SetResult_Succeeded()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SimplyKnockMainQuest  Auto  

FavorDialogueScript Property DialogueFavorGeneric  Auto  
