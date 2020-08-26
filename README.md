# NUC8IxBEx Hackintosh

This is a testing branch for Big Sur. It only has essential configuration and kexts.

Currently the SMBIOS has been set to MacBookPro 15,2 instead of Mac mini 8,1. I will likely switch back and forth between them to figure out which is the "best" match for my usage. This MBP model has the exact same CPU as the i5 NUC that I own.

## Notes
+ Near the end of the install the system volume will be cryptographically sealed, this will take [some](https://dortania.github.io/OpenCore-Install-Guide/extras/big-sur/#troubleshooting) time
+ Disable; powernap, wake on lan and other related options post-install (pmset/Hackintool)

## Errors
I got a bunch of errors about diskXs5s1, note the additonal s1, it was related to an apfs snapshot. Booting into recovery and removing the snapshot fixed that.

List the snapshots with ```diskutil apfs listSnapshots diskXs5s1``` and delete with ```diskutil apfs deleteSnapshot diskXs5s1 -uuid UUIDHERE```.
