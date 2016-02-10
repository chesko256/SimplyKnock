Scriptname xMAQuestFingersmithScript extends Quest  

GlobalVariable Property xMAFingersmithLockpickingExpBase Auto

spell property xMADEXNoseForCoin1BlockerAbility auto
MiscObject property gold001 auto

Weapon Property xMADEXNoseForCoinBlocker Auto

actor property playerref auto

Function pickpocketUnlock(ObjectReference akTargetRef)

	int level = aktargetRef.getLockLevel()
	bool result = aktargetRef.activate(Game.GetPlayer())

	float time = Utility.GetCurrentGameTime()

	while (aktargetRef.isLocked() && time == Utility.GetCurrentGameTime())
		Utility.wait(0.1)
	endwhile
	if (!aktargetRef.isLocked())
		float base = xMAFingersmithLockpickingExpBase.getValue()
		
		if (level == 100)
			Game.AdvanceSkill("Pickpocket", 12*base)
		elseif (level < 100 && level >= 75)
			Game.AdvanceSkill("Pickpocket", 8*base)
		elseif (level < 75 && level >= 50)
			Game.AdvanceSkill("Pickpocket", 5*base)
		elseif (level < 50 && level >= 25)
			Game.AdvanceSkill("Pickpocket", 3*base)
		elseif (level < 25)
			Game.AdvanceSkill("Pickpocket", 2*base)
		endIf
	endif
EndFunction

Function noseForCoin(actor o)

	o.addspell(xMADEXNoseForCoin1BlockerAbility)

	o.additem(xMADEXNoseForCoinBlocker,1)

	int numSeven = 0
	int totalGold = 0
	int currentGold = 0
	int turns = 3

	while(turns > 0)
		currentGold = utility.randomInt(0,100)
		if currentGold == 7
			numSeven += 1
		endif
		totalGold += currentGold
		turns -= 1
	endWhile
	
	totalGold += numSeven*777

	o.addItem(gold001, totalGold, false)

	o.activate(playerref)

EndFunction
