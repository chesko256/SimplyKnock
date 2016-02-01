# Simply Knock
**Simply Knock** is the first, and only, fully-featured mod that allows you to **knock on locked doors in Skyrim**. If anyone is home, they will answer the door! You can then flex your persuasion or intimidation skills in order to get them to allow you inside. If someone inside is a friend, they will always permit you to enter.

If you need a quiet place to stay the night, want to visit someone you know at odd hours, or check to see if anyone's home before you commit your next burglary, simply... knock!

How To Use
----------
Click on any locked residence in Skyrim. Instead of the lockpicking screen, you will be given the choices of "Knock", "Leave", and "Unlock". That's all there is to it.

How This Mod Came To Be
-----------------------
A few nights ago I was happily playing when I decided to visit my good buddy Faendal after dark. I helped him out with his lady problems just the other day, and I figure, we're pals, right? It was then I realized, as I had realized many times in the past, the only way I could talk to him right now was:

1. *Stand outside his door until morning*, like a chump
2. Literally *break into his house*

I said "enough is enough" and then set about creating this.


Details and Features
--------------------
For maximum immersion, the voice of the person you hear on the other side of the door will match the person actually answering the door!

Simply Knock implements a Mod Config Menu to configure a few minor settings, such as how difficult or easy your speechcraft attempts should be. It also adds Settings Profiles, as seen in some of my other mods. Configure it once, and your settings are ready on your next character or play-through automatically.

If allowed inside, the area will remain unlocked and the occupants will be non-hostile to you (will not accuse you of trespassing) for the duration of your stay, or until the next time their "lock up the doors" routine starts (usually the next day). Try not to overstay your welcome.

If the occupant refuses to let you in, they will stop answering the door for 24 hours. Continued knocking will do nothing.

Simply Knock is smart enough to not display the Knock option inside dungeons with locked doors, or in other hostile areas where this option doesn't make sense. It also doesn't display the option when inside and trying to go outside.

Children will not answer the door.


Performance and Design
----------------------
Obviously, since this mod implements somewhat complex behavior, this mod requires scripting. However, there are no always-running, background scripts. This mod should not impact you performance at all on an ordinary basis.

This mod checks references when the target under the crosshair changes, checking to see if it is a door. This check fails fast and stops all other processing if it's not a door. If it is a door, it attempts to do some pre-validation before you click on it so that the right menu is presented to you.

If you select "Knock", the mod will scan the interior cell and attempt to find either the owner of the door, or members of a faction who own the door. If there are more than one owner found, one is selected at random and they are chosen to answer the door. If, for whatever reason, the cell is locked but occupied only by non-owners, no one will answer the door. Only an owner may answer. The system biases towards returning friends, if someone inside is friends with the player.

When you succeed or fail a persuasion/intimidation check, a small invisible marker is placed inside the locked cell, which has a small script that stores this data, but otherwise does nothing. This way the mod can "remember" if you've tried this door already and what the result was. After 24 hours, the marker deletes itself, so the mod "forgets" the attempt and you can try again.


How It's Different
------------------
What makes this mod unique is that it solves a difficult problem that has prevented a mod like this from being made successfully in the past. That problem is: discovering what cell a linked door leads to.

Weird as it sounds, there is no default Papyrus function for getting the destination of a door. From a script's perspective, stepping through a door in Skyrim is a lot like [stepping through a wormhole](https://i.ytimg.com/vi/BKE71l7_MgQ/maxresdefault.jpg); you don't know where you'll end up or what's inside. Because of this, it was impossible to discover important things like "Where does this door go?", "Who owns this door?" and "Are the owners home?". 

Simply Knock implements a custom SKSE function GetLinkedDoor() that sidesteps this problem and provides this missing piece of information to make the rest of this mod possible. 

Huge thanks to PurpleLunchBox and Verteiron for helping me create my first SKSE plugin!