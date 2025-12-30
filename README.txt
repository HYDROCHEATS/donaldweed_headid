====================================================
HeadID System
Author: DonaldWeed
Version: 1.2.0
Framework: ESX
====================================================

DESCRIPTION
----------------------------------------------------
This script displays contextual player information
above characters in-game.

Displayed information:
- Player name or anonymous label
- Server ID

The system is designed for realistic roleplay
and avoids global player identification.

----------------------------------------------------
FEATURES
----------------------------------------------------
- Head display (Name / Stranger + ID)
- Player relationship system (Handshake)
- Masks hide player identity
- Display only within voice range
- Admins invisible in admin mode
- Performance optimized (distance + cache)

----------------------------------------------------
INSTALLATION
----------------------------------------------------
1. Place the folder "headid" into your resources directory

2. Import the SQL file:
   - sql.sql into your database

3. Add to server.cfg:
   ensure headid

4. Restart your server

----------------------------------------------------
USAGE
----------------------------------------------------
HANDSHAKE COMMAND:
/handshake

Requirements:
- Maximum distance: 3 meters

After a handshake, both players will recognize
each other by name.

----------------------------------------------------
DISPLAY LOGIC
----------------------------------------------------
- Known player, no mask:
  → Player Name + ID

- Unknown player:
  → Stranger + ID

- Player wearing a mask:
  → Unknown (Mask) + ID

- Outside voice range:
  → No display

----------------------------------------------------
VOICE RANGE
----------------------------------------------------
Default range: 8 meters

Configurable in:
client.lua

Variable:
voiceDistance = 8.0

----------------------------------------------------
ADMIN MODE
----------------------------------------------------
Admins with admin mode enabled:
- Are not displayed above their character
- Can still see other players normally

Requirement:
adminmode = true

----------------------------------------------------
MASK SYSTEM
----------------------------------------------------
- Any worn mask hides identity
- Masks override known player names
- Identity remains hidden while mask is worn

----------------------------------------------------
CONFIGURATION
----------------------------------------------------
File: client.lua

Important values:
- voiceDistance
- drawDistance
- maskComponent

----------------------------------------------------
NOTES
----------------------------------------------------
- Designed for serious roleplay environments
- No global player list
- No wallhack-style identification
- Situational and fair gameplay

----------------------------------------------------
AUTHOR
----------------------------------------------------
Developed by:
DonaldWeed

All rights reserved.
====================================================
