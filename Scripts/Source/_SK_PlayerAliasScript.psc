scriptname _SK_PlayerAliasScript extends ReferenceAlias

Actor property PlayerRef auto
Perk property _SK_KnockPerk auto
int property SKSE_MIN_VERSION = 10703 autoReadOnly
Message property _SK_SKSE_Error auto
_SK_SkyUIConfigPanelScript property Config auto
SimplyKnockMainScript property Main auto

Event OnInit()
	CheckSKSE()
	Config.LoadProfileOnStartup()
	Main.RegisterForCrosshairRef()
	AddPerksIfNecessary()
	Main.BuildVoiceTypeArrays()
endEvent

Event OnPlayerLoadGame()
	CheckSKSE()
	Config.LoadProfileOnStartup()
	Main.RegisterForCrosshairRef()
	AddPerksIfNecessary()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	SendEvent_PlayerLocationChange(akOldLoc)
EndEvent

function AddPerksIfNecessary()
	if !PlayerRef.HasPerk(_SK_KnockPerk)
		PlayerRef.AddPerk(_SK_KnockPerk)
	endif
endFunction

function SendEvent_PlayerLocationChange(Location akOldLocation)
	int handle = ModEvent.Create("SimplyKnockPlayerLocationChange")
	if handle
		ModEvent.PushForm(handle, akOldLocation)
		ModEvent.Send(handle)
	endif
endFunction

function CheckSKSE()
	bool skse_loaded = SKSE.GetVersion()
	if skse_loaded
		int skse_version = (SKSE.GetVersion() * 10000) + (SKSE.GetVersionMinor() * 100) + SKSE.GetVersionBeta()
		if skse_version < SKSE_MIN_VERSION
			_SK_SKSE_Error.Show(((skse_version as float) / 10000), ((SKSE_MIN_VERSION as float) / 10000))
			debug.trace("[SimplyKnock][Error] Detected SKSE version " + ((skse_version as float) / 10000) + ", expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer.")			
		else
			debug.trace("[SimplyKnock] Detected SKSE version " + ((skse_version as float) / 10000) + " (expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer, success!)")
		endif
	else
		_SK_SKSE_Error.Show(((0.0) / 10000), ((SKSE_MIN_VERSION as float) / 10000))
		debug.trace("[SimplyKnock][Error] Detected SKSE version " + ((0.0) / 10000) + ", expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer.")
	endif
endFunction