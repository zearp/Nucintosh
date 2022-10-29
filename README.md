# NUC8IxBEx Hackintosh
This is a quick and dirty repo for Intel NUC 8th gen Coffee Lake models. I've used various sources (see credits) to build my EFI and did quite some testing. It should leave you with a stable and reliable build but as always, these things are never really finished. Compatible with macOS Mojave, Catalina, Big Sur and Monterey.

## Please note that from the 29th of October 2022 the assumed installion target will be Ventura.
The EFI should work fine for earlier versions too but will require different kexts for the Intel wireless card. Replace AirportItlwm.kext with one matching your macOS version from the [stuff](https://github.com/zearp/Nucintosh/tree/master/Stuff) folder. Use the snapshot function in ProperTree to easily update the config once you made the kext swaps. If you encounter bluetooth issues on versions prior to Monterey you may also have to replace BlueToolFixup.kext with IntelBluetoothInjector.kext -- the kexts can be found in the "stuff" folder on the repo. Good luck!

![macOS Monterey](https://github.com/zearp/Nucintosh/blob/master/Stuff/Monterey.png?raw=true)

## Details
* Works with macOS *Catalina*, *Big Sur* and *Monterey*
* OpenCore bootloader with the following kexts:
  - Lilu
  - VirtualSMC
  - WhateverGreen
  - AppleALC
  - IntelMausi
  - NVMeFix
  - CPUFriend
  - BlueToolFixup -- fixes bluetooth in Big Sur and beyond 
  - OpenIntelWireless kexts for Intel bluetooth and wifi
  - RealtekCardReader
  
## Index
* [Installation](#installation)
* [Post install](#post-install)
* [Updating](#updating)
* [Thunderbolt](#Thunderbolt)
* [Apple and 3rd party wifi/bt](#apple3rd-party-bluetooth-and-wifi)
* [Intel wifi/bt](#intel-bluetooth-and-wifi)
* [Native bt dongle](#natively-supported-bluetooth-dongle)
* [What doesn't work?](#not-workinguntested)
* [Undervolting](#undervolting)
* [Performance, power and noise](#performance-power-and-noise)
  - [Noise](#noise)
  - [Passive cooling](#passive-cooling)
* [Todo](#todo)
* [Credits](#credits)
  
## Installation
+ Update to the latest ([0090](https://www.intel.com/content/www/us/en/download/743906/bios-update-becfl357.html)) BIOS -> load BIOS defaults -> click advanced and change;
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
+ When not installing Monterey download the AirportItlwm.kext file matching your macOS install from the ```Stuff``` folder and replace the one in the kext folder with it. Not doing this may cause a bootloop.
+ Edit config.plist with [ProperTree](https://github.com/corpnewt/ProperTree) and change the following fields;
```
PlatformInfo -> Generic -> MLB
PlatformInfo -> Generic -> ROM
PlatformInfo -> Generic -> SystemSerialNumber
PlatformInfo -> Generic -> SystemUUID
```
Generate new serials with [GenSMBIOS](https://github.com/corpnewt/GenSMBIOS). The ROM value is your ethernet (en0) mac address ([more info](https://dortania.github.io/OpenCore-Post-Install/universal/iservices.html#fixing-en0)).
+ Copy the EFI folder to the EFI partition on the USB installer
+ Clear NVRAM from the OpenCore picker
+ Install macOS

\* Installers made with GibMacOS on Windows and Linux require a working internet connection as it uses the recovery image only, it then downloads the full installer from Apple. The *createinstallmedia* script makes an offline installer.

> Note: OpenCore doesn't always select the correct partition in the menu when installing. You will only boot into the installer once, do your formatting and have the installer copy all it needs to the internal disk. From that point onwards always select the internal disk from the menu. The name might change during the installation, but it shouyld be easy to spot as it won't have an "external" label.

## Post install
- Check if TRIM is enabled, If not run ```sudo trimforce enable``` to enable it
- Disable ```NVMeFix.kext``` if you don't have an NVMe drive
- Don't forget to copy the EFI folder from the installer's EFI partition to the internal disk's EFI partition. This is needed to boot from the internal disk. You can use [EFI Agent](https://github.com/headkaze/EFI-Agent) to easily mount EFI partition.

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
The first two and last need to be ```0``` the rest can be left on if you want.

- Proximity wake can wake your machine when an iDevice is near
- Power Nap will wake up the system from time to time to check mail, make Time Machine backups, etc, etc
- Disabling TCP keep alive has resolved periodic wake events after setting up iCloud, just disabling Find My wasn't enough.
- Womp is wake on lan, which is disabled in the BIOS as it (going by other people's experience) might cause issues. I never use WOL, if you do use WOL please try enabling it in the BIOS and leave this setting on, the issues might have been due to bugs that haven been solved by now. Let me know if it works or not.
- Hibernate is sometimes set to 3 in my testing. It could be possible to get hibernation to work by using [HibernationFixup](https://github.com/acidanthera/HibernationFixup) but I haven't tested it. I'm fine with normal sleep.

With hibernation disabled you can delete the sleepimage file and create an empty folder in its place so macOS can't create it again, this saves some space and is optional.
```
sudo rm /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```
 
At this point you should enable FileVault to encrypt your disk. The config is setup to support this and it works flawlessly.

To get a nicer boot experience you can remove the verbose boot flag ```-v```in the config and also set ```ShowPicker``` to false. This will show the Apple logo and not show any OpenCore menu or verbose booting. To get the OpenCore picker/menu to show hold down the *alt* key when booting.

That's all!

> Tip: Once everything works and you installed and configured all your stuff, create a bootable clone of your system with a trial version of *Carbon Copy Cloner* or *Superduper!*. Don't forget to copy your EFI folder to the clone's EFI partition. First time? Follow my little guide [here](https://github.com/zearp/OptiHack/blob/master/text/CLONE_IT.md).

## Updating
Updating is easy, first copy the MLB/ROM/SystemSerialNumber/SystemUUID values from your current config to a text file then delete the whole EFI folder and replace it with the latest release/clone from this repo. Copy your PlatformInfo fields from the text file into the new config. Unless you made other changes this is all thats needed.

## Thunderbolt
Should work as long as Thunderbolt security is set to legacy mode. Thanks to [crp724](https://github.com/zearp/Nucintosh/issues/3) for confirming. He also confirmed eGPU works in his Mantiz TB3 enclosure. I assume that if eGPU works then all other Thunderbolt stuff works as well. Thunderbolt devices need to be connected before starting up. Hotplug will not work. In order for Thunderbolt hotplugging to work you will need to [modify the firmware](https://github.com/zearp/Nucintosh/tree/tb3).

## Apple/3rd party bluetooth and wifi
For both 1st and 3rd party you will need a [supported](https://dortania.github.io/Wireless-Buyers-Guide/) wifi/bluetooth combo card and an adapter (see below) to convert it to M key. As far as I know compatible M key combo cards don't exist. 

3rd party cards will need these kexts: [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) + [BrcmPatchRAM](https://github.com/acidanthera/BrcmPatchRAM), read the instructions on the repo's and you'll be up and running in no time. I've tested the very affordable DW1820A in many machines including the NUC and it works great. For some cards you may need to create an entry under devices in the config that disables ASPM, this only needed if you have issues with sleep.

1st party is my preferred option. Grab an Apple 6+12 pin to m.2 M-key [converter card](https://dortania.github.io/Wireless-Buyers-Guide/Airport.html) and go native with something like the BCM94360CS2. Please note the number of antenna connectors. Some have more than 2, so you'll have to add some antenna's and maybe even mod your case. Though there is some room under the plastic lid, it can fit internal antennas like [this](https://ae01.alicdn.com/kf/HTB1AAiAKVXXXXc4aXXXq6xXFXXX4/2pcs-Internal-Antennas-40cm-15-7-inches-IPEX-MHF4-2-4-5G-wifi-antennas-for-BCM94352Z.jpg). The lid can be removed with some strategic force and there's a hole to route the wires trough too. I would use those and leave the standard antenna's connected to the Intel module. They're very cheap and the antenna connectors on the Intel module are very fragile.

One big plus of going native is that you gain HID-proxy. This means that when there is no OS running the Airport card will proxy any paired HID bluetooth devices to the machine as usb devices. This means you can enter the BIOS or boot menu using the bluetooth keyboard and mouse. This is not a feature you will find on many other cards, including the the one Intel put in here. Even expensive bluetooth cards often can not do this. But Apple has added it even in the cheap BCM943224PCIEBT2 Airport card.


Speaking of the $10 BCM943224PCIEBT2, I've personally tested that card and it still works fine in Catalina by setting ```Kernel -> Patch -> 0``` to true. Big Sur will need the patch disabled and [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) added with boot flags ```brcmfx-driver=2 brcmfx-country=#a``` instead. For Monterey you will need to patch the installer which will disable SIP and isn't recommended. You can also add your card as a device in the configs DeviceProperties section and set the options there, for example;
```
<key>PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x0)</key>
 	<dict>
 		<key>AAPL,slot-name</key>
 		<string>Internal@0,28,4/0,0</string>
		<key>device_type</key>
 		<string>Network controller</string>
 		<key>model</key>
 		<string>Apple Airport BCM43224 802.11a/b/g/n</string>
 		<key>brcmfx-country</key>
 		<string>#a</string>
 		<key>brcmfx-driver</key>
 		<string>2</string>
 	</dict>
```

Make sure you check if the PciRoot/slot-name paths are correct, you can find them in IOreg or Hackintool. Also make sure the AirPortBrcm4360_Injector.kext plug-in that will be added if you use the ProperTree snapshot command is disabled. It is part of AirportBrcmFixup but can cause Monterey boot-up to stall and wifi not working properly (shows as disabled).

Some sellers on AliExpress have converter cards that already have [the small 1.25mm pitch jst](https://github.com/zearp/Nucintosh/blob/master/Stuff/NUC8-m2adapter.jpg?raw=true) connector on it. It connects to one of the two internal usb ports. I use one without issues in my NUC. They usually list them as NUC8 compatible and cost a bit more than other converter cards.

Those other cards (and 3rd party ones) do not come with this connector so you'd have to make your own. My cheaper eBay card came with a cable with standard internal usb header and a cable without any plugs so you can attach your own. Check the listing carefully before ordering. Also make sure it converts to M key and once you have it that the spacing pillar is in the correct position. Don't short the poor Airport out.

- The two internal usb ports are already mapped in the USBPorts.kext, if you made your own map you'll need to make a new map if you use the internal usb headers
- When using a 1st or 3rd party combo card you need to disable both bluetooth and wifi in the BIOS and also remove any Intel related bluetooth and wifi kexts
- You will also need to remove the config block for HS07 used by the onboard Intel wifi/bt card (this was HS10 in previous usb portmaps) from [Info.plist](https://github.com/zearp/Nucintosh/blob/02c221031bbe3845871f2016de25a7a6c6f33e86/EFI/OC/Kexts/USBPorts.kext/Contents/Info.plist#L130-L136) inside USBPorts.kext, without this step bluetooth won't work (properly) after sleep. On 1st party cards it gets "stuck" in HID-proxy mode; bluetooth mouse and keyboard may still work but not optimally and laggy.

You'll also want to set your region to ```#a``` as it allows for full 80mhz channel width on ac cards. It might not be 100% legal depending on where you live. I've used this method on a few DW1820A cards and the speed increase was pretty amazing. This method may also apply when using real Apple cards, you will need add [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) on 1st party cards. To change the region simply add the following boot flag ```brcmfx-country=#a```. Make sure your router also supports 80mhz channel width and before doing anything hold down alt while clicking the wifi icon to check the current channel width.

One last thing to remember is that waking the machine from sleep using bluetooth devices will not work. This is due to power being cut to the module. The module does start itself up very fast. By the time my screen wakes up my bluetooth devices are already reconnected. There is way to bypass this but it includes either modding your adapter card or [making your own](https://github.com/BbIKTOP/M.2-key-M-to-wifi). I've asked some sellers on AliExpress to produce this card but didn't have any luck. If you can make it or know a seller who's willing to make it please let me know.

## Intel bluetooth and wifi
+ Wifi works and can be managed using native tools, speeds are still slow but connections are stable
+ Bluetooth works for HID devices such as mouse, keyboard and audio stuff but connections are flaky. It may also not wake up from sleep properly

## Natively supported bluetooth dongle
I often use these cheap dongles from [eBay](https://www.ebay.co.uk/itm/1PCS-Mini-USB-Bluetooth-V4-0-3Mbps-20M-Dongle-Dual-Mode-Wireless-Adapter-Device/324106977844) that work in macOS out of the box. When going this route don't forget to disable the Intel bluetooth kexts in the config and also disable bluetooth in the BIOS when using a dongle. You will also need to map the port it connects to as internal else sleep will be dodgy. You can do this easily by setting the port type to 255 in the USBPorts.kext info.plist file. You can find the port identifier (example HS03) with Hackintool. Because power isn't cut when entering sleep you can wake the machine up with bluetooth devices.

## Not working/untested
+ IR receiver (it shows up in ioreg but no idea how to make macOS use it like on some MBP)
+ Some, not all [continuity](https://www.apple.com/macos/continuity/) features work with the onboard Intel wifi/bt combo. Use an Apple Airport card to get all features working. 
+ ~~4K [might need](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md#lspcon-driver-support-to-enable-displayport-to-hdmi-20-output-on-igpu) some additional parameters and a new portmap~~ 4K confirmed working. Thanks again to [crp724](https://github.com/zearp/Nucintosh/issues/3)
+ If you can't see your NVMe drive or have issues with it, disabling NVMeFix.kext in the config may help ([1](https://dortania.github.io/Anti-Hackintosh-Buyers-Guide/Storage.html),[2](https://github.com/acidanthera/nvmefix))
+ You tell me!

## Undervolting
Undervolting is a great way to to maximise performance, lower power consumption and reduce temperatures. The amount of undervolting you can apply depends on your luck in the [silicon lottery](https://en.wikipedia.org/wiki/Product_binning#Overclocking_and_core_unlocking). You'll have to lower the voltage step by step and test stability with [stress-ng](https://wiki.ubuntu.com/Kernel/Reference/stress-ng), [Prime95](https://www.mersenne.org/download/) or other tools like it.

Please read [this](https://github.com/sicreative/VoltageShift/blob/master/README.md) page for an explanation of all the options and what they do, I'm only focusing on the basics here. Also heed the warning displayed but realise this warning doesn't really apply when undervolting, but this tool can also do overvolting which could indeed be dangerous. The worst thing that can happen when undervolting is data loss due to system freeze. So only do this after [making a backup](https://github.com/zearp/OptiHack/blob/master/text/CLONE_IT.md).

Installation is easy, I've compiled a version that will load from EFI so there's no need to disable SIP or allow loading of unsigned kexts. Simply download [this](https://github.com/zearp/VoltageShift/raw/master/VoltageShift-EFI.zip) and place the kext file inside the kext folder of OpenCore in your EFI and place the ```voltageshift``` binary file in your home directory or somewhere else where it is not in your way. Don't forget to add to the kext to your config file too. Using ProperTree's snapshot function makes it easy to do this quickly. Once this is done reboot and verify the kext is loaded by running ```kextstat | grep VoltageShift``` in a terminal.

Once you confirmed the kext is loaded you can start undervolting. In the terminal go to the folder where you placed the ```voltageshift``` binary and run the following command ```./voltageshift info``` if all is well it will return the current configuration, in my case;

```
zearp@nuc ~ % ./voltageshift info
------------------------------------------------------
   VoltageShift Info Tool
------------------------------------------------------
CPU voltage offset: 0mv
GPU voltage offset: 0mv
CPU Cache voltage offset: 0mv
System Agency offset: 0mv
Analogy I/O: 0mv
OC mailbox cmd failed
Digital I/O: 0mv
CPU BaseFreq: 2300, CPU MaxFreq(1/2/4): 3800/3800/3600 (mhz)  PL1: 35W PL2: 65W 
CPU Freq: 0.8ghz, Voltage: 0.6144v, Power:pkg 3.53w /core 0.80w,Temp: 94 c
```

Take note of your PL1 and PL2 numbers. Close all open apps and start out with only applying some light undervolting to CPU and CPU Cache by running ```./voltageshift offset -25 0 -25``` and you'll see a message like this;

```
zearp@nuc ~ % ./voltageshift offset -25 0 -25                                       
--------------------------------------------------------------------------
VoltageShift offset Tool
--------------------------------------------------------------------------
Before CPU voltageoffset: 0mv
Before GPU voltageoffset: 0mv
Before CPU Cache: 0mv
--------------------------------------------------------------------------
After CPU voltageoffset: -25mv
After GPU voltageoffset: 0mv
After CPU Cache: -25mv
--------------------------------------------------------------------------
```

Now run a stress test for 5-10 minutes and if it doesn't freeze you can try to go lower. Repeat this until the system freezes and then use the last voltage that didn't cause a freeze. In my testing I've found that applying an undervolt of -75 to -125 on the CPU/CPU Cache works fine, but it will differ on every system. If you don't want to spend time finding the perfect numbers you can apply -50 for both, it should be stable and still help a bit. Once you found the perfect offset you can have this apply at boot by running; ```sudo ./voltageshift buildlaunchd -75 0 -75 0 0 0 1 35 65 0 120```.

Please note that the util will exit with an error, this is normal as we modified it to run from EFI. It will execute some commands that fail which causes it to display an error. To verify the launch deamon has been created you can check if it exits:
```
zearp@nuc ~ % file /Library/LaunchDaemons/com.sicreative.VoltageShift.plist
/Library/LaunchDaemons/com.sicreative.VoltageShift.plist: XML document text, ASCII text, with very long lines
```

You will need to change -75/-75 to your magic numbers and change 35/65 to whatever PL1/PL2 values were when running the info command. PL1/PL2 values change depending on BIOS settings. I've changed mine in the BIOS to 35/65 since my cooling solution is better than stock. Lowering it below 28watts may decrease temps but also performance. The tdp of the i5 is 28 watts according to Intel and I think the stock values are 30/50. This setting regulates the amount of power the NUC is allowed to consume when running normally and in turbo mode. Change 120 to whatever interval you wish to have the script check if undervoltage has been applied. Sleep can reset the settings, with it set to 120 minutes you'll be without an undervolt after waking from sleep for a max of 2 hours. Change to your liking or set to 0 to disable. Refer to the [documentation](https://github.com/sicreative/VoltageShift/blob/master/README.md) for an explanation about every single option. For example the ```1``` is to keep turbo enabled. A zero means the offset isn't changed.

If you want your stock cooled NUC to be more silent with a little performance penalty you can disable turbo and set PL1/PL2 both to 28 watts. This will result in a much cooler and quieter machine but with some performance loss. With these setting and a custom fan curve you can get your NUC to be silent pretty much all the time unless you really push it. It can pay off to play around with these to find the perfect balance between noise and performance.

There are a lot more things you can do but as a start just undervolting CPU/CPU Cache is enough. In my testing undervolting GPU didn't make any difference but maybe on yours it does help. Experiment and see what works best for you.

> Tip: Use Intel Power Gadet and/or HWMonitor to check current voltages and temperatures.

## Performance, power and noise
While benchmarks don't really represent real life it can be handy when testing. In my tests undervolting didn't have any impact on Geekbench results scores. But using CPUFriend can have some impact on (immediate) performance depending on which power profile you select.

* Without CPUFriend: ~915 / ~4000
* With CPUFriend: 
  - Performance: same as without
  - Balanced performance: same as without
  - Balanced power savings: ~875 / ~3800
  - Maximum power savings: ~715 / ~3300

The default kexts provided give you the best performance and still lowers the lowest clock speed to 800mhz. Which lowers heat and power consumption a bit. I didn't notice any difference between the performance and balanced performance profiles but I only ran some quick tests. It is pretty easy to create [your own](https://dortania.github.io/OpenCore-Post-Install/universal/pm.html#using-cpu-friend) profile or disable both CPUFriend kexts in the config.

### Noise
In order to reduce noise I've setup a custom fan profile, disabled the option that the fan can be turned off and set a 25% duty cycle for both CPU and RAM. The idle temps are slightly higher but the noise is a lot less. I've also limited the sustained tdp to 28 watts to match the CPU itself. The peak tdp has been left to its default of 50 watts. With CPUFriend I've set the lowest frequency to 800mhz and a applied a mild undervolt of -50 on the CPU and CPU cache and -25 on the iGPU. A duty cycle of 21 or lower gives me a silent computer but its not ideal to run the fans lower than 25%.

> Note: No longer using a fan, passive cooling ftw!

### Passive cooling
Received my [Akasa](http://www.akasa.com.tw/search.php?seed=A-NUC45-M1B) case. To my surprise it does a better job than the stock cooler. It's not cheap and the case is not finished very smoothly (it can hurt you lol). I have mine vertically and didn't use any of the end cheeks, only the feet. It would just introduce more options to hurt myself ;-)

It works really well. So good I have set the power setting in the BIOS to max performance. It idles around 35-40c (with undervolt) which is just fine considering my ambient temperature is around 25c. When put under load it doesn't get anywhere near 80c. I've ran the matrix test from ```stress-ng``` for a while and it stayed [stable around 70c](https://github.com/zearp/Nucintosh/blob/master/Stuff/passive_cooling.png) the whole test.

My only complaint is the rough finish. I wish they would've skipped on those cheeks and spend the money saved on a smooth finish, but thats besides the point of this thing. The silence is worth the occasional scratch.

## Todo
+ Where possible further optimisations and ThunderBolt hot-plug support

## Credits
+ https://github.com/acidanthera
+ https://github.com/OpenIntelWireless
+ https://dortania.github.io/OpenCore-Install-Guide/config.plist/coffee-lake.html
+ https://github.com/osy
+ Many [random](https://github.com/Rashed97/Intel-NUC-DSDT-Patch/commit/47476815b52f8e4c97e8f85df158c9ab1b6ecedd) repos [with](https://github.com/honglov3/NUC8I7BEH) information [and](https://github.com/sarkrui/NUC8i7BEH-Hackintosh-Build) research [that](https://github.com/mbarbierato/Intel-NUC8i3BEH) I've [forgotten](https://github.com/honglov3/NUC8I7BEH) about.
