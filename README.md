# StarCraft Cursor Sets
An implementation of the StarCraft 2 Cursors for use in Linux and Windows desktops, several colors available as well as semi-custom remixes and slight artistic liberties taken.

# Manual Installation

- Linux
1. Download `SC_Cursors_Linux.tar.gz` from the Releases page.
2. Extract.
3. Choose which cursors you would like, or all.  Extract them for a manual install.
4. Place cursors in your `~/.icons` directory such that it shows `~/.icons/SC_Cursors_Terran_Blue`
5. Use your distribution's settings to set this cursor as your set.

Note: If you are using a KDE Plasma distro you do not need to extract and place files, you can navigate to Colors & Themes > Cursors in System Settings, and `Install from File...` then import the `.tar.gz` file you would like directly.

- Windows
1. Download `SC_Cursors_Windows.zip` from the Releases page.
2. Extract.
3. Choose which cursors you would like, and move the folder to C:\Windows\Cursors (This is not required but will make subsequent steps easier)
4. In Settings, navigate to Bluetooth & devices > Mouse, then click additional mouse settings.
5. Choose the `Pointers` tab, click on the Normal Select cursor, then browse, you will have to set each cursor manually, and I have a list of what each cursor is below (each of my cursors will have a suffix appended like `SC_T_G` for Terran Green, but the prefixes are what you are looking for):

- Normal Select - aero_arrow
- Help Select - aero_helpsel
- working In Background - aero_working
- Busy - aero_busy
- Precision Select - cross
- Text Select - beam
- Handwriting - aero_pen
- Unavailable - aeo_unavail
- Vertical Resize - aero_ns
- Horizontal Resize - aero_ew
- Diagonal Resize 1 - aero_nesw
- Diagonal Resize 2 - aero_nwse
- Move - aero_move
- Alternate Select - aero_up
- Link Select - aero_link
- Location Select - Not available (aero__link)
- Person Select - Not available (aero__link)

6. I recommend saving the scheme as a new one such as `SC Terran Green` so you can return to your original pointer settings later if desired.

Note: The Windows install is far more involved than the Linux one, especially since the Linux version has an easy installer.  I know it is possible to create an easy installer for Windows, but I am not particularly interested in developing for Windows.  If you would like to develop a script or even just a more streamlined way to do this, feel free to contact me and I will include it in this repo, or fork this and make your own if you have the skills, I am open to Pull Requests.

# Upcoming

Currently Terran Green, Blue, Red, Yellow, Purple, Zerg Purple and Protoss Daelam are included.  I have spirations to do multiple colors for Zerg and Protoss but they're quite a bit more difficult to work with than Terran.  And even in the game those cursors default to Terran ones on different contexts.

# Notes

This repo contains not only the x11 cursor files for a Linux based system to use StarCraft 2 cursors, but also .cur (and .ani) files for Windows to do so as well.  There is also all of my materials I used to do so, the original dds textures pulled directly from the game, the png converted versions, .conf files used to create Linux x11 files, and the xcf files I used in GIMP to do so.

Also included is the clickgen_cross.py script that I used to easily convert batches of png and .conf files into cursors for both Linux and Windows.  Clickgen is required `https://github.com/ful1e5/clickgen`.  WARNING:  The code contained in all scripts was partially or entirely AI generated, you have been warned.  No AI tools were used for the artistic portion of the process whatsoever.

# License

These cursor assets are derived from StarCraft / StarCraft II and are © Blizzard Entertainment.
This repository is for preservation and personal use only.
I do not claim ownership of the original assets.
