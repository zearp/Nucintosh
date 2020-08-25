# NUC8IxBEx Hackintosh

This is a testing branch for Big Sur. It only has essential configuration and kexts. The SMBIOS has been set to MacBookPro 15,2 instead of Mac mini 8,1. I will likely switch back and forth between them to figure out which is the "best" match for my usage. This MBP model has the exact same CPU as the i5 NUC which I own. It does need hibernate and sleep stuff configured properly or else you'll into sleep issues. Disable powernap, wake on lan, proximity wake, hibernate etc with Hackintool or pmset.

## Notes
+ Near the end of the install the system volume will be cryptographicll sealed, this will take [some](https://dortania.github.io/OpenCore-Install-Guide/extras/big-sur/#troubleshooting) time
