PSA: Although I did a lot of testing I still consider patching the firmware as experimental. Thunderbolt should be stable and work fine but YMMV. 

Note that flashing the firmware will currently break the following:
- Wake from sleep results in panic, this is most likely be due the interface not turning on fast enough and will require some kext and/or ACPI patches
- Any usb devices connected to the Thunderbolt port will only work if they were present when booting up the machine, needs usb and/or ACPI fixes

I haven't been able to find fixes for them yet. Feel free to share fixes if you can, it may not be hard to fix for anyone knowledgable with ACPI.

Make sure you're running the latest relase or a very recent clone of the repo.

## Thunderbolt 3 hotplug patching

Open up a terminal and run the following commands:
```
zearp@nuc ~ % curl -OLs https://github.com/osy/ThunderboltPatcher/releases/download/v1.0/tbpatch-CLI-v1.0.zip
zearp@nuc ~ % unzip tbpatch-CLI-v1.0.zip 
Archive:  tbpatch-CLI-v1.0.zip
  inflating: tbpatch
```

```
zearp@nuc ~ % sudo ./tbpatch list
Invalid address: 1
Device /AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/RP05@1C,4/IOPP/UPSB@0/IOPP/DSB0@0/IOPP/NHI0@0/AppleThunderboltHAL/AppleThunderboltNHIType3/IOThunderboltController/IOThunderboltPort@5/IOThunderboltSwitchType3/IOThunderboltIECSNub/AppleHPMIECS/AppleHPMDevice@1 not added because failed to init.
Device /AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/RP05@1C,4/IOPP/UPSB@0/IOPP/DSB0@0/IOPP/NHI0@0/AppleThunderboltHAL/AppleThunderboltNHIType3/IOThunderboltController/IOThunderboltPort@5/IOThunderboltSwitchType3/IOThunderboltIECSNub/AppleHPMIECS/AppleHPMUserClient not added because of missing Address.
/AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/RP05@1C,4/IOPP/UPSB@0/IOPP/DSB0@0/IOPP/NHI0@0/AppleThunderboltHAL/AppleThunderboltNHIType3/IOThunderboltController/IOThunderboltPort@5/IOThunderboltSwitchType3/IOThunderboltIECSNub/AppleHPMIECS/AppleHPMDevice@0
  Address : 0x00000000
  PID     : 0x8838454341
  UID     : A13B3414-C4B4-AF98-FC4F-FA6E55023780
  Version : 
  Build   : c21bda84555465022d578161e3aecb523fe75643_12082017
  Device  : TPS65982 HW0011 FW0001.12.07 ZTBT1
```

```
zearp@nuc ~ % sudo ./tbpatch dump -s 0x100000 -f backup.bin
Invalid address: 1
Device /AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/RP05@1C,4/IOPP/UPSB@0/IOPP/DSB0@0/IOPP/NHI0@0/AppleThunderboltHAL/AppleThunderboltNHIType3/IOThunderboltController/IOThunderboltPort@5/IOThunderboltSwitchType3/IOThunderboltIECSNub/AppleHPMIECS/AppleHPMDevice@1 not added because failed to init.
Reading 0x00000000
...
Reading 0x000FFFF0
```

These commands will download the patcher, unpack it, run it to check if the device is detected and then make a backup of the firmware. It will take 10-15 minutes for the backup to be made.

Make sure to babysit this and use the machine to do some web browsing while you wait. I left mine alone and when I got back the machine was sleeping and I had to start over, including a reboot as the tThunderbolt interface failed to init after waking up from sleep. Copy the backup.bin somewhere like a usb stick. Not all fields (PID/UUID/etc) will match up with yours, this is expected.

Now that the backup has been made and stored somewhere secure we can modify the firmware, this is done at your own risk and if it goes wrong you may need a flash programmer to restore the backup directly to the chip. I've tested this quite a bit and didn't run into any issues myself.

To modify the firmware run the following commands:
```
zearp@nuc ~ % curl -OLs https://github.com/zearp/Nucintosh/raw/master/Stuff/nuc8_tb_patch.plist.zip
zearp@nuc ~ % unzip nuc8_tb_patch.plist.zip 
Archive:  nuc8_tb_patch.plist.zip
  inflating: nuc8_tb_patch.plist
```

```
zearp@nuc ~ % sudo ./tbpatch patch -f nuc8_tb_patch.plist
Invalid address: 1
Device /AppleACPIPlatformExpert/PCI0@0/AppleACPIPCI/RP05@1C,4/IOPP/UPSB@0/IOPP/DSB0@0/IOPP/NHI0@0/AppleThunderboltHAL/AppleThunderboltNHIType3/IOThunderboltController/IOThunderboltPort@5/IOThunderboltSwitchType3/IOThunderboltIECSNub/AppleHPMIECS/AppleHPMDevice@1 not added because failed to init.
These patches are only designed for NUC8i7HNK/NUC8i7HVK! It has been tested with v33 firmware.

Please note after patching your Thunderbolt NVM, Windows will no longer work with Thunderbolt! You must uninstall these patches if you wish to use Thunderbolt with Windows. Updating the firmware uninstalls the patches. You can also use this tool again.

If you update/reinstall your Thunderbolt firmware, you must reapply the patches.

Lastly, remember this tool and patch-set are provided AS-IS WITHOUT ANY WARRENTY. If used improperly, with the wrong patches, with bad patches, or due to a bug in the software, your TB controller can be bricked and would require recovery with an external SPI flasher.

Looking for the start address.
Reading 0x00000000
base not found at offset 0x0, trying 0x1000
Reading 0x00001000
Found base: 0x00004000
Getting original data for each page and performing verification.
Getting data for page: 0x00004000
Reading 0x00004000
...
Reading 0x00004FF0
Data matches patch set for original:1 replacement:0
Writing patched pages
Writing page: 0x00004000 with 11 patches
Erasing 0x00004000 for 0x00001000 bytes
Writing 0x00004000
...
Writing 0x00004FF0
Reading back page: 0x00004000
Reading 0x00004000
...
Reading 0x00004FF0
Done!
You must perform a hard power reset for the changes to take place. Note that it is recommended you use custom ACPI tables for maximum stability. For some Windows support, you must use a custom ACPI table. Full Windows support is not possible at this time (no TB hotplug).

Shut down your computer, and then unplug the device. After a few seconds, plug it back in and power it up again.
```

Now mount your EFI partition and open up the config file. In the first section near the bottom of the ACPI list you will see ```SSDT-TbtOnPCH-POST.aml``` (7) and ```SSDT-TbtOnPCH-PREP.aml``` (8) entries. We need to set entry 7 to ```true``` and entry 8 to ```false```.
Once this is done turn off the machine and disconnect the power cable and wait about 10-15 seconds before plugging it back in and booting back into macOS.

Back in macOS open up ```System Information``` and click on the Thunderbolt section. If all went well you should now see 1 Apple controller with a 40gb/s port. If you do you're done and have patched the firmware properly. If you don't see the Apple entry but instead see 2 Thunderbolt controllers from ASUS double check you've disabled and enabled the ACPI patches. If you see nothing you may have turned on the machine too soon. It took me a few tries to get this right cuz I'm impatient.

> Caveat: Modifying the firmware breaks hotplug in Windows. This might be fixed by (force) installing Apple's own drivers. Those can be found inside Boot Camp driver packages. I'm not sure which Apple machine has the same Thunderbolt interface though. Needs more investigation.

## Reversing the patch
Reversing the patch is very easy, open a Terminal in the location you put the patcher and run ```sudo ./tbpatch restore -f nuc8_tb_patch.plist```, wait till its done and before you shutdown reverse the ACPI patches in the config file. Set 7 to ```false``` and 8 to ```true```. Shutdown like before and after rebooting you should now have the two ASUS controllers showing up in the Thunderbolt section. Thunderbolt will still work, but hotplugging won't.

## Recovering from failed flash
Very unlikely to happen but if it does you need a flash programmer and flash back your backup directly to the chip. This sounds more difficult than it is. The difficult part will be getting the board out of the NUC case and fitting the chip reader clip on the tiny chip. Please make sure you only do this in Linux with ```flashrom```.

I've had only one flash go bad where it froze halfway flashing and up on reboot the interface was gone, no matter which ACPI patch I used when booting. I had to flash back the backup to the tiny Winbond chip on the bottom (cpu side) of the board. After flashing the backup back the interface was detected again.

There is a lot of info on the web about how to use ```flashrom``` to read/write to chips. A programmer costs about $10-15 depending on where oyu get it. If you can wait China is cheapest, if you can't wait Amazon has them in stock with Prime delivery. I personally use [this](http://keeyees.com/a/Products/ej/36.html) programmer and have good results with it. Whatever you end up buying do not use Windows to read/write flash chips. The drivers are unstable and the software very buggy. USe a Linux Live usb stick if you don't have Linux and do it properly. It will save you a lot of time and headaches.
