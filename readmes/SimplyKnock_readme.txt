===================================================

Simply Knock

For The Elder Scrolls V: Skyrim

Author: Chesko

E-mail - chesko.tesmod@gmail.com

===================================================

Simply Knock is the first feature-complete mod that allows you to knock on locked doors of houses in Skyrim. If anyone is home, they will answer the door! You can then flex your speechcraft skills in order to get them to allow you inside. If someone inside is a friend, they will always permit you to enter.

All house doors in Skyrim can be knocked on if locked, as well as some businesses where people live (farms, stores, etc).

If you need a quiet place to stay the night, or want to visit someone you know at odd hours, just knock on the door like a normal civilized person. Also useful for checking to see if anyone's home before you commit your next burglary.

My goal was to make a very simple, lightweight, no-nonsense mod that had a place in almost everyone's game, regardless of mod tastes or playstyle.

Change Log
----------
The latest changes are documented on Simply Knock's change log on Evernote(https://www.evernote.com/shard/s53/sh/996bc3d6-e15f-48b0-b4c8-d8ea1281a38a/33ee88c997a62a02d65a40799e2818b1).

How To Use
----------
Click on any locked residence in Skyrim. Instead of the lockpicking screen, you will be given the choices of "Knock", "Leave", and "Unlock". If someone is home, they will answer the door. You can talk to them through the door and try to bargain your way in. People that are your friend always allow you to enter (configurable), so being helpful pays off.

If no one is home, you will receive the message "No answer."

That's all there is to it.

Requirements
------------
* Skyrim 1.9.32.0
* SKSE 1.7.3+
* SkyUI 4.1+ (SkyUI-Away is fine)

Installation
------------
Just install as normal with your mod manager of choice. If conflicts arise due to PapyrusUtil components (JsonUtil, StorageUtil), choose to overwrite those components, and / or load this mod as close to last as you can in your load order (in Mod Organizer, with highest Priority value possible). This is not a source of a conflict; please do not create a bug report about this.

Please do not unpack the BSA archive into your Skyrim / mod installation directory. This can lead to unwanted behavior if installing an update to this mod. If you want to look at or download the source code, please clone the GitHub repository(https://github.com/chesko256/SimplyKnock).

Uninstallation
--------------
* Go to an exterior cell.
* Wait 48 hours in-game.
* Save your game.
* Uninstall the mod.


How This Mod Came To Be
-----------------------
A few nights ago I was happily playing when I decided to visit my good buddy Faendal after dark. I helped him out with his lady problems just the other day, and I figure, we're pals, right? It was then I realized, as I had realized many times in the past, the only way I could talk to him right now was:

1. *Stand outside his door until morning*, like a chump
2. Literally *break into his house*

I said "enough is enough" and then set about creating this.


Details and Features
--------------------
The voice of the person you hear on the other side of the door will match the person actually answering the door. Yay!

If no one is home, or no one is able to answer the door, no one will answer.

Simply Knock implements a Mod Config Menu to configure a few minor settings, such as how difficult or easy your speechcraft attempts should be. It also adds Settings Profiles, as seen in some of my other mods. Configure it once, and your settings are ready on your next character or play-through automatically.

If allowed inside, the area will remain unlocked and the occupants will be non-hostile to you (will not accuse you of trespassing) for the duration of your stay, or until the next time their "lock up the doors" routine starts (usually the next day). Try not to overstay your welcome.

If the occupant refuses to let you in, they will continue to refuse you for 24 hours (configurable). Continued knocking will do nothing.

Simply Knock is smart enough to not display the Knock option inside dungeons with locked doors, or in other hostile areas where this option doesn't make sense. It also doesn't display the option when inside and trying to go outside.

Settings
--------------------
* Base success chance of requests - The base chance of how often you will succeed in requesting to come inside, unmodified by Speechcraft skill. Speechcraft adds 0.5% chance per point of Speechcraft. Default: 50%.
* Request failure timeout period - How long before you can try to request entry at a given location again after failure. Default: 24 hours.
* Friends always allow entry - If enabled, friends will always allow you to enter. Default: Enabled.
* Settings Profiles - This mod saves your settings to a profile by default, and are persistent across saves and new games. If you use mods like Campfire or Frostfall 3, you are probably familiar with this feature.

Performance and Design
----------------------
Obviously, since this mod implements somewhat complex behavior, this mod requires scripting. However, there are no always-running, background scripts. This mod should not impact you performance at all on an ordinary basis.

When you succeed or fail a persuasion/intimidation check, a small invisible marker is placed near the door, which has a small script that stores this data, but otherwise does nothing. This way the mod can "remember" if you've tried this door already and what the result was. After 24 hours (configurable), the marker deletes itself, so the mod "forgets" the attempt and you can try again.

The mod uses one new AI package (applied dynamically) to keep the person that answered the door awake and out of bed for the duration of your visit. The person who answered will revert back to normal behavior as soon as you leave, almost always locking the door behind you.


How It's Different
------------------
Why hasn't a mod like this been made already? A few have, but up until now they've all had some critical shortcomings.

What makes this mod unique is that it solves a difficult problem: discovering what cell a door leads to.

Weird as it sounds, there is no default Papyrus function for getting the destination of a door. From a script's perspective, stepping through a door in Skyrim is a lot like stepping through a wormhole(https://i.ytimg.com/vi/BKE71l7_MgQ/maxresdefault.jpg); you don't know where you'll end up or what's inside. Because of this, it was impossible to discover important things like "Where does this door go?", "Who owns this door?" and "Are the owners home?", before you actually go through the door.

Simply Knock implements a custom SKSE function GetLinkedDoor() that sidesteps this problem and provides this missing piece of information to make the rest of this mod possible.

If you would like to use Simply Knock's SKSE implementation of GetLinkedDoor(), feel free to use any of the code found in simplyknock_skse_plugin(https://github.com/chesko256/SimplyKnock/tree/master/simplyknock_skse_plugin) when creating your own SKSE plug-in. It is free for anyone to use.

Compatibility
-------------
* Simply Knock attempts to match the voice type of the occupant with a list of known common voice types. This will catch 90%+ of possible cases in the game. If the voice type of the occupant is unique, the system defaults to using MaleEvenToned or FemaleEvenToned and the speaker is named "Indistinct Voice" instead of "Voice". This just means that the person you hear on the other side of the door might not match what they actually sound like in this case.

* This mod is designed around knocking on locked doors that lead to another interior cell. This, again, catches 90%+ (if not 100%) of the cases in the vanilla game. If you are using a mod that brings the interiors of buildings into the Tamriel (or other outdoor) worldspace, or a mod that adds new houses / building that have their interiors in the same cell as the exterior, this mod will not function in those instances, and the author has no intention of supporting such a case.

* This mod uses a perk in order to override the activation of doors. If you use another mod that also uses a perk to override door activation, it will be incompatible with Simply Knock.

* Includes StorageUtil.dll and JsonUtil.pex/psc from PapyrusUtil 3.2. This mod can run along-side other mods that implement PapyrusUtil and also include these files. It is recommended that you load this mod last / later than (in Mod Organizer, with a higher Priority) other mods that implement PapyrusUtil.

* Other than those specific cases above, should be compatible with everything.

FAQ
---
* I want to report a bug. What should I include in my bug report?    
If you observe unwanted behavior, I need the following information. Failure to include this information means you will probably receive no assistance.
  * What building door you knocked on
  * Who answered the door (if known)
  * The time of day in-game
  * What specific dialogue options you chose

* Does this mod use scripts?    
Yes.

* Is this mod "script heavy"? Will it impact my performance?    
No.

* Does this mod use any always-on, frequently-running background scripts?    
No.

* Is it compatible with (insert mod here)?    
It is very, very likely that it is. See Compatibility section for details.

* Has this mod been cleaned with TES5Edit?    
Yes.

* Does this mod include an MCM translated into my language?    
A machine translation of the MCM is included with the mod for your convenience for all languages that SkyUI supports, to ensure that the widest number of non-English users can more-or-less navigate the mod's options. A real translation is most likely desirable; reach out to your favorite translator, or feel free to translate it yourself.

* Can I ding dong dash?    
Nice one, chucklehead. But seriously, I thought about it, but I had a rather aggressive development timeline for the release (5 days) and it simply wasn't important enough. It also has a high likelihood of leading to unwanted behavior.

Credits
-------
* Credit to the SKSE team.
* Huge thanks to PurpleLunchBox and Verteiron for helping me create my first SKSE plugin!
* Includes portions of PapyrusUtil 3.2.
* DoorGlassKnock 166 from FreeSoundEffects.com. Link to asset(http://www.freesoundeffects.com/track/doorglassknock-166-438782/knock%20door/), License Agreement(http://www.freesoundeffects.com/licence.php)
* Vector - Wooden door (Image ID: csp12847818) from www.canstockphoto.com. Link to asset(http://www.canstockphoto.com/wooden-door-12847818.html), License Agreement(http://www.canstockphoto.com/license_print.php?id=2)

Permissions
-----------
* You are not allowed to re-upload this file, in whole or in part, anywhere, for any reason, without the author's written permission, with the exception of free use of the SKSE C++ project / implementation of GetLinkedDoor() as mentioned in the Compatibility section.
* You may translate this mod into a language other than English and upload the portions of the mod required for that translation (such as the plug-in file and the MCM Translation text files), without permission; you already have permission. Your translation must require that the user download the main, English-version mod in order to work. No stand-alone translations.
* If I cannot be reasonably reached via e-mail, Reddit, PM, or Twitter for 6 months, this mod becomes public domain and free for anyone to use and redistribute for any reason.

License
-------
The license for Simply Knock is available on Evernote(https://www.evernote.com/shard/s53/sh/b2ff37b7-4d04-433d-b769-238bd7447bc7/ee566b7196e692fcb588a755ee0bfb87)**.
