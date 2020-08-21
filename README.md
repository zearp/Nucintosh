# NUC8IxBEx Hackintosh

This is a quick and dirty repo for Intel NUC 8th gen computers. It should work on all the Coffee Lake ones. I've used various sources to get to this point and did quite some testing. It should leave you with a stable and reliable build but as always, these things are never really finished. While it should work on older macOS versions, I've done all building and testing on Catalina.

### Details
* Supported macOS: *Catalina 10.15.x*
* OpenCore bootloader with the following kexts:
  - Lilu
  - VirtualSMC
  - WhateverGreen
  - AppleALC
  - IntelMausi
  - NVMeFix
  - CPUFriend
  - itlwm + Black80211-Catalina
  - FakePCIID (without this audio over hdmi only works when re-plugging the cable)
  - IntelBluetoothFirmware (unstable, see Intel section below)
  
### How to install

+ Update to latest BIOS, load BIOS defaults, click advanced and change;
```
Devices -> USB -> Port Device Charging Mode: off
Security -> VT-d: Disable
Security -> Thunderbolt Security Level: Legacy Mode
Power -> Wake on LAN from S4/S5: Stay Off
Boot -> Boot Priority -> UEFI + legacy: Enable
Boot -> Boot Configuration -> Network Boot: Disable
Boot -> Secure Boot -> Disable
```
+ Download macOS Catalina in the [App Store](https://apps.apple.com/us/app/macos-catalina/id1466841314) and create a USB installer with *[createinstallmedia](https://support.apple.com/en-us/HT201372)* on macOS (real mac/hack or vm) or use [gibMacOS](https://github.com/corpnewt/gibMacOS)\*
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

\* Installers made with GibMacOS require a working internet connection. It downloads the full installer from Apple. The *createistallmedia* script makes an off-line installer.

### Intel Bluetooth and wifi
+ Bluetooth works for HID devices such as mouse, keyboard and audio stuff.
  - Bluetooth may not always wake up after sleep in order to fix that you can grab a cheap dongle from [eBay](https://www.ebay.co.uk/itm/1PCS-Mini-USB-Bluetooth-V4-0-3Mbps-20M-Dongle-Dual-Mode-Wireless-Adapter-Device/324106977844) that works in macOS out of the box ~~and/or wait for the bugs te fixed~~. Mind you, both these routes will only support HID devices. Don't forget to disable the Intel Bluetooth kexts in the config and bluetooth in the BIOS.
+ Wireless is now integrated with native macOS wireless management thanks to Black80211 and itlwm by [usr-sse2](https://github.com/usr-sse2).
  - Currently both 2.4 and 5ghz bands are scanned properly but sometimes it fails to auto-connect. Turning wifi off and on again works for the time being. Speeds are not yet n/ac/ax but for normal usage it is fine. I'm getting around 70-80mbit locally.
 
> Please note that bluetooth and wifi integration is very recent and active development. So it may not work optimally yet. If you experience issues please replace ```itlwm.kext``` with the one found [here](https://github.com/zearp/Nucintosh/raw/master/Stuff/itlwm.kext.zip) **and** set the loading of ```Black80211.kext``` to *false* in the config. Then use [HeliPort](https://github.com/OpenIntelWireless/HeliPort/releases) to connect to a wireless network instead.

Getting wifi and bluetooth to work on Intel is quite special as many said it would be impossible. Yet here we are, both are working and both appear native to macOS. Amazing effort by those involved! The remaining bugs are being squashed right now and improvements are made nearly daily.

Consider getting a [supported](https://dortania.github.io/Wireless-Buyers-Guide/) wifi/bluetooth combo.

## Post install
- Remove express card icon: Run ```sudo mount -uw / && killall Finder && sudo mv /System/Library/CoreServices/Menu\ Extras/ExpressCard.menu /System/Library/CoreServices/Menu\ Extras/ExpressCard.menu.bak && sudo touch /System/Library/CoreServices/Menu\ Extras/ExpressCard.menu```
- Please re-enable SIP if you don't need it disabled; change ```csr-active-config``` to ```00000000``` reboot and reset nvram. I have it disabled to make testing and undervolting easier
- Check power management options with ```pmset -g``` and tweak to your liking
- Check if TRIM is enabled, If not run ```sudo trimforce enable``` to enable it
- Disable ```NVMeFix.kext``` if you don't have an NVMe drive

> Tip: Once everything works and you installed and configured all your stuff, create a bootable clone of your system with a trial version of *Carbon Copy Cloner* or *Superduper!*. Don't forget to copy your EFI folder to the clone's EFI partition.

### Not working/untested
+ Thunderbolt (untested, usb-c works and TB should work...)
+ Card reader
+ Handoff/AirDrop are not supported (yet) on Intel chips
+ 4K [might need](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md#lspcon-driver-support-to-enable-displayport-to-hdmi-20-output-on-igpu) some additional parameters and port mapping

## Sleep
After setting up iCloud I noticed some kind of scheduled wake-ups, running ```sudo pmset -a tcpkeepalive 0``` seems to have solved it. 

## Noise
In order to reduce noise I've setup a custom fan profile, disabled the option that the fan can be turned off and set a 25% duty cycle for both CPU and RAM. The idle temps are slightly higher but the noise is a lot less. I've also limited the sustained tdp to 28 watts to match the CPU itself. The peak tdp has been left to its default of 50 watts. With CPUFriend I've set the lowest frequency to 800mhz and a applied a mild undervolt of -50 on the CPU and CPU cache and -25 on the iGPU. A duty cycle of 21 or lower gives me a silent computer but its not ideal to run the fans lower than 25%.

## Performance and power
While benchmarks don't really represent real life it can be handy when testing. In my tests undervolting didn't have any impact on Geekbench results scores. But using CPUFriend can have some impact on (immediate) performance depending on which power profile you select.

* Without CPUFriend: ~915 / ~4000
* With CPUFriend: 
  - Performance: same as without
  - Balanced performance: same as without
  - Balanced power savings: ~875 / ~3800
  - Maximum power savings: ~715 / ~3300

The default kexts provided give you the best performance and still lowers the lowest clockspeed to 800mhz which lower heat and power consumption a bit. I didn't see any difference between the performance and balanced performance profiles but I only ran some quick tests. It is pretty easy to create [your own](https://dortania.github.io/OpenCore-Post-Install/universal/pm.html#using-cpu-friend) profile.

Maybe the power savings options are useful for passive cooling. I will test that once I receive my [Akasa](http://www.akasa.com.tw/search.php?seed=A-NUC45-M1B) case. I think it will be fine as is but every little bit helps and might help reduce thermal throttling.

It would be interesting to see how it scores with the fan forced to max rmp, the power limits maxed out and the power savings setting set to performance. Also interesting would be MacBook SMBIOS, it could help or worsen scores/pm/etc. The NUC is a mobile platform and some MacBooks have the exact same CPU but I haven't tested those yet.

### Credits
+ https://github.com/acidanthera
+ https://github.com/usr-sse2
+ https://dortania.github.io/OpenCore-Install-Guide/config.plist/coffee-lake.html
+ https://github.com/Rashed97/Intel-NUC-DSDT-Patch/commit/47476815b52f8e4c97e8f85df158c9ab1b6ecedd
+ https://github.com/csrutil/NUC8I5BEH
+ https://github.com/honglov3/NUC8I7BEH
+ https://github.com/sarkrui/NUC8i7BEH-Hackintosh-Build
+ https://github.com/OpenIntelWireless/IntelBluetoothFirmware
