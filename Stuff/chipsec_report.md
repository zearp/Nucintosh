```
################################################################
##                                                            ##
##  CHIPSEC: Platform Hardware Security Assessment Framework  ##
##                                                            ##
################################################################
[CHIPSEC] Version 1.5.4
[CHIPSEC] Arguments: -l log.txt

[CHIPSEC] API mode: using CHIPSEC kernel module API
[CHIPSEC] OS      : uefi   
[CHIPSEC] Python  : 2.7.2 (64-bit)
[CHIPSEC] Helper  : EfiHelper (None)
[CHIPSEC] Platform: Desktop 8th Generation Core Processor (CoffeeLake U 4 Cores)
[CHIPSEC]      VID: 8086
[CHIPSEC]      DID: 3ED0
[CHIPSEC]      RID: 08
[CHIPSEC] PCH     : Intel 300 series On-Package PCH
[CHIPSEC]      VID: 8086
[CHIPSEC]      DID: 9D84
[CHIPSEC]      RID: 30
 
[*] loading common modules from ".\chipsec\modules\common" ..
[*] No platform specific modules to load
[*] loading modules from ".\chipsec\modules" ..
[+] loaded chipsec.modules.common.bios_kbrd_buffer
[+] loaded chipsec.modules.common.bios_smi
[+] loaded chipsec.modules.common.bios_ts
[+] loaded chipsec.modules.common.bios_wp
[+] loaded chipsec.modules.common.cpu.cpu_info
[+] loaded chipsec.modules.common.cpu.ia_untrusted
[+] loaded chipsec.modules.common.cpu.spectre_v2
[+] loaded chipsec.modules.common.debugenabled
[+] loaded chipsec.modules.common.ia32cfg
[+] loaded chipsec.modules.common.me_mfg_mode
[+] loaded chipsec.modules.common.memconfig
[+] loaded chipsec.modules.common.memlock
[+] loaded chipsec.modules.common.remap
[+] loaded chipsec.modules.common.rtclock
[+] loaded chipsec.modules.common.secureboot.variables
[+] loaded chipsec.modules.common.sgx_check
[+] loaded chipsec.modules.common.smm
[+] loaded chipsec.modules.common.smm_dma
[+] loaded chipsec.modules.common.smrr
[+] loaded chipsec.modules.common.spd_wd
[+] loaded chipsec.modules.common.spi_access
[+] loaded chipsec.modules.common.spi_desc
[+] loaded chipsec.modules.common.spi_fdopss
[+] loaded chipsec.modules.common.spi_lock
[+] loaded chipsec.modules.common.uefi.access_uefispec
[+] loaded chipsec.modules.common.uefi.s3bootscript
[*] running loaded modules ..

[*] running module: chipsec.modules.common.bios_kbrd_buffer
[x][ =======================================================================
[x][ Module: Pre-boot Passwords in the BIOS Keyboard Buffer
[x][ =======================================================================
[*] Keyboard buffer head pointer = 0x1E (at 0x41A), tail pointer = 0x1E (at 0x41C)
[*] Keyboard buffer contents (at 0x41E):
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 |                 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 |                 
[*] Checking contents of the keyboard buffer..

[+] PASSED: Keyboard buffer looks empty. Pre-boot passwords don't seem to be exposed

[*] running module: chipsec.modules.common.bios_smi
[x][ =======================================================================
[x][ Module: SMI Events Configuration
[x][ =======================================================================
[+] SMM BIOS region write protection is enabled (SMM_BWP is used)

[*] Checking SMI enables..
    Global SMI enable: 1
    TCO SMI enable   : 1
[+] All required SMI events are enabled

[*] Checking SMI configuration locks..
[+] TCO SMI configuration is locked (TCO SMI Lock)
[+] SMI events global configuration is locked (SMI Lock)

[+] PASSED: All required SMI sources seem to be enabled and locked

[*] running module: chipsec.modules.common.bios_ts
[x][ =======================================================================
[x][ Module: BIOS Interface Lock (including Top Swap Mode)
[x][ =======================================================================
[*] BiosInterfaceLockDown (BILD) control = 1
[*] BIOS Top Swap mode is disabled (TSS = 0)
[*] RTC TopSwap control (TS) = 1
[+] PASSED: BIOS Interface is locked (including Top Swap Mode)

[*] running module: chipsec.modules.common.bios_wp
[x][ =======================================================================
[x][ Module: BIOS Region Write Protection
[x][ =======================================================================
[*] BC = 0x000008AA << BIOS Control (b:d.f 00:31.5 + 0xDC)
    [00] BIOSWE           = 0 << BIOS Write Enable 
    [01] BLE              = 1 << BIOS Lock Enable 
    [02] SRC              = 2 << SPI Read Configuration 
    [04] TSS              = 0 << Top Swap Status 
    [05] SMM_BWP          = 1 << SMM BIOS Write Protection 
    [06] BBS              = 0 << Boot BIOS Strap 
    [07] BILD             = 1 << BIOS Interface Lock Down 
[+] BIOS region write protection is enabled (writes restricted to SMM)

[*] BIOS Region: Base = 0x00800000, Limit = 0x00FFFFFF
SPI Protected Ranges
------------------------------------------------------------
PRx (offset) | Value    | Base     | Limit    | WP? | RP?
------------------------------------------------------------
PR0 (84)     | 8FFF0860 | 00860000 | 00FFFFFF | 1   | 0 
PR1 (88)     | 00000000 | 00000000 | 00000000 | 0   | 0 
PR2 (8C)     | 00000000 | 00000000 | 00000000 | 0   | 0 
PR3 (90)     | 00000000 | 00000000 | 00000000 | 0   | 0 
PR4 (94)     | 00000000 | 00000000 | 00000000 | 0   | 0 

[!] SPI protected ranges write-protect parts of BIOS region (other parts of BIOS can be modified)

[+] PASSED: BIOS is write protected

[*] running module: chipsec.modules.common.cpu.cpu_info
[x][ =======================================================================
[x][ Module: Current Processor Information:
[x][ =======================================================================
[*] Thread 0000
[*] Processor: Intel(R) Core(TM) i5-8259U CPU @ 2.30GHz
[*]            Family: 06 Model: 8E Stepping: A
[*]            Microcode: 000000CA
[*]
[#] INFORMATION: Processor information displayed

[*] running module: chipsec.modules.common.cpu.ia_untrusted
Skipping module chipsec.modules.common.cpu.ia_untrusted since it is not supported in this platform

[*] running module: chipsec.modules.common.cpu.spectre_v2
[x][ =======================================================================
[x][ Module: Checks for Branch Target Injection / Spectre v2 (CVE-2017-5715)
[x][ =======================================================================
[*] CPUID.7H:EDX[26] = 1 Indirect Branch Restricted Speculation (IBRS) & Predictor Barrier (IBPB)
[*] CPUID.7H:EDX[27] = 1 Single Thread Indirect Branch Predictors (STIBP)
[*] CPUID.7H:EDX[29] = 0 IA32_ARCH_CAPABILITIES
[+] CPU supports IBRS and IBPB
[+] CPU supports STIBP
[-] CPU doesn't support enhanced IBRS
[!] WARNING: CPU supports mitigation (IBRS) but doesn't support enhanced IBRS
[!] OS may be using software based mitigation (eg. retpoline)

[*] running module: chipsec.modules.common.debugenabled
[x][ =======================================================================
[x][ Module: Debug features test
[x][ =======================================================================

[*] Checking IA32_DEBUG_INTERFACE msr status
[+] CPU debug interface state is correct.

[*] Checking DCI register status
[+] DCI Debug is disabled

[*] Module Result
[+] PASSED: All checks have successfully passed

[*] running module: chipsec.modules.common.ia32cfg
[x][ =======================================================================
[x][ Module: IA32 Feature Control Lock
[x][ =======================================================================
[*] Verifying IA32_Feature_Control MSR is locked on all logical CPUs..
[*] cpu0: IA32_Feature_Control Lock = 1
[+] PASSED: IA32_FEATURE_CONTROL MSR is locked on all logical CPUs

[*] running module: chipsec.modules.common.me_mfg_mode
[x][ =======================================================================
[x][ Module: ME Manufacturing Mode
[x][ =======================================================================
[+] PASSED: ME is not in Manufacturing Mode

[*] running module: chipsec.modules.common.memconfig
[x][ =======================================================================
[x][ Module: Host Bridge Memory Map Locks
[x][ =======================================================================
[*]
[*] Checking register lock state:
[+] PCI0.0.0_BDSM        = 0x        7C000001 - LOCKED   - Base of Graphics Stolen Memory
[+] PCI0.0.0_BGSM        = 0x        7B800001 - LOCKED   - Base of GTT Stolen Memory
[+] PCI0.0.0_DPR         = 0x        7B000001 - LOCKED   - DMA Protected Range
[+] PCI0.0.0_GGC         = 0x             2C1 - LOCKED   - Graphics Control
[+] PCI0.0.0_MESEG_MASK  = 0x      7FFE000C00 - LOCKED   - Manageability Engine Limit Address Register
[+] PCI0.0.0_PAVPC       = 0x        7FF00047 - LOCKED   - PAVP Configuration
[+] PCI0.0.0_REMAPBASE   = 0x       3FE000001 - LOCKED   - Memory Remap Base Address
[+] PCI0.0.0_REMAPLIMIT  = 0x       47DF00001 - LOCKED   - Memory Remap Limit Address
[+] PCI0.0.0_TOLUD       = 0x        80000001 - LOCKED   - Top of Low Usable DRAM
[+] PCI0.0.0_TOM         = 0x       400000001 - LOCKED   - Top of Memory
[+] PCI0.0.0_TOUUD       = 0x       47E000001 - LOCKED   - Top of Upper Usable DRAM
[+] PCI0.0.0_TSEGMB      = 0x        7B000001 - LOCKED   - TSEG Memory Base
[*]
[+] PASSED: All memory map registers seem to be locked down

[*] running module: chipsec.modules.common.memlock
[x][ =======================================================================
[x][ Module: Check MSR_LT_LOCK_MEMORY
[x][ =======================================================================
[X] Checking MSR_LT_LOCK_MEMORY status
[*]   cpu0: MSR_LT_LOCK_MEMORY[LT_LOCK] = 1
[+] PASSED: Check have successfully passed

[*] running module: chipsec.modules.common.remap
[x][ =======================================================================
[x][ Module: Memory Remapping Configuration
[x][ =======================================================================
[*] Registers:
[*]   TOUUD     : 0x000000047E000001
[*]   REMAPLIMIT: 0x000000047DF00001
[*]   REMAPBASE : 0x00000003FE000001
[*]   TOLUD     : 0x80000001
[*]   TSEGMB    : 0x7B000001

[*] Memory Map:
[*]   Top Of Upper Memory: 0x000000047E000000
[*]   Remap Limit Address: 0x000000047DFFFFFF
[*]   Remap Base Address : 0x00000003FE000000
[*]   4GB                : 0x0000000100000000
[*]   Top Of Low Memory  : 0x0000000080000000
[*]   TSEG (SMRAM) Base  : 0x000000007B000000

[*] checking memory remap configuration..
[*]   Memory Remap is enabled
[+]   Remap window configuration is correct: REMAPBASE <= REMAPLIMIT < TOUUD
[+]   All addresses are 1MB aligned
[*] checking if memory remap configuration is locked..
[+]   TOUUD is locked
[+]   TOLUD is locked
[+]   REMAPBASE and REMAPLIMIT are locked
[+] PASSED: Memory Remap is configured correctly and locked

[*] running module: chipsec.modules.common.rtclock
[x][ =======================================================================
[x][ Module: Protected RTC memory locations
[x][ =======================================================================
[!] WARNING: Unable to test lock bits without attempting to modify CMOS.
[*] Run chipsec_main manually with the following commandline flags.
[*] python chipsec_main -m common.rtclock -a modify

[*] running module: chipsec.modules.common.secureboot.variables
[x][ =======================================================================
[x][ Module: Attributes of Secure Boot EFI Variables
[x][ =======================================================================
[*] Checking protections of UEFI variable 61dfe48b-ca93-d211-aa0d-00e098032b8c:SecureBoot
[*] Checking protections of UEFI variable 61dfe48b-ca93-d211-aa0d-00e098032b8c:SetupMode
[*] Checking protections of UEFI variable 61dfe48b-ca93-d211-aa0d-00e098032b8c:PK
[+] Variable 61dfe48b-ca93-d211-aa0d-00e098032b8c:PK is authenticated (TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
[*] Checking protections of UEFI variable 61dfe48b-ca93-d211-aa0d-00e098032b8c:KEK
[+] Variable 61dfe48b-ca93-d211-aa0d-00e098032b8c:KEK is authenticated (TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
[*] Checking protections of UEFI variable cbb219d7-3a3d-9645-a3bc-dad00e67656f:db
[+] Variable cbb219d7-3a3d-9645-a3bc-dad00e67656f:db is authenticated (TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
[*] Checking protections of UEFI variable cbb219d7-3a3d-9645-a3bc-dad00e67656f:dbx
[+] Variable cbb219d7-3a3d-9645-a3bc-dad00e67656f:dbx is authenticated (TIME_BASED_AUTHENTICATED_WRITE_ACCESS)

[*] Secure Boot appears to be disabled
[+] PASSED: All Secure Boot UEFI variables are protected

[*] running module: chipsec.modules.common.sgx_check
ERROR: Currently this module cannot run within the EFI Shell. Exiting.

[*] running module: chipsec.modules.common.smm
[x][ =======================================================================
[x][ Module: Compatible SMM memory (SMRAM) Protection
[x][ =======================================================================
[*] PCI0.0.0_SMRAMC = 0x1A << System Management RAM Control (b:d.f 00:00.0 + 0x88)
    [00] C_BASE_SEG       = 2 << SMRAM Base Segment = 010b 
    [03] G_SMRAME         = 1 << SMRAM Enabled 
    [04] D_LCK            = 1 << SMRAM Locked 
    [05] D_CLS            = 0 << SMRAM Closed 
    [06] D_OPEN           = 0 << SMRAM Open 
[*] Compatible SMRAM is enabled
[+] PASSED: Compatible SMRAM is locked down

[*] running module: chipsec.modules.common.smm_dma
[x][ =======================================================================
[x][ Module: SMM TSEG Range Configuration Check
[x][ =======================================================================
[*] TSEG      : 0x000000007B000000 - 0x000000007B7FFFFF (size = 0x00800000)
[*] SMRR range: 0x000000007B000000 - 0x000000007B7FFFFF (size = 0x00800000)

[*] checking TSEG range configuration..
[+] TSEG range covers entire SMRAM
[+] TSEG range is locked
[+] PASSED: TSEG is properly configured. SMRAM is protected from DMA attacks

[*] running module: chipsec.modules.common.smrr
[x][ =======================================================================
[x][ Module: CPU SMM Cache Poisoning / System Management Range Registers
[x][ =======================================================================
[+] OK. SMRR range protection is supported

[*] Checking SMRR range base programming..
[*] IA32_SMRR_PHYSBASE = 0x7B000006 << SMRR Base Address MSR (MSR 0x1F2)
    [00] Type             = 6 << SMRR memory type 
    [12] PhysBase         = 7B000 << SMRR physical base address 
[*] SMRR range base: 0x000000007B000000
[*] SMRR range memory type is Writeback (WB)
[+] OK so far. SMRR range base is programmed

[*] Checking SMRR range mask programming..
[*] IA32_SMRR_PHYSMASK = 0xFF800800 << SMRR Range Mask MSR (MSR 0x1F3)
    [11] Valid            = 1 << SMRR valid 
    [12] PhysMask         = FF800 << SMRR address range mask 
[*] SMRR range mask: 0x00000000FF800000
[+] OK so far. SMRR range is enabled

[*] Verifying that SMRR range base & mask are the same on all logical CPUs..
[CPU0] SMRR_PHYSBASE = 000000007B000006, SMRR_PHYSMASK = 00000000FF800800
[+] OK so far. SMRR range base/mask match on all logical CPUs
[*] Trying to read memory at SMRR base 0x7B000000..
[+] PASSED: SMRR reads are blocked in non-SMM mode

[+] PASSED: SMRR protection against cache attack is properly configured

[*] running module: chipsec.modules.common.spd_wd
[x][ =======================================================================
[x][ Module: SPD Write Disable
[x][ =======================================================================
[+] PASSED: SPD Write Disable is set

[*] running module: chipsec.modules.common.spi_access
[x][ =======================================================================
[x][ Module: SPI Flash Region Access Control
[x][ =======================================================================
SPI Flash Region Access Permissions
------------------------------------------------------------

BIOS Region Write Access Grant (00):
  FREG0_FLASHD: 0
  FREG1_BIOS  : 0
  FREG2_ME    : 0
  FREG3_GBE   : 0
  FREG4_PD    : 0
  FREG5       : 0
BIOS Region Read Access Grant (00):
  FREG0_FLASHD: 0
  FREG1_BIOS  : 0
  FREG2_ME    : 0
  FREG3_GBE   : 0
  FREG4_PD    : 0
  FREG5       : 0
BIOS Region Write Access (4A):
  FREG0_FLASHD: 0
  FREG1_BIOS  : 1
  FREG2_ME    : 0
  FREG3_GBE   : 1
  FREG4_PD    : 0
  FREG5       : 0
BIOS Region Read Access (CF):
  FREG0_FLASHD: 1
  FREG1_BIOS  : 1
  FREG2_ME    : 1
  FREG3_GBE   : 1
  FREG4_PD    : 0
  FREG5       : 0
[!] WARNING: Software has write access to GBe region in SPI flash
[!] WARNING: Certain SPI flash regions are writeable by software

[*] running module: chipsec.modules.common.spi_desc
[x][ =======================================================================
[x][ Module: SPI Flash Region Access Control
[x][ =======================================================================
[*] FRAP = 0x00004ACF << SPI Flash Regions Access Permissions Register (SPIBAR + 0x50)
    [00] BRRA             = CF << BIOS Region Read Access 
    [08] BRWA             = 4A << BIOS Region Write Access 
    [16] BMRAG            = 0 << BIOS Master Read Access Grant 
    [24] BMWAG            = 0 << BIOS Master Write Access Grant 
[*] Software access to SPI flash regions: read = 0xCF, write = 0x4A

[+] PASSED: SPI flash permissions prevent SW from writing to flash descriptor

[*] running module: chipsec.modules.common.spi_fdopss
[x][ =======================================================================
[x][ Module: SPI Flash Descriptor Security Override Pin-Strap
[x][ =======================================================================
[*] HSFS = 0x0010E800 << Hardware Sequencing Flash Status Register (SPIBAR + 0x4)
    [00] FDONE            = 0 << Flash Cycle Done 
    [01] FCERR            = 0 << Flash Cycle Error 
    [02] AEL              = 0 << Access Error Log 
    [05] SCIP             = 0 << SPI cycle in progress 
    [11] WRSDIS           = 1 << Write status disable 
    [12] PR34LKD          = 0 << PRR3 PRR4 Lock-Down 
    [13] FDOPSS           = 1 << Flash Descriptor Override Pin-Strap Status 
    [14] FDV              = 1 << Flash Descriptor Valid 
    [15] FLOCKDN          = 1 << Flash Configuration Lock-Down 
    [16] FGO              = 0 << Flash cycle go 
    [17] FCYCLE           = 8 << Flash Cycle Type 
    [21] WET              = 0 << Write Enable Type 
    [24] FDBC             = 0 << Flash Data Byte Count 
    [31] FSMIE            = 0 << Flash SPI SMI# Enable 
[+] PASSED: SPI Flash Descriptor Security Override is disabled

[*] running module: chipsec.modules.common.spi_lock
[x][ =======================================================================
[x][ Module: SPI Flash Controller Configuration Locks
[x][ =======================================================================
[*] HSFS = 0x0010E800 << Hardware Sequencing Flash Status Register (SPIBAR + 0x4)
    [00] FDONE            = 0 << Flash Cycle Done 
    [01] FCERR            = 0 << Flash Cycle Error 
    [02] AEL              = 0 << Access Error Log 
    [05] SCIP             = 0 << SPI cycle in progress 
    [11] WRSDIS           = 1 << Write status disable 
    [12] PR34LKD          = 0 << PRR3 PRR4 Lock-Down 
    [13] FDOPSS           = 1 << Flash Descriptor Override Pin-Strap Status 
    [14] FDV              = 1 << Flash Descriptor Valid 
    [15] FLOCKDN          = 1 << Flash Configuration Lock-Down 
    [16] FGO              = 0 << Flash cycle go 
    [17] FCYCLE           = 8 << Flash Cycle Type 
    [21] WET              = 0 << Write Enable Type 
    [24] FDBC             = 0 << Flash Data Byte Count 
    [31] FSMIE            = 0 << Flash SPI SMI# Enable 
[+] SPI write status disable set.
[+] SPI Flash Controller configuration is locked
[+] PASSED: SPI Flash Controller locked correctly.

[*] running module: chipsec.modules.common.uefi.access_uefispec
[x][ =======================================================================
[x][ Module: Access Control of EFI Variables
[x][ =======================================================================
[*] Testing UEFI variables ..
[*] Variable dir (BS)
[*] Variable FlashUpdateSleepDelay (BS+RT)
[*] Variable WAND (NV+BS+RT)
[*] Variable nvda_drv (NV+BS+RT)
[!] Found two instances of the variable BootOrder.
[*] Variable BootOrder (NV+BS+RT)
[*] Variable BootOrder (NV+BS+RT)
[*] Variable BootOrder (NV+BS+RT)
[*] Variable SetupCpuFeatures (NV+BS+RT)
[*] Variable move (BS)
[*] Variable WakeUpType (NV+BS)
[*] Variable InitSetupVariable (NV+BS)
[*] Variable dbx (NV+BS+RT+TBAWS)
[*] Variable SystemAudioVolume (NV+BS+RT)
[*] Variable PasswordInfo (NV+BS+RT)
[*] Variable CurrentActivePolicy (NV+BS)
[*] Variable SecureBootSetup (NV+BS+RT)
[*] Variable AAPL,PathProperties0000 (NV+BS+RT)
[*] Variable SecurityTokens (NV+BS+RT)
[*] Variable ConOut (NV+BS+RT)
[*] Variable DefaultLegacyDevOrder (NV+BS+RT)
[*] Variable DynamicPageGroupClass (BS)
[*] Variable StdDefaults (NV+BS+RT)
[*] Variable copy (BS)
[*] Variable FlashStatus (NV+BS+RT)
[*] Variable TcgInternalSyncFlag (NV+BS)
[*] Variable OldLegacyDevOrder (NV+BS)
[*] Variable PCRBitmap (NV+BS)
[*] Variable AmiCpuSetupFeatures (BS)
[*] Variable PlatformLangCodes (BS+RT)
[*] Variable csr-active-config (NV+BS+RT)
[*] Variable opencore-version (NV+BS+RT)
[*] Variable OptaneState (BS)
[*] Variable cd\ (BS)
[*] Variable ren (BS)
[*] Variable BRDS (NV+BS+RT)
[*] Variable LastBoot (NV+BS+RT)
[*] Variable TodayEvents (NV+BS+RT)
[*] Variable md (BS)
[*] Variable Setup (NV+BS+RT)
[*] Variable MemorySize (NV+BS+RT)
[*] Variable NetworkStackVar (NV+BS)
[!] Found two instances of the variable GPC.
[*] Variable GPC (NV+BS+RT)
[*] Variable GPC (NV+BS+RT)
[*] Variable SaPegData (NV+BS)
[*] Variable ONBOARD DEV DATA (BS)
[*] Variable OfflineUniqueIDEKPubCRC (NV+BS+RT)
[*] Variable TPMPERBIOSFLAGS (NV+BS+RT)
[*] Variable DefaultDriveOrder (BS)
[*] Variable 1C697A68D393_IAIDPXE (NV+BS)
[*] Variable UsbMassDevNum (BS)
[*] Variable LegacyDev (BS)
[*] Variable BootOptionSupport (BS+RT)
[*] Variable UUID (NV+BS+RT)
[*] Variable uefishellsupport (BS)
[*] Variable Main Block firmware (NV+BS+RT)
[*] Variable WdtPersistentData (NV+BS)
[*] Variable LegacyDevOrder (NV+BS+RT)
[*] Variable PreviousMemoryTypeInformation (NV+BS)
[*] Variable CurrentSettingValues (NV+BS+RT)
[*] Variable BkupAMITSESetup (NV+BS+RT)
[*] Variable uefishellversion (BS)
[*] Variable SmbiosScratchBuffer (NV+BS+RT)
[*] Variable FPDT_Volatile (BS+RT)
[*] Variable path (BS)
[*] Variable NativeResolution (BS)
[*] Variable ConOutDev (BS+RT)
[*] Variable ItkModifiedSetup (BS)
[*] Variable EvaluateDefaults4FirstBoot (NV+BS)
[*] Variable DefaultBootOrder (NV+BS+RT)
[*] Variable LocationServicesEnabled (NV+BS+RT)
[*] Variable VarEq (BS)
[*] Variable VV_SIO0_LD0 (BS)
[*] Variable WGDS (NV+BS+RT)
[*] Variable SmbiosEntryPointTable (NV+BS+RT)
[*] Variable PlatformConfigurationChange (NV+BS)
[*] Variable SdioDevConfiguration (NV+BS+RT)
[*] Variable FPDT_Variable_NV (NV+BS)
[*] Variable PlatformFviSetupDataVar (NV+BS)
[*] Variable BootOptionInfo0001 (BS)
[*] Variable PcieSataSetupVar (BS)
[*] Variable UnlockIDCopy (NV+BS+RT)
[*] Variable POSTCounter (NV+BS+RT)
[*] Variable boot-args (NV+BS+RT)
[*] Variable UsbMassDevValid (BS)
[*] Variable SLP20Magic (NV+BS+RT)
[*] Variable FlashInfoStructure (NV+BS+RT)
[*] Variable PCI_COMMON (NV+BS+RT)
[*] Variable fmm-computer-name (NV+BS+RT)
[*] Variable UnlockID (NV+BS)
[*] Variable IccAdvancedSetupDataVar (NV+BS+RT)
[*] Variable IsaDmaMask (BS)
[*] Variable SinitSvn (NV+BS)
[*] Variable PK (NV+BS+RT+TBAWS)
[*] Variable cwd (BS)
[*] Variable 888888888788_IAIDPXE (NV+BS)
[*] Variable mem (BS)
[*] Variable MaximumTableSize (NV+BS+RT)
[*] Variable DefaultUefiDriveOrder (BS)
[*] Variable SPLC (NV+BS+RT)
[*] Variable HSTI_RESULTS (NV+BS)
[*] Variable DynamicPageCount (BS)
[*] Variable BluetoothUHEDevices (NV+BS+RT)
[*] Variable SystemAccess (BS)
[*] Variable preferred-count (NV+BS+RT)
[*] Variable isUsbLidSku (NV+BS)
[*] Variable BootFlow (BS)
[*] Variable NBPlatformData (BS)
[*] Variable Boot9696 (NV+BS+RT)
[*] Variable Boot9697 (NV+BS+RT)
[*] Variable nonesting (BS)
[!] Found two instances of the variable 1C697A68D393.
[*] Variable 1C697A68D393 (NV+BS)
[*] Variable 1C697A68D393 (NV+BS)
[*] Variable BootDebugPolicyApplied (NV+BS)
[*] Variable Tpm20PCRallocateReset (NV+BS)
[*] Variable HiiDB (NV+BS+RT)
[*] Variable db (NV+BS+RT+TBAWS)
[*] Variable Ep (NV+BS+RT)
[*] Variable OfflineUniqueIDEKPub (NV+BS+RT)
[*] Variable Attempt 2 (NV+BS)
[*] Variable ConInDev (BS+RT)
[*] Variable Boot0001 (NV+BS+RT)
[*] Variable IsaIrqMask (BS)
[*] Variable DmiData (NV+BS+RT)
[*] Variable ErrOut (NV+BS+RT)
[*] Variable Intel(R) Management Engine firmware (NV+BS+RT)
[*] Variable UsbControllerNum (BS)
[*] Variable LegacyGroup (BS)
[*] Variable AMITSESetup (NV+BS+RT)
[*] Variable DeploymentModeNv (NV+BS+RT)
[*] Variable Events (NV+BS+RT)
[*] Variable MfgMode (NV+BS+RT)
[*] Variable cd.. (BS)
[*] Variable TpmServFlags (BS+RT)
[*] Variable PlatformLastLangCodes (NV+BS)
[*] Variable HiiWhiteList (NV+BS+RT)
[*] Variable MeSetupStorage (NV+BS+RT)
[*] Variable preferred-networks (NV+BS+RT)
[*] Variable UsbSupport (NV+BS)
[*] Variable VendorKeys (BS+RT)
[*] Variable DynamicPageGroupCount (BS)
[*] Variable SIO_DEV_STATUS_VAR (BS)
[*] Variable UIScale (NV+BS+RT)
[*] Variable FV Data firmware (NV+BS+RT)
[*] Variable WRDD (NV+BS+RT)
[*] Variable uefiversion (BS)
[*] Variable BootManager (BS)
[*] Variable DriverHealthCount (BS)
[*] Variable SIDSUPPORT (NV+BS+RT)
[*] Variable Boot9698 (NV+BS+RT)
[*] Variable EWRD (NV+BS+RT)
[*] Variable WRDS (NV+BS+RT)
[*] Variable ClientId (NV+BS)
[*] Variable Timeout (NV+BS+RT)
[!] Found two instances of the variable 888888888788.
[*] Variable 888888888788 (NV+BS)
[*] Variable 888888888788 (NV+BS)
[*] Variable ONBOARD DEV EXTENDED DATA (BS)
[*] Variable BootOptionInfo9696 (BS)
[*] Variable SmbiosV3EntryPointTable (NV+BS+RT)
[*] Variable SignatureSupport (BS+RT)
[*] Variable KEK (NV+BS+RT+TBAWS)
[*] Variable bluetoothActiveControllerInfo (NV+BS+RT)
[*] Variable InitialAttemptOrder (NV+BS)
[*] Variable DriverManager (BS)
[*] Variable SOFTWAREGUARDSTATUS (BS+RT)
[*] Variable mount (BS)
[*] Variable profiles (BS)
[*] Variable cat (BS)
[*] Variable MemoryTypeInformation (NV+BS)
[*] Variable del (BS)
[*] Variable SetupVolatileData (BS)
[*] Variable SetupMode (BS+RT)
[*] Variable ITK50BootCount (NV+BS)
[*] Variable IntUcode (NV+BS)
[*] Variable WindowsBootChainSvn (NV+BS)
[*] Variable MonotonicCounter (NV+BS+RT)
[*] Variable Attempt 3 (NV+BS)
[*] Variable Attempt 1 (NV+BS)
[*] Variable Attempt 6 (NV+BS)
[*] Variable Attempt 7 (NV+BS)
[*] Variable Attempt 4 (NV+BS)
[*] Variable Attempt 5 (NV+BS)
[*] Variable Guid1394 (NV+BS+RT)
[*] Variable CpuSmm (NV+BS+RT)
[*] Variable Attempt 8 (NV+BS)
[*] Variable MemoryOverwriteRequestControl (NV+BS+RT)
[*] Variable MemoryOverwriteRequestControlLock (NV+BS+RT)
[*] Variable SecureBoot (BS+RT)
[*] Variable BackUp Recovery Block firmware (NV+BS+RT)
[*] Variable NV_SIO0_LD0 (NV+BS)
[*] Variable SetupDefault (NV+BS+RT)
[!] Found two instances of the variable Boot0080.
[*] Variable Boot0080 (NV+BS+RT)
[*] Variable Boot0080 (NV+BS+RT)
[*] Variable BootNowCount (BS)
[*] Variable EfiTime (NV+BS+RT)
[*] Variable ErrOutDev (BS+RT)
[*] Variable ITKCompatibility (NV+BS+RT)
[*] Variable DriverHlthEnable (BS)
[*] Variable GraphicalAssetInfo (NV+BS+RT)
[*] Variable _kdp_ipstr (NV+BS+RT)
[*] Variable SystemAudioVolumeDB (NV+BS+RT)
[*] Variable ConstructDefaults4FirstBoot (NV+BS)
[*] Variable prev-lang:kbd (NV+BS+RT)
[*] Variable ConIn (NV+BS+RT)
[*] Variable MeInfoSetup (BS)
[*] Variable lasterror (BS)
[*] Variable CapsuleLongModeBuffer (NV+BS)
[*] Variable BootingDeviceTypeInfo (NV+BS)
[*] Variable SLX (NV+BS)
[*] Variable AcousticVarName (NV+BS)
[*] Variable CurrentPolicy (NV+BS+RT+TBAWS)
[*] Variable RstOptaneConfig (NV+BS+RT)
[*] Variable FastBootOption (NV+BS+RT)
[*] Variable Boot Block firmware (NV+BS+RT)
[*] Variable SmbiosEntryPointTableF000 (NV+BS+RT)
[*] Variable OsIndicationsSupported (BS+RT)
[!] Found two instances of the variable SADS.
[*] Variable SADS (NV+BS+RT)
[*] Variable SADS (NV+BS+RT)
[*] Variable BEL10SKU (NV+BS)
[*] Variable Graphic firmware (NV+BS+RT)
[*] Variable MemCeil. (NV+BS)
[*] Variable BootOptionInfo9697 (BS)
[*] Variable xLegacyDevOrder (BS)
[*] Variable AMITCGPPIVAR (NV+BS+RT)
[*] Variable Recovery Block firmware (NV+BS+RT)
[*] Variable BootOptionInfo9698 (BS)
[*] Variable FirmwareId (NV+BS+RT)
[*] Variable MaintenanceSetup (NV+BS+RT)
[*] Variable EPCBIOS (NV+BS+RT)
[*] Variable AcpiResetVar (NV+BS)
[*] Variable AcpiGlobalVariable (NV+BS)
[*] Variable VendorKeysNv (NV+BS)
[*] Variable MemoryConfig (NV+BS)
[*] Variable BootCurrent (BS+RT)
[*] Variable PlatformLang (NV+BS+RT)
[*] Variable IDESecDev (BS)

[+] PASSED: All checked EFI variables are protected according to spec.

[*] running module: chipsec.modules.common.uefi.s3bootscript
[x][ =======================================================================
[x][ Module: S3 Resume Boot-Script Protections
[x][ =======================================================================
[*] SMRAM: Base = 0x000000007B000000, Limit = 0x000000007B7FFFFF, Size = 0x00800000
[!] Found 1 S3 boot-script(s) in EFI variables

[!] WARNING: S3 Boot-Script is inside SMRAM. The script is protected but Dispatch opcodes cannot be inspected
[!] Additional testing of the S3 boot-script can be done using tools.uefi.s3script_modify

[CHIPSEC] ***************************  SUMMARY  ***************************
[CHIPSEC] Time elapsed            2.000
[CHIPSEC] Modules total           26
[CHIPSEC] Modules failed to run   0:
[CHIPSEC] Modules passed          19:
[+] PASSED: chipsec.modules.common.bios_kbrd_buffer
[+] PASSED: chipsec.modules.common.bios_smi
[+] PASSED: chipsec.modules.common.bios_ts
[+] PASSED: chipsec.modules.common.bios_wp
[+] PASSED: chipsec.modules.common.debugenabled
[+] PASSED: chipsec.modules.common.ia32cfg
[+] PASSED: chipsec.modules.common.me_mfg_mode
[+] PASSED: chipsec.modules.common.memconfig
[+] PASSED: chipsec.modules.common.memlock
[+] PASSED: chipsec.modules.common.remap
[+] PASSED: chipsec.modules.common.secureboot.variables
[+] PASSED: chipsec.modules.common.smm
[+] PASSED: chipsec.modules.common.smm_dma
[+] PASSED: chipsec.modules.common.smrr
[+] PASSED: chipsec.modules.common.spd_wd
[+] PASSED: chipsec.modules.common.spi_desc
[+] PASSED: chipsec.modules.common.spi_fdopss
[+] PASSED: chipsec.modules.common.spi_lock
[+] PASSED: chipsec.modules.common.uefi.access_uefispec
[CHIPSEC] Modules information     1:
[#] INFORMATION: chipsec.modules.common.cpu.cpu_info
[CHIPSEC] Modules failed          0:
[CHIPSEC] Modules with warnings   4:
[!] WARNING: chipsec.modules.common.cpu.spectre_v2
[!] WARNING: chipsec.modules.common.rtclock
[!] WARNING: chipsec.modules.common.spi_access
[!] WARNING: chipsec.modules.common.uefi.s3bootscript
[CHIPSEC] Modules not implemented 1:
[*] NOT IMPLEMENTED: chipsec.modules.common.sgx_check
[CHIPSEC] Modules not applicable  1:
[*] NOT APPLICABLE: chipsec.modules.common.cpu.ia_untrusted
[CHIPSEC] *****************************************************************
```
