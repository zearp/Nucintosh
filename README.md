# NUC8IxBEx Hackintosh
This is a quick and dirty repo for Intel NUC 8th gen computers. It should work on all the Coffee Lake ones. I've used various sources to get to this point and did quite some testing. It should leave you with a stable and reliable build but as always, these things are never really finished. While it should work on older macOS versions, I've done all building and testing on Catalina and Big Sur.

## Details
* Works with macOS *Catalina* and *Big Sur*[\*](#big-sur)
* OpenCore bootloader with the following kexts:
  - Lilu
  - VirtualSMC
  - WhateverGreen
  - AppleALC
  - IntelMausi
  - NVMeFix
  - CPUFriend
  - OpenIntelWireless kexts for bluetooth and wifi
  - FakePCIID (without this audio over hdmi only works when re-plugging the cable)
  
## Index
* [Installation](#installation)
* [Post install](#post-install)
* [Big Sur](#big-sur)
* [Apple and 3rd party wifi/bt](#apple3rd-party-bluetooth-and-wifi)
* [ThunderBolt](#thunderbolt)
* [Intel wifi/bt](#intel-bluetooth-and-wifi)
* [Native bt dongle](#natively-supported-bluetooth-dongle)
* [What works and what does't?](#not-workinguntested)
* [Performance, power and noise](#performance-power-and-noise)
  - [Noise](#noise)
  - [Passive cooling](#passive-cooling) 
* [Credits](#credits)
  
## Installation
+ Update to latest BIOS -> load BIOS defaults -> click advanced and change;
```
Devices -> USB -> Port Device Charging Mode: off
Security -> Thunderbolt Security Level: Legacy Mode
Power -> Wake on LAN from S4/S5: Stay Off
Boot -> Boot Configuration -> Network Boot: Disable
Boot -> Secure Boot -> Disable
```
+ Download macOS form the App Store and create a USB installer with *[createinstallmedia](https://support.apple.com/en-us/HT201372)* on macOS (real mac/hack or vm) or use [gibMacOS](https://github.com/corpnewt/gibMacOS)\*
+ Download [this repo](https://github.com/zearp/Nucintosh/archive/master.zip) and extract the EFI folder from the archive
+ Edit config.plist with [ProperTree](https://github.com/corpnewt/ProperTree) and change the following fields;
```
PlatformInfo -> Generic -> MLB
PlatformInfo -> Generic -> ROM
PlatformInfo -> Generic -> SystemSerialNumber
PlatformInfo -> Generic -> SystemUUID
```
Generate new serials with [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS). The ROM value is your ethernet (en0) mac address ([more info](https://dortania.github.io/OpenCore-Post-Install/universal/iservices.html#fixing-en0)).
+ Copy the EFI folder to the EFI partition on the USB installer
+ Install macOS

\* Installers made with GibMacOS on Windows (Linux too?) require a working internet connection as it uses the recovery image only, it then downloads the full installer from Apple. The *createistallmedia* script makes an off-line installer.

## Post install
- Remove express card icon: Run ```sudo mount -uw / && killall Finder && sudo mv /System/Library/CoreServices/Menu\ Extras/ExpressCard.menu /System/Library/CoreServices/Menu\ Extras/ExpressCard.menu.bak && sudo touch /System/Library/CoreServices/Menu\ Extras/ExpressCard.menu```
- Please re-enable SIP if you don't need it disabled; change ```csr-active-config``` to ```00000000``` reboot and reset nvram. I have it disabled to make testing and undervolting easier
- Check if TRIM is enabled, If not run ```sudo trimforce enable``` to enable it
- Disable ```NVMeFix.kext``` if you don't have an NVMe drive (optional)

Finally make sure sleep works properly. You can skip some of these but it will make your machine wake up from time to time. Same as real Macs.
```
sudo pmset standby 0
sudo pmset autopoweroff 0 
sudo pmset proximitywake 0
sudo pmset powernap 0 
sudo pmset tcpkeepalive 0
sudo pmset womp 0
sudo pmset hibernatemode 0
```
The first two are needed the rest can be left on. Proximity wake can wake your machine when an iDevice is near. Power Nap wil lwake up the system from time to time to check mail, make backups, etc, etc. TCP keep alive has resovled periodic wake events after setting up iCloud. Womp is wake on lan, which is disabled in the BIOS as it (going by other people's experience) might cause issues. I never use WOL so no need to have it on. If you do use WOL please try enabling it in the BIOS and leave this setting on, the issues might have been bugs that haven been solved by now. Let me know if it works or not. Hibernate is sometimes set to 3 in my testing. It could be possible to get hibernation to work by using [HibernationFixup](https://github.com/acidanthera/HibernationFixup) but I haven't tested it. I'm fine with normal sleep.

With hibernation disabled you can delete the sleepimage file and create an empty folder in its place so macOS can't create it again, this saves some space and is optional.
```
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```

That's all!

> Tip: Once everything works and you installed and configured all your stuff, create a bootable clone of your system with a trial version of *Carbon Copy Cloner* or *Superduper!*. Don't forget to copy your EFI folder to the clone's EFI partition.

## Big Sur
+ Big Sur needs its own version of Airportitlwm, download the kext [here](https://github.com/OpenIntelWireless/itlwm/releases/download/v1.1.0/AirportItlwm_v1.0_Beta_BigSur.kext.zip) and put it in the kext folder replacing the other one
+ Near the end of the install the system volume will be cryptographically sealed, this will take [some](https://dortania.github.io/OpenCore-Install-Guide/extras/big-sur/#troubleshooting) time
+ To fully disable SIP you need to change ```csr-active-config``` to ```FF0F0000``` in the config
+ Error 66 when trying to mount / in read/write mode and/or errors about diskXs5s1 when booting, this is due to apfs snapshots;

Boot into recovery and open a terminal then list the snapshots with ```diskutil apfs listSnapshots diskXs5``` and delete them with ```diskutil apfs deleteSnapshot diskXs5 -uuid UUIDHERE```.

Replace diskX with the correct disk, if you only have one disk it will be disk1s5. The UUID is the string above each snapshot.

## Apple/3rd party bluetooth and wifi
For the best bluetooth and wifi experience (HandOff, Sidecar, Airdrop, etc) consider getting a [supported](https://dortania.github.io/Wireless-Buyers-Guide/) wifi/bluetooth combo. You will need to add some kexts for these cards ([AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) + [BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM)), read the instructions on the repo's and you'll be up and running in no time. You'll also want to set your country/region to ```#a``` as it allows for full 80mhz channel width on ac cards. It might not be a 100% legal depending on where you live. I've used this method on a few DW1820A cards and the speed increase was pretty amazing. This method may also apply when using real Apple cards, you will need AirportBrcmFixup to change the region/country.

Note: If the supported wireless card is not M key you will need a converter card for it. I don't think compatible M key cards exist.

My preffered option is to grab an Apple 6+12 pin to m.2 M-key [converter card](https://dortania.github.io/Wireless-Buyers-Guide/Airport.html) and go native with something like the BCM94360CS2. Please note the number of antenna connectors. Some have more than 2, so you'll have to add some antenna's and maybe even mod your case.

Some sellers on AliExpress have converter cards that already have [the small 1.25mm pitch jst](https://github.com/zearp/Nucintosh/blob/master/Stuff/NUC8-m2adapter.jpg?raw=true) connector on it. It connects to one of the two internal usb ports. I use one without issues in my NUC. They usally list them as NUC8 compatible and cost a bit more than other converter cards.

Those other cards (and 3rd party ones) do not come with this connector so you'd have to make your own. My cheaper eBay card came with a cable with standard internal usb header and a cable without any plugs so you can attach your own. Check the listing carefully before ordering. Also make sure it converts to M key and once you have it that the spacing pillar is in the correct position. Don't short the poor Airport out.

The two internal usb ports are already mapped in the USBPorts.kext, if you made your own map you'll need to make a new map if you use the internal usb headers.

## ThunderBolt
Should work as long as ThunderBolt security is set to legacy mode. Thanks to [crp724](https://github.com/zearp/Nucintosh/issues/3) for confirming. He also confirmed eGPU works in his Mantiz TB3 enclosure. I assume that if eGPU works then all other ThunderBolt stuff works as well.

## Intel bluetooth and wifi
+ Wifi works and can be managed using native tools, speeds are still slow but connections are stable
+ Bluetooth works for HID devices such as mouse, keyboard and audio stuff but connectiosn are flaky. It may also not wake up from sleep properly

## Natively supported bluetooth dongle
I often use these cheap dongles from [eBay](https://www.ebay.co.uk/itm/1PCS-Mini-USB-Bluetooth-V4-0-3Mbps-20M-Dongle-Dual-Mode-Wireless-Adapter-Device/324106977844) that work in macOS out of the box. When going this route don't forget to disable the Intel bluetooth kexts in the config and also disable bluetooth in the BIOS when using a dongle. You will also need to map the port it connects to as internal else sleep will be dodgy. You can do this easily by setting the port type to 255 in the USBPorts.kext info.plist file. You can find the port identifier (example HS03) with Hackintool.

## Not working/untested
+ Card reader (sort of works with v2.3-beta2 of [this](https://github.com/cholonam/Sinetek-rts) kext)
+ IR receiver (it shows up in ioreg but no idea how to make macOS use it like on some MBP)
+ ~~Handoff/AirDrop are not supported (yet) on Intel chips~~ Should work now, untested by me
+ ~~4K [might need](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md#lspcon-driver-support-to-enable-displayport-to-hdmi-20-output-on-igpu) some additional parameters and a new portmap~~ 4K confirmed working. Thanks again to [crp724](https://github.com/zearp/Nucintosh/issues/3)
+ You tell me!

## Performance, power and noise
While benchmarks don't really represent real life it can be handy when testing. In my tests undervolting didn't have any impact on Geekbench results scores. But using CPUFriend can have some impact on (immediate) performance depending on which power profile you select.

* Without CPUFriend: ~915 / ~4000
* With CPUFriend: 
  - Performance: same as without
  - Balanced performance: same as without
  - Balanced power savings: ~875 / ~3800
  - Maximum power savings: ~715 / ~3300

The default kexts provided give you the best performance and still lowers the lowest clockspeed to 800mhz which lower heat and power consumption a bit. I didn't see any difference between the performance and balanced performance profiles but I only ran some quick tests. It is pretty easy to create [your own](https://dortania.github.io/OpenCore-Post-Install/universal/pm.html#using-cpu-friend) profile.

### Noise
In order to reduce noise I've setup a custom fan profile, disabled the option that the fan can be turned off and set a 25% duty cycle for both CPU and RAM. The idle temps are slightly higher but the noise is a lot less. I've also limited the sustained tdp to 28 watts to match the CPU itself. The peak tdp has been left to its default of 50 watts. With CPUFriend I've set the lowest frequency to 800mhz and a applied a mild undervolt of -50 on the CPU and CPU cache and -25 on the iGPU. A duty cycle of 21 or lower gives me a silent computer but its not ideal to run the fans lower than 25%.

> Note: No longer using a fan, passive cooling ftw!

### Passive cooling
Received my [Akasa](http://www.akasa.com.tw/search.php?seed=A-NUC45-M1B) case. To my surprise it does a better job than the stock cooler. It's not cheap and the case is not finished very smoothly (it can hurt you lol). I have mine verically and didn't use any of the end cheeks, only the feet. It would just introduce more options to hurt myself ;-)

It works really well. So good I have set the power setting in the BIOS to max performance. It idles around 40-45c which is just fine considering my ambient temperature is around 25c. When put under load it doesn't get anywhere near 80c. I've ran the matrix test from ```stress-ng``` for a while and it stayed [stable around 70c](https://github.com/zearp/Nucintosh/blob/master/Stuff/passive_cooling.png) the whole test. With some of the other tests it ran hotter and also used more power, 35 watts sustained. A quick [5 minutes Intel XTU](https://github.com/zearp/Nucintosh/blob/master/Stuff/passive_intel_xtu_5m.png) stress test show similar results. Settling around 75c. Even with increased wattage it never needed to thermal throttle which is great!

My only complaint is the rough finish. I wish they would've skipped on those cheeks and spend the money saved on a smooth finish, but thats besides the point of this thing. The silence is worth the occasional scratch.

## Credits
+ https://github.com/acidanthera
+ https://github.com/OpenIntelWireless
+ https://dortania.github.io/OpenCore-Install-Guide/config.plist/coffee-lake.html
+ https://github.com/Rashed97/Intel-NUC-DSDT-Patch/commit/47476815b52f8e4c97e8f85df158c9ab1b6ecedd
+ https://github.com/csrutil/NUC8I5BEH
+ https://github.com/honglov3/NUC8I7BEH
+ https://github.com/sarkrui/NUC8i7BEH-Hackintosh-Build
