Scriptname _SK_SkyUIConfigPanelScript extends SKI_ConfigBase

; TODO: Hook up profile load on game load / start

string CONFIG_PATH = "../SimplyKnockData/"

GlobalVariable property _SK_Setting_SpeechSuccessChance auto
GlobalVariable property _SK_Setting_StateTimeoutDuration auto
GlobalVariable property _SK_Setting_FriendsAllowEntry auto
GlobalVariable property _SK_Setting_UseAltMenu auto
GlobalVariable property _SK_Setting_CurrentProfile auto
GlobalVariable property _SK_Setting_AutoSaveLoad auto

int Settings_SpeechSuccessChance_OID
int Settings_StateTimeoutDuration_OID
int Settings_FriendsAllowEntryToggle_OID
int Settings_UseAltMenu_OID

int SaveLoad_SelectProfile_OID
int SaveLoad_RenameProfile_OID
int SaveLoad_DefaultProfile_OID
int SaveLoad_ProfileHelp_OID
int SaveLoad_Enable_OID

Event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "$SimplyKnockSettingsPage"
	Pages[1] = "$SimplyKnockSaveLoadPage"
endEvent

int function GetVersion()
	return 1
endFunction

Event OnVersionUpdate(int a_version)
	; pass
EndEvent

function PageReset_Settings()
	SetCursorFillMode(TOP_TO_BOTTOM)

	AddHeaderOption("$SimplyKnockHeaderSettings")
	Settings_SpeechSuccessChance_OID = AddSliderOption("$SimplyKnockSettingsSuccessChance", _SK_Setting_SpeechSuccessChance.GetValue() * 100.0, "{0}%")
	Settings_StateTimeoutDuration_OID = AddSliderOption("$SimplyKnockSettingsTimeoutDuration", _SK_Setting_StateTimeoutDuration.GetValueInt(), "{0} Hours")

	if _SK_Setting_FriendsAllowEntry.GetValueInt() == 2
		Settings_FriendsAllowEntryToggle_OID = AddToggleOption("$SimplyKnockSettingsFriendsAllowEntry", true)
	else
		Settings_FriendsAllowEntryToggle_OID = AddToggleOption("$SimplyKnockSettingsFriendsAllowEntry", false)
	endif
	if _SK_Setting_UseAltMenu.GetValueInt() == 2
		Settings_UseAltMenu_OID = AddToggleOption("$SimplyKnockSettingsUseAltMenu", true)
	else
		Settings_UseAltMenu_OID = AddToggleOption("$SimplyKnockSettingsUseAltMenu", false)
	endif
endFunction

function PageReset_SaveLoad()
	SetCursorFillMode(TOP_TO_BOTTOM)

	AddHeaderOption("$SimplyKnockSaveLoadHeaderProfile")
	if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
		SaveLoad_SelectProfile_OID = AddMenuOption("$SimplyKnockSaveLoadCurrentProfile", GetProfileName(_SK_Setting_CurrentProfile.GetValueInt()))
	else
		SaveLoad_SelectProfile_OID = AddMenuOption("$SimplyKnockSaveLoadCurrentProfile", GetProfileName(_SK_Setting_CurrentProfile.GetValueInt()), OPTION_FLAG_DISABLED)
	endif
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	SaveLoad_ProfileHelp_OID = AddTextOption("$SimplyKnockSaveLoadAboutProfiles", "")
	if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
		SaveLoad_Enable_OID = AddToggleOption("$SimplyKnockSaveLoadEnable", true)
	else
		SaveLoad_Enable_OID = AddToggleOption("$SimplyKnockSaveLoadEnable", false)
	endif
	
	SetCursorPosition(1) ; Move cursor to top right position

	AddEmptyOption()
	if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
		SKI_Main skyui = Game.GetFormFromFile(0x00000814, "SkyUI.esp") as SKI_Main
		int version = skyui.ReqSWFRelease
		if version >= 1026 	; SkyUI 5.1+
			SaveLoad_RenameProfile_OID = AddInputOption("", "$SimplyKnockSaveLoadRenameProfile")
		else
			SaveLoad_RenameProfile_OID = AddTextOption("$SimplyKnockSkyUI51Required", "$SimplyKnockSaveLoadRenameProfile", OPTION_FLAG_DISABLED)
		endif
		SaveLoad_DefaultProfile_OID = AddTextOption("", "$SimplyKnockSaveLoadDefaultProfile")
	endif
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	AddEmptyOption()
	if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
		AddTextOption("$SimplyKnockSaveLoadSettingsSaved", "", OPTION_FLAG_DISABLED)
	endif
endFunction

event OnPageReset(string page)
	if page == ""
		LoadCustomContent("simplyknock/logo.dds")
	else
		UnloadCustomContent()
	endif

	if !Pages
		OnConfigInit()
	endif
	
	if page == "$SimplyKnockSettingsPage"
		PageReset_Settings()
	elseif page == "$SimplyKnockSaveLoadPage"
		PageReset_SaveLoad()
	endif
endEvent

event OnOptionHighlight(int option)
	if option == Settings_SpeechSuccessChance_OID
		SetInfoText("$SimplyKnockSettingsSuccessChanceHighlight")
	elseif option == Settings_StateTimeoutDuration_OID
		SetInfoText("$SimplyKnockSettingsTimeoutDurationHighlight")
	elseif option == Settings_FriendsAllowEntryToggle_OID
		SetInfoText("$SimplyKnockSettingsFriendsAllowEntryHighlight")
	elseif option == Settings_UseAltMenu_OID
		SetInfoText("$SimplyKnockSettingsUseAltMenuHighlight")

	elseif option == SaveLoad_SelectProfile_OID
		SetInfoText("$SimplyKnockOptionHighlightSettingSelectProfile")
	elseif option == SaveLoad_RenameProfile_OID
		SetInfoText("$SimplyKnockOptionHighlightSettingRenameProfile")
	elseif option == SaveLoad_DefaultProfile_OID
		SetInfoText("$SimplyKnockOptionHighlightSettingDefaultProfile")
	elseif option == SaveLoad_Enable_OID
		SetInfoText("$SimplyKnockOptionHighlightSettingEnableSaveLoad")
	endif
endEvent

event OnOptionSelect(int option)
	if option == Settings_FriendsAllowEntryToggle_OID
		if _SK_Setting_FriendsAllowEntry.GetValueInt() == 2
			_SK_Setting_FriendsAllowEntry.SetValueInt(1)
			SetToggleOptionValue(Settings_FriendsAllowEntryToggle_OID, false)
		else
			_SK_Setting_FriendsAllowEntry.SetValueInt(2)
			SetToggleOptionValue(Settings_FriendsAllowEntryToggle_OID, true)
		endif
		SaveSettingToCurrentProfile("friends_allow_entry", _SK_Setting_FriendsAllowEntry.GetValueInt())
	elseif option == Settings_UseAltMenu_OID
		if _SK_Setting_UseAltMenu.GetValueInt() == 2
			_SK_Setting_UseAltMenu.SetValueInt(1)
			SetToggleOptionValue(Settings_UseAltMenu_OID, false)
		else
			_SK_Setting_UseAltMenu.SetValueInt(2)
			SetToggleOptionValue(Settings_UseAltMenu_OID, true)
		endif
		SaveSettingToCurrentProfile("use_alt_menu", _SK_Setting_UseAltMenu.GetValueInt())
	elseif option == SaveLoad_Enable_OID
		if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
			_SK_Setting_AutoSaveLoad.SetValueInt(1)
			SetToggleOptionValue(SaveLoad_Enable_OID, false)
			JsonUtil.SetIntValue(CONFIG_PATH + "common", "auto_load", 1)
			JsonUtil.Save(CONFIG_PATH + "common")
		elseif _SK_Setting_AutoSaveLoad.GetValueInt() == 1
			_SK_Setting_AutoSaveLoad.SetValueInt(2)
			SetToggleOptionValue(SaveLoad_Enable_OID, true)
			JsonUtil.SetIntValue(CONFIG_PATH + "common", "auto_load", 2)
			JsonUtil.Save(CONFIG_PATH + "common")
			SaveAllSettings(_SK_Setting_CurrentProfile.GetValueInt())
		endIf
		ForcePageReset()
	elseif option == SaveLoad_DefaultProfile_OID
		bool b = ShowMessage("$SimplyKnockSaveLoadDefaultProfileConfirm")
		if b
			GenerateDefaultProfile(_SK_Setting_CurrentProfile.GetValueInt())
			SwitchToProfile(_SK_Setting_CurrentProfile.GetValueInt())
			ForcePageReset()
		endif
	endif

	if option == SaveLoad_ProfileHelp_OID
		ShowProfileHelp()
	endif
endEvent

event OnOptionDefault(int option)
	if option == Settings_SpeechSuccessChance_OID
		_SK_Setting_SpeechSuccessChance.SetValue(0.5)
		SetSliderOptionValue(Settings_SpeechSuccessChance_OID, 50.0, "{0}%")
		ForcePageReset()
		SaveSettingToCurrentProfileFloat("speech_success_chance", _SK_Setting_SpeechSuccessChance.GetValue())
	elseif option == Settings_StateTimeoutDuration_OID
		_SK_Setting_StateTimeoutDuration.SetValue(24.0)
		SetSliderOptionValue(Settings_StateTimeoutDuration_OID, 24.0, "{0} Hours")
		ForcePageReset()
		SaveSettingToCurrentProfileFloat("state_timeout_duration", _SK_Setting_StateTimeoutDuration.GetValue())
	elseif option == Settings_FriendsAllowEntryToggle_OID
		_SK_Setting_FriendsAllowEntry.SetValueInt(2)
		SetToggleOptionValue(Settings_FriendsAllowEntryToggle_OID, true)
		ForcePageReset()
		SaveSettingToCurrentProfile("friends_allow_entry", _SK_Setting_FriendsAllowEntry.GetValueInt())
	elseif option == Settings_UseAltMenu_OID
		_SK_Setting_UseAltMenu.SetValueInt(1)
		SetToggleOptionValue(Settings_UseAltMenu_OID, false)
		ForcePageReset()
		SaveSettingToCurrentProfile("use_alt_menu", _SK_Setting_UseAltMenu.GetValueInt())
	endif
endEvent

event OnOptionMenuOpen(int option)
	if option == SaveLoad_SelectProfile_OID
		string[] profile_list = new string[10]
		int i = 0
		while i < 10
			string pname = GetProfileName(i + 1)
			profile_list[i] = pname
			i += 1
		endWhile
		SetMenuDialogOptions(profile_list)
		SetMenuDialogStartIndex(_SK_Setting_CurrentProfile.GetValueInt() - 1)
		SetMenuDialogDefaultIndex(0)
	endif
endEvent

event OnOptionMenuAccept(int option, int index)
	if option == SaveLoad_SelectProfile_OID
		bool b = ShowMessage("$SimplyKnockSaveLoadConfirm")
		if b
			SwitchToProfile(index + 1)
			ForcePageReset()
		endif
	endif
endEvent

event OnOptionSliderOpen(int option)
	if option == Settings_SpeechSuccessChance_OID
		SetSliderDialogStartValue(_SK_Setting_SpeechSuccessChance.GetValue() * 100.0)
		SetSliderDialogDefaultValue(50.0)
		SetSliderDialogRange(0.0, 100.0)
		SetSliderDialogInterval(1.0)
	elseif option == Settings_StateTimeoutDuration_OID
		SetSliderDialogStartValue(_SK_Setting_StateTimeoutDuration.GetValue())
		SetSliderDialogDefaultValue(24.0)
		SetSliderDialogRange(1.0, 24.0)
		SetSliderDialogInterval(1.0)
	endif
endEvent

event OnOptionSliderAccept(int option, float value)
	if option == Settings_SpeechSuccessChance_OID
		_SK_Setting_SpeechSuccessChance.SetValue(value / 100.0)
		SetSliderOptionValue(Settings_SpeechSuccessChance_OID, value, "{0}%")
		SaveSettingToCurrentProfileFloat("speech_success_chance", _SK_Setting_SpeechSuccessChance.GetValue())
	elseif option == Settings_StateTimeoutDuration_OID
		_SK_Setting_StateTimeoutDuration.SetValue(value)
		SetSliderOptionValue(Settings_StateTimeoutDuration_OID, value, "{0} Hours")
		SaveSettingToCurrentProfileFloat("state_timeout_duration", _SK_Setting_StateTimeoutDuration.GetValue())
	endif
endEvent

event OnOptionInputOpen(int option)
	if option == SaveLoad_RenameProfile_OID
		SetInputDialogStartText(GetProfileName(_SK_Setting_CurrentProfile.GetValueInt()))
	endif
endEvent

event OnOptionInputAccept(int option, string str)
	if option == SaveLoad_RenameProfile_OID
		if str != ""
			string profile_path = CONFIG_PATH + "profile" + _SK_Setting_CurrentProfile.GetValueInt()
			JsonUtil.SetStringValue(profile_path, "profile_name", str)
			JsonUtil.Save(profile_path)
			ForcePageReset()
		else
			ShowMessage("$SimplyKnockSaveLoadRenameErrorBlank", false)
		endif
	endif
endEvent

function ShowProfileHelp()
	ShowMessage("$SimplyKnockSaveLoadTopic", false)
	ShowMessage("$SimplyKnockSaveLoadTopicCont", false)
	ShowMessage("$SimplyKnockSaveLoadTopicCont2", false)
endFunction

string function GetProfileName(int aiProfileIndex)
	;bool b = JsonUtil.Load(CONFIG_PATH + "profile" + aiProfileIndex)
	return JsonUtil.GetStringValue(CONFIG_PATH + "profile" + aiProfileIndex, "profile_name", missing = "Profile " + aiProfileIndex)
endFunction

function SetProfileName(int aiProfileIndex, string asProfileName)
	JsonUtil.SetStringValue(CONFIG_PATH + "profile" + aiProfileIndex, "profile_name", asProfileName)
endFunction

function SaveSettingToCurrentProfileFloat(string asKeyName, float afValue)
	if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
		int current_profile_index = _SK_Setting_CurrentProfile.GetValueInt()
		JsonUtil.SetFloatValue(CONFIG_PATH + "profile" + current_profile_index, asKeyName, afValue)
		JsonUtil.Save(CONFIG_PATH + "profile" + current_profile_index)
	endif
endFunction

function SaveSettingToCurrentProfile(string asKeyName, int aiValue)
	if _SK_Setting_AutoSaveLoad.GetValueInt() == 2
		int current_profile_index = _SK_Setting_CurrentProfile.GetValueInt()
		JsonUtil.SetIntValue(CONFIG_PATH + "profile" + current_profile_index, asKeyName, aiValue)
		JsonUtil.Save(CONFIG_PATH + "profile" + current_profile_index)
	endif
endFunction

int function LoadSettingFromProfile(int aiProfileIndex, string asKeyName)
	return JsonUtil.GetIntValue(CONFIG_PATH + "profile" + aiProfileIndex, asKeyName, -1)
endFunction

function LoadProfileOnStartup()
	int auto_load = JsonUtil.GetIntValue(CONFIG_PATH + "common", "auto_load", 0)
	if auto_load == 2
		_SK_Setting_AutoSaveLoad.SetValueInt(2)
		int last_profile = JsonUtil.GetIntValue(CONFIG_PATH + "common", "last_profile", 0)
		if last_profile != 0
			_SK_Setting_CurrentProfile.SetValueInt(last_profile)
			SwitchToProfile(last_profile)
		else
			; default to Profile 1 and write the file
			_SK_Setting_CurrentProfile.SetValueInt(1)
			JsonUtil.SetIntValue(CONFIG_PATH + "common", "last_profile", 1)
			JsonUtil.Save(CONFIG_PATH + "common")
			SwitchToProfile(1)
		endif
	elseif auto_load == 1
		_SK_Setting_AutoSaveLoad.SetValueInt(1)
	elseif auto_load == 0
		; The file or setting does not exist, create it and default to auto-loading.
		; default to Profile 1 and write the file
		_SK_Setting_AutoSaveLoad.SetValueInt(2)
		_SK_Setting_CurrentProfile.SetValueInt(1)
		JsonUtil.SetIntValue(CONFIG_PATH + "common", "auto_load", 2)
		JsonUtil.SetIntValue(CONFIG_PATH + "common", "last_profile", 1)
		JsonUtil.Save(CONFIG_PATH + "common")
		SwitchToProfile(1)
	endif
endFunction

function SwitchToProfile(int aiProfileIndex)
	_SK_Setting_CurrentProfile.SetValueInt(aiProfileIndex)
	JsonUtil.SetIntValue(CONFIG_PATH + "common", "last_profile", aiProfileIndex)
	JsonUtil.Save(CONFIG_PATH + "common")

	string pname = JsonUtil.GetStringValue(CONFIG_PATH + "profile" + aiProfileIndex, "profile_name", "")
	if pname == ""
		GenerateDefaultProfile(aiProfileIndex)
	endif
	CleanProfile(aiProfileIndex)

	int val = LoadSettingFromProfile(aiProfileIndex, "speech_success_chance")
	if val != -1
		_SK_Setting_SpeechSuccessChance.SetValue(val)
	endif
	val = LoadSettingFromProfile(aiProfileIndex, "state_timeout_duration")
	if val != -1
		_SK_Setting_StateTimeoutDuration.SetValueInt(val)
	endif
	val = LoadSettingFromProfile(aiProfileIndex, "friends_allow_entry")
	if val != -1
		_SK_Setting_FriendsAllowEntry.SetValueInt(val)
	endif
	val = LoadSettingFromProfile(aiProfileIndex, "use_alt_menu")
	if val != -1
		_SK_Setting_UseAltMenu.SetValueInt(val)
	endif
endFunction

function GenerateDefaultProfile(int aiProfileIndex)
	string profile_path = CONFIG_PATH + "profile" + aiProfileIndex
	JsonUtil.SetStringValue(profile_path, "profile_name", "Profile " + aiProfileIndex)
	JsonUtil.SetFloatValue(profile_path, "speech_success_chance", 0.5)
	JsonUtil.SetFloatValue(profile_path, "state_timeout_duration", 24.0)
	JsonUtil.SetIntValue(profile_path, "friends_allow_entry", 2)
	JsonUtil.SetIntValue(profile_path, "use_alt_menu", 1)
	JsonUtil.Save(profile_path)
endFunction

function SaveAllSettings(int aiProfileIndex)
	string profile_path = CONFIG_PATH + "profile" + aiProfileIndex
	JsonUtil.SetFloatValue(profile_path, "speech_success_chance", _SK_Setting_SpeechSuccessChance.GetValue())
	JsonUtil.SetFloatValue(profile_path, "state_timeout_duration", _SK_Setting_StateTimeoutDuration.GetValue())
	JsonUtil.SetIntValue(profile_path, "friends_allow_entry", _SK_Setting_FriendsAllowEntry.GetValueInt())
	JsonUtil.SetIntValue(profile_path, "use_alt_menu", _SK_Setting_UseAltMenu.GetValueInt())
	JsonUtil.Save(profile_path)
endFunction

function CleanProfile(int aiProfileIndex)
	string profile_path = CONFIG_PATH + "profile" + aiProfileIndex

	; Added in 1.0.2
	int val = LoadSettingFromProfile(aiProfileIndex, "use_alt_menu")
	if val == -1
		JsonUtil.SetIntValue(profile_path, "use_alt_menu", 1)
	endif
endFunction
