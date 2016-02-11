;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 16
Scriptname PRKF__SK_KnockPerk_02001828 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_14
Function Fragment_14(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(_SimplyKnockMainQuest as SimplyKnockMainScript).DelegateActivation(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(_SimplyKnockMainQuest as SimplyKnockMainScript).KnockOnDoor(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(_SimplyKnockMainQuest as SimplyKnockMainScript).DelegateActivation(akTargetRef)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property _SimplyKnockMainQuest  Auto  
