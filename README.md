<p align="left">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/zearp/Nucintosh/refs/heads/master/Stuff/nucintosh-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/zearp/Nucintosh/refs/heads/master/Stuff/nucintosh-light.svg">
    <img alt="Nucintosh" src="https://raw.githubusercontent.com/zearp/Nucintosh/refs/heads/master/Stuff/nucintosh-light.svg" width="360">
  </picture>
</p>

This is a quick and dirty repo for Intel NUC 8th gen Coffee Lake models (NUC8IxBEx). I've used various sources (see credits) to build my EFI and did quite some testing. It should leave you with a stable and reliable build but as always, these things are never really finished. Compatible with macOS Mojave, Catalina, Big Sur, Monterey, Ventura, Sonoma and Sequoia.

This document has been overhauled in November 2026 to clean up things that are outdated or no longer relevant and to make things more clear.

## Index
* [Installation](#installation)
* [Post install](#post-install)
* [Updating](#updating)
* [Assumed install target](#assumed-install-target-is-sequoia)
* [Experimental Tahoe](#experimental-tahoe)
* [What works?](#what-works)
* [What doesn't work?](#not-workinguntested)
* [Credits](#credits)

## Installation

+ If you haven't already also be sure to install the latest HDMI and Thunderbolt firmwares found [here](https://www.asus.com/supportonly/nuc8i5beh/helpdesk_bios/) which can only be installed in Windows. It fixes issues with both and if you use a HDMI 2.0 monitor it is highly recommended to update the firmwares.
+ Update to the latest ([0098](https://www.asus.com/supportonly/nuc8i5beh/helpdesk_bios/) BIOS -> load BIOS defaults -> click advanced and change;

```
Devices -> USB -> Port Device Charging Mode: off
Devices -> USB -> USB Legacy -> Disabled
Security -> Thunderbolt Security Level: Legacy Mode
Power -> Wake on LAN from S4/S5: Stay Off
Boot -> Boot Configuration -> Network Boot: Disable
Boot -> Secure Boot -> Disable
```
+ Download macOS from the App Store and create a USB installer with *[createinstallmedia](https://support.apple.com/en-us/HT201372)* on macOS (real mac/hack or vm) or use [gibMacOS](https://github.com/corpnewt/gibMacOS)\*
+ Download the EFI folder [here](https://github.com/zearp/Nucintosh/releases) or download/clone the complete repo for latest builds
+ When not installing Sonoma download the AirportItlwm.kext file matching your macOS install from the ```Stuff``` folder and replace the one in the kext folder with it. Not doing this may cause a boot loop.
+ Edit config.plist with [ProperTree](https://github.com/corpnewt/ProperTree) and change the following fields;
```
PlatformInfo -> Generic -> MLB
PlatformInfo -> Generic -> ROM
PlatformInfo -> Generic -> SystemSerialNumber
PlatformInfo -> Generic -> SystemUUID
```
Generate new serials/rom with [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS).
+ Copy the EFI folder to the EFI partition on the USB installer
+ Clear NVRAM from the OpenCore picker
+ Install macOS

\* Installers made with GibMacOS on Windows and Linux require a working internet connection as it uses the recovery image only, it then downloads the full installer from Apple. The *createinstallmedia* script makes a fully offline installer. The latter is greatly preferred and will save a lot of time and bandwidth given the installers are getting quite large.

> Note: While this should be sorted and it should boot into the right entry OpenCore doesn't always select the correct partition in the picker when installing. You will only need to boot into the installer once: do your formatting and have the installer copy all it needs to the internal disk. From that point onwards always make sure and if needed select the internal disk from the picker. The name might change during the installation, but it should be easy to spot as it won't have an "external" label.

## Post install
- Disable `NVMeFix.kext` if you don't have an NVMe drive
- Copy the EFI folder from the installer's EFI partition to the internal disk's EFI partition so it can booted from it. You can use [EFI Agent](https://github.com/benbaker76/EFI-Agent) to easily mount EFI partitions.

Finally make sure sleep works properly, `hibernatemode` and `standby` must be set to 0 or sleep will be buggy and misbehave. You can skip some of the others it will increase the number of `DarkWake` cycles it will do. Which is normal, it can check for mail, messages, etc. I prefer to reduce those as much as possible. So it all goes to `0` on my machines.
```
sudo pmset autopoweroff 0
sudo pmset hibernatemode 0
sudo pmset powernap 0
sudo pmset proximitywake 0
sudo pmset standby 0
sudo pmset tcpkeepalive 0
sudo pmset womp 0
```

- Proximity wake can wake your machine when an iDevice is near
- Power Nap will wake up the system from time to time to check mail, make Time Machine backups, etc, etc
- Disabling TCP keep alive has resolved periodic wake events after setting up iCloud, just disabling `Find My` wasn't enough.
- Womp is wake on lan, which is disabled in the BIOS as it (going by other people's experience) might cause issues. I never use WOL, if you do use WOL please try enabling it in the BIOS and leave this setting on, the issues might have been due to bugs that haven been solved by now. Let me know if it works or not.
- Hibernate is sometimes set to 3 in my testing. It could be possible to get hibernation to work by using [HibernationFixup](https://github.com/acidanthera/HibernationFixup) but I haven't tested it. I'm fine with normal sleep.

With hibernation disabled you can delete the sleep image file and create an empty folder in its place so macOS can't create it again, this saves some space and is optional.
```
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

At this point you should enable FileVault to encrypt your disk. The config is setup to support this and it works flawlessly. Just make sure you store the recovery key on another pc or usb stick or sign into iCloud first so you can use that to recover if you forget the password to your macOS system account.

To get a nicer boot experience you can remove the verbose boot flag `-v` in the config and also set `ShowPicker` to false. This will show the Apple logo and not show any OpenCore menu or verbose booting. To get the OpenCore picker/menu to show hold down the *alt* key when booting.

Sometimes the hostname stays the same after changing it in preferences. These commands will sort that out;
```
sudo scutil --set ComputerName "nuc"
sudo scutil --set LocalHostName "nuc"
sudo scutil --set HostName "nuc"
dscacheutil -flushcache
```

That's all!

> Tip: Once everything works and you installed and configured all your stuff, create a bootable clone of your system with a trial version of *Carbon Copy Cloner* or *Superduper!*. Don't forget to copy your EFI folder to the clone's EFI partition. First time? Follow my little guide [here](https://github.com/zearp/OptiHack/blob/master/text/CLONE_IT.md).

## Updating
Updating the EFI is easy, first copy the MLB/ROM/SystemSerialNumber/SystemUUID values from your current config to a text file then delete the whole EFI folder and replace it with the latest release/clone from this repo. Copy your PlatformInfo fields from the text file into the new config. Unless you made other changes this is all thats needed.

Sometimes macOS updates can revert sleep related settings. This doesn't always happen but is something to keep in mind. If sleep stops working (properly) check and re-apply the power settings like the (post install section)[#post-install].

> Note: Incremental updates will not always work and will error out during the preparation phase and a full installer will be downloaded as fallback unless `BlueToolFixup.kext` is disabled. Disable it when it errors out to speed OTA updates up or just let it download the full installer if you have the bandwidth and time for it. There is a (small) chance it is caused by another kext but it's rare in which case just fall back on the full installer. If you really want to find out which kext may have caused it you can learn more here: https://github.com/acidanthera/bugtracker/issues/2080

## Assumed install target is Sequoia:
Please note that from the 13th of October 2025 the assumed installation target will be macOS Sequoia.

You can still install on older versions, on Sonoma and older just swap out `AirportItlwm.kext` with `AirportItlwm.kext` matching your target version from the `Stuff` folder on the repo. Use the snapshot function in ProperTree to easily update the config once you made the kext swaps. when you change the model/SMBIOS be sure to also update 2 lines inside the usb map to reflect that model. If you encounter bluetooth issues on versions prior to Monterey you may also have to replace `BlueToolFixup.kext` with `IntelBluetoothInjector.kext` which can also be found in the `Stuff` folder on the repo. Also keep in mind that using models that have a T2 chip this may cause issues with OTA updates and you might need to add `iBridged.kext` but thats beyond the scope of this repo. Good luck!

## Experimental Tahoe
After quite some testing concerning power management I have decided to release an experimental Tahoe EFI. I've dug into the Tahoe kernel and also created an AGPM injector for the iGPU (also for the Sequoia EFI) that sets the iGPU power management profile to `Mac mini 8,1` which has the same iGPU as our NUCs. I've also checked and tested other power management that works fine on Sequoia as that actually supports 8th generation Intel. Compared that against Tahoe it seems Apple did not actually remove all the older Intel platforms from the kernel itself, it just gates installs depending on the model. Some very old platforms are completely removed because newer macOS depends on certain cpu instructions that simply did not exist on those platforms. For Tahoe we use `iMac 20,1` which sadly a T2 machine so there will be some extra steps needed post-install but thats merely a simple a `config.plist` edit.

You can download the test EFI [here](https://github.com/zearp/Nucintosh/blob/master/Stuff/Experimental-Tahoe-EFI.zip) and report issues with it here: https://github.com/zearp/Nucintosh/issues/179, setup is the same as always: create the installer usb stick, populate the config with a freshly generated set of serials for the `iMac 20,1` using `GenSMBIOS` or similar utility and copy it to the EFI partition on the installer usb stick.

Booting into the installer will take a while, it will show the beginning of a progress bar that does progress and just finishes after a while. Apple might fix this is newer version that the `26.7.2` I did my testing with. After install it will take a few hours to a day for all the background processing is done (maybe more if you got a lot of iCloud stuff) it should be fine and on par with Sequoia. Not letting it sleep and not using it can help speed it up, it uses less resources when the user is active thus making the process slower. Patience is key.

#### Installation:
1. Install as normal and copy the EFI to the internal disk
2. Now edit the `config.plist` and change `SecureBootModel` to `j185` then reboot and reset NVRAM from the picker menu.
3. Step 2 is done to fix OTA updates and there is no step 3.

OTA updates should now work, don't forget to disable `BlueToolFixup.kext` if you want to install the smaller delta updates. Not doing so will trigger it to download a full installer which can take a while depending on your internet speed.

> Note: Updating from Sequoia is possible but you need to make sure you sign out of iCloud/AppleID in settings, App Store, iMessage, FaceTime and any other (Apple) apps that signs you in using AppleID like Mail etc. Not doing so could lead to getting into some issues signing in again using a new model/serial/etc -- this does not always happens but in my experience it is better to just log out everywhere vs dealing with issues later. It only takes a bit of extra time. Other software might also behave differently if it uses some kind of machine based hid to register apps and such. In theory all apps including Apple's own should deal with this better, like you could buy a new Mac and move a backup to it without signing out an end up in the same state. Apple support forums have plenty of threads on it, so just log out in apps where you can. This of course does not apply to websites you logged into in a browser.

## What works?
+ Intel Iris 655 iGPU
+ Audio using ALC235
+ NVMe and SATA
+ Intel 9560 wireless/bluetooth
+ Intel I219-V ethernet
+ Thunderbolt 3, including hot plugging
+ USB ports, all mapped including internal ports
+ HDMI 2.0 and DisplayPort (over usb-c)
+ Sleep/wake

## Not working/untested
+ IR receiver (it shows up in ioreg but no idea how to make macOS use it like on some MacBooks)
+ Card reader is disabled by default due to rare kernel panics, you can enable it if/when you need to to use it. Please open an issue with the kernel panic you get one so I can work on trying to fix it.
+ Some, not all [continuity](https://www.apple.com/macos/continuity/) features work with the onboard Intel wifi/bt combo.
+ You tell me in an issue!

## Credits
+ https://github.com/acidanthera
+ https://github.com/OpenIntelWireless
+ https://dortania.github.io/OpenCore-Install-Guide/config.plist/coffee-lake.html
+ https://github.com/osy
+ Many [random](https://github.com/Rashed97/Intel-NUC-DSDT-Patch/commit/47476815b52f8e4c97e8f85df158c9ab1b6ecedd) repos [with](https://github.com/honglov3/NUC8I7BEH) information [and](https://github.com/sarkrui/NUC8i7BEH-Hackintosh-Build) research [that](https://github.com/mbarbierato/Intel-NUC8i3BEH) I've [forgotten](https://github.com/honglov3/NUC8I7BEH) about.
