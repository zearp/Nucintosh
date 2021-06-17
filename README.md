# NUC8IxBEx Hackintosh

This is the Thundebolt "hotplug" testing branch. Do not use this unless you want to experiment with Thunderbolt firmware patching.

Current issues with firmware patches:
- Waking up from sleep causes a panic; controller isn't turned on fast enough. Needs kext and/or ACPI patches
- USB-c devices misbehave; not detected at all, working at wrong speed

Current issues with firmware unpatched:
- USB-c misbehaving too, need to investigate pre-patch usb-c behaviour

This branch might receive lots of updates followed by a period of nothing. I personally have no need for Thunderbolt hotplug and currently it causes more issues than it solves. I do like to tinker so from time to time I will mess around and update things here. Feel free to contribute either with a PR or by opening an issue. It would be awesome to get Thunderbolt to work properly but it's not a deal breaker since everything else works fine if you stick with the master branch.

New instructions on how to patch will be added below, I need to migrate and tidy up the old instructions:
https://github.com/zearp/Nucintosh/blob/tb3/Stuff/Tb3Patch.md

If the patch has been applies properly you should see something similar to this:
![110136257-c3b42f00-7dcf-11eb-996c-396086a87858](https://user-images.githubusercontent.com/63272687/122326370-7dbd4a00-cf2c-11eb-90f0-13731cf7321f.jpg)
