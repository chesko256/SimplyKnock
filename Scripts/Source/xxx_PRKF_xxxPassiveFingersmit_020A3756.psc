;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname xxx_PRKF_xxxPassiveFingersmit_020A3756 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
int level = aktargetRef.getLockLevel()
bool result = aktargetRef.activate(Game.GetPlayer())
float time = Utility.GetCurrentGameTime()
while (aktargetRef.isLocked() && time == Utility.GetCurrentGameTime())
Utility.wait(0.1)
endwhile
if (!aktargetRef.isLocked())
float base = xxxFingersmithLockpickingExpBase.getValue()
if (level >= 100)
Game.AdvanceSkill("Pickpocket", 12*base)
elseif (level >= 75)
Game.AdvanceSkill("Pickpocket", 8*base)
elseif (level >= 50)
Game.AdvanceSkill("Pickpocket", 5*base)
elseif (level >= 25)
Game.AdvanceSkill("Pickpocket", 3*base)
else
Game.AdvanceSkill("Pickpocket", 2*base)
endIf
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property xxxFingersmithLockpickingExpBase  Auto  
