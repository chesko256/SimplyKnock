Hey there! I decided to take a short break from Campfire and Frostfall development to put this small mod together over the last 5 days or so. I hope you enjoy it!

 -- Chesko

**[Nexus Download](http://www.nexusmods.com/skyrim/mods/73236)**

Abridged File Description:
-----------------------

**Simply Knock** is the first feature-complete mod that allows you to **knock on locked doors of houses in Skyrim**. If anyone is home, they will answer the door! You can then flex your speechcraft skills in order to get them to allow you inside. If someone inside is a friend, they will always permit you to enter.

All house doors in Skyrim can be knocked on if locked, as well as some businesses where people live (farms, stores, etc).

If you need a quiet place to stay the night, or want to visit someone you know at odd hours, just knock on the door like a normal civilized person. Also useful for checking to see if anyone's home before you commit your next burglary.

My goal was to make a very simple, lightweight, no-nonsense mod that had a place in almost everyone's game, regardless of mod tastes or playstyle.

How To Use
----------
Click on any locked residence in Skyrim. Instead of the lockpicking screen, [you will be given the choices of "Knock", "Leave", and "Unlock"](http://i.imgur.com/MpcEWiO.jpg). If someone is home, they will [answer the door](http://i.imgur.com/YOgwCi2.jpg). You can [talk to them through the door](http://i.imgur.com/C2oOvru.jpg) and try to [bargain your way in](http://i.imgur.com/vKKEA8N.jpg). People that are your friend [always allow you to enter](http://i.imgur.com/5W5oy4o.jpg) (configurable), so being helpful pays off.

If no one is home, you will receive the message "No answer."

That's all there is to it.

How This Mod Came To Be
-----------------------
A few nights ago I was happily playing when I decided to visit my good buddy Faendal after dark. I helped him out with his lady problems just the other day, and I figure, we're pals, right? It was then I realized, as I had realized many times in the past, the only way I could talk to him right now was:

1. Stand outside his door until morning, like a chump
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

How It's Different
------------------
Why hasn't a mod like this been made already? A few have, but up until now they've all had some critical shortcomings.

What makes this mod unique is that it solves a difficult problem: discovering what cell a door leads to.

Weird as it sounds, there is no default Papyrus function for getting the destination of a door. From a script's perspective, stepping through a door in Skyrim is a lot like [stepping through a wormhole](https://i.ytimg.com/vi/BKE71l7_MgQ/maxresdefault.jpg); you don't know where you'll end up or what's inside. Because of this, it was impossible to discover important things like "Where does this door go?", "Who owns this door?" and "Are the owners home?", before you actually go through the door.

Simply Knock implements a custom SKSE function GetLinkedDoor() that sidesteps this problem and provides this missing piece of information to make the rest of this mod possible.

If you would like to use Simply Knock's SKSE implementation of GetLinkedDoor(), feel free to use any of the code found in [simplyknock_skse_plugin](https://github.com/chesko256/SimplyKnock/tree/master/simplyknock_skse_plugin) when creating your own SKSE plug-in. It is free for anyone to use.

Credits
-------
* Credit to the SKSE team.
* Huge thanks to PurpleLunchBox and Verteiron for helping me create my first SKSE plugin!
* Includes portions of PapyrusUtil 3.2.
* DoorGlassKnock 166 from FreeSoundEffects.com. [Link to asset](http://www.freesoundeffects.com/track/doorglassknock-166-438782/knock%20door/), [License Agreement](http://www.freesoundeffects.com/licence.php)
* Vector - Wooden door (Image ID: csp12847818) from www.canstockphoto.com. [Link to asset](http://www.canstockphoto.com/wooden-door-12847818.html), [License Agreement](http://www.canstockphoto.com/license_print.php?id=2)
