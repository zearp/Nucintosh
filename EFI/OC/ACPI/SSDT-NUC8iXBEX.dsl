/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLVI1BwU.aml, Thu Jan  7 08:34:51 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00004AE6 (19174)
 *     Revision         0x02
 *     Checksum         0x58
 *     OEM ID           "HACK"
 *     OEM Table ID     "HackLife"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "HACK", "HackLife", 0x00000000)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GPCB, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.H_EC._STA, UnknownObj)
    External (_SB_.PCI0.LPCB.MATH._STA, UnknownObj)
    External (_SB_.PCI0.PEG0, DeviceObj)
    External (_SB_.PCI0.RP05, DeviceObj)
    External (_SB_.PCI0.RP05.PXSX, DeviceObj)
    External (_SB_.PCI0.RP05.TBSE, FieldUnitObj)
    External (_SB_.PCI0.RP15.PXSX._STA, UnknownObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.XDCI.DVID, FieldUnitObj)
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PR00, ProcessorObj)
    External (_SB_.TBFP, MethodObj)    // 2 Arguments
    External (DVID, UnknownObj)
    External (STAS, UnknownObj)

    Name (RMDA, One)
    Mutex (TCFG, 0x00)
    Scope (\_GPE)
    {
        Method (_E40, 0, NotSerialized)  // _Exx: Edge-Triggered GPE, xx=0x00-0xFF
        {
            \_SB.PCI0.RP05.DBG1 ("Hot plug event")
            If (!\_SB.PCI0.RP05.OHPE ())
            {
                Return (Zero)
            }

            If (!OSDW ())
            {
                If ((\_SB.PCI0.RP05.POC0 == One))
                {
                    Return (Zero)
                }

                Sleep (0x0190)
                If ((\_SB.PCI0.RP05.WTLT () == One))
                {
                    \_SB.PCI0.RP05.ICMS ()
                }
                Else
                {
                }

                If (\_SB.PCI0.RP05.UPMB)
                {
                    \_SB.PCI0.RP05.UPMB = Zero
                    Sleep (One)
                }

                \_SB.PCI0.RP05.CMPE ()
            }
            Else
            {
                \_SB.PCI0.RP05.UPSB.AMPE ()
            }

            \_SB.PCI0.RP05.DBG1 ("End hotplug handler")
        }
    }

    Name (U2OP, Zero)
    Scope (_SB)
    {
        Scope (PR00)
        {
            If (_OSI ("Darwin"))
            {
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x02)
                    {
                        "plugin-type", 
                        One
                    })
                }
            }
        }

        Device (USBX)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If ((Arg2 == Zero))
                {
                    Return (Buffer (One)
                    {
                         0x03                                             // .
                    })
                }

                Return (Package (0x08)
                {
                    "kUSBSleepPowerSupply", 
                    0x13EC, 
                    "kUSBSleepPortCurrentLimit", 
                    0x0834, 
                    "kUSBWakePowerSupply", 
                    0x13EC, 
                    "kUSBWakePortCurrentLimit", 
                    0x0834
                })
            }
        }

        Scope (PCI0)
        {
             Device (MCHC)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (SBUS.BUS0)
            {
                Name (_CID, "smbus")  // _CID: Compatible ID
                Name (_ADR, Zero)  // _ADR: Address
                Device (DVL0)
                {
                    Name (_ADR, 0x57)  // _ADR: Address
                    Name (_CID, "diagsvault")  // _CID: Compatible ID
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (!Arg2)
                        {
                            Return (Buffer (One)
                            {
                                 0x57                                             // W
                            })
                        }

                        Return (Package (0x02)
                        {
                            "address", 
                            0x57
                        })
                    }
                }
            }
            
            Scope (RP05)
            {
                Method (OHPE, 0, NotSerialized)
                {
                    Return (One)
                }

                Method (DBG1, 1, NotSerialized)
                {
                    If (CondRefOf (\RMDT.P1))
                    {
                        \RMDT.P1 (Arg0)
                    }
                }

                Method (DBG2, 2, NotSerialized)
                {
                    If (CondRefOf (\RMDT.P2))
                    {
                        \RMDT.P2 (Arg0, Arg1)
                    }
                }

                Method (DBG3, 3, NotSerialized)
                {
                    If (CondRefOf (\RMDT.P3))
                    {
                        \RMDT.P3 (Arg0, Arg1, Arg2)
                    }
                }

                Name (EICM, Zero)
                Name (R020, Zero)
                Name (R024, Zero)
                Name (R028, Zero)
                Name (R02C, Zero)
                Name (R118, Zero)
                Name (R119, Zero)
                Name (R11A, Zero)
                Name (R11C, Zero)
                Name (R120, Zero)
                Name (R124, Zero)
                Name (R128, Zero)
                Name (R12C, Zero)
                Name (R218, Zero)
                Name (R219, Zero)
                Name (R21A, Zero)
                Name (R21C, Zero)
                Name (R220, Zero)
                Name (R224, Zero)
                Name (R228, Zero)
                Name (R22C, Zero)
                Name (R318, Zero)
                Name (R319, Zero)
                Name (R31A, Zero)
                Name (R31C, Zero)
                Name (R320, Zero)
                Name (R324, Zero)
                Name (R328, Zero)
                Name (R32C, Zero)
                Name (R418, Zero)
                Name (R419, Zero)
                Name (R41A, Zero)
                Name (R41C, Zero)
                Name (R420, Zero)
                Name (R424, Zero)
                Name (R428, Zero)
                Name (R42C, Zero)
                Name (RVES, Zero)
                Name (R518, Zero)
                Name (R519, Zero)
                Name (R51A, Zero)
                Name (R51C, Zero)
                Name (R520, Zero)
                Name (R524, Zero)
                Name (R528, Zero)
                Name (R52C, Zero)
                Name (R618, Zero)
                Name (R619, Zero)
                Name (R61A, Zero)
                Name (R61C, Zero)
                Name (R620, Zero)
                Name (R624, Zero)
                Name (R628, Zero)
                Name (R62C, Zero)
                Name (RH10, Zero)
                Name (RH14, Zero)
                Name (POC0, Zero)
                Method (MMBA, 2, Serialized)
                {
                    Local0 = (\_SB.PCI0.GPCB () + 0x000E4000)
                    OperationRegion (MMMM, SystemMemory, Local0, 0x24)
                    Field (MMMM, DWordAcc, NoLock, Preserve)
                    {
                        Offset (0x19), 
                        SB19,   8, 
                        Offset (0x20), 
                        SB20,   32
                    }

                    Switch (ToInteger (Arg0))
                    {
                        Case (One)
                        {
                            Local1 = Local0
                        }
                        Case (0x02)
                        {
                            Local1 = (\_SB.PCI0.GPCB () + (SB19 * 0x00100000))
                        }
                        Case (0x03)
                        {
                            Local1 = (\_SB.PCI0.GPCB () + ((SB19 + One) * 0x00100000))
                        }
                        Case (0x04)
                        {
                            Local1 = ((\_SB.PCI0.GPCB () + ((SB19 + One) * 0x00100000)) + 
                                0x8000)
                        }
                        Case (0x05)
                        {
                            Local1 = ((\_SB.PCI0.GPCB () + ((SB19 + One) * 0x00100000)) + 
                                0x00010000)
                        }
                        Case (0x06)
                        {
                            Local1 = ((\_SB.PCI0.GPCB () + ((SB19 + One) * 0x00100000)) + 
                                0x00020000)
                        }
                        Case (0x07)
                        {
                            Local1 = (\_SB.PCI0.GPCB () + ((SB19 + 0x02) * 0x00100000))
                        }
                        Case (0x08)
                        {
                            Local1 = ((((SB20 & 0xFFFC) << 0x10) & 0xFFF00000) + 
                                0x00039854)
                        }

                    }

                    DBG2 (Arg1, Local1)
                    Return (Local1)
                }

                OperationRegion (RSTR, SystemMemory, MMBA (0x08, "RSTR"), 0x0100)
                Field (RSTR, DWordAcc, NoLock, Preserve)
                {
                    CIOR,   32, 
                    Offset (0xB8), 
                    ISTA,   32, 
                    Offset (0xF0), 
                    ICME,   32
                }

                OperationRegion (RPSM, SystemMemory, MMBA (One, "ROOT"), 0x54)
                Field (RPSM, DWordAcc, NoLock, Preserve)
                {
                    RPVD,   32, 
                    RPR4,   8, 
                    Offset (0x18), 
                    RP18,   8, 
                    RP19,   8, 
                    RP1A,   8, 
                    Offset (0x1C), 
                    RP1C,   16, 
                    Offset (0x20), 
                    R_20,   32, 
                    R_24,   32, 
                    R_28,   32, 
                    R_2C,   32, 
                    Offset (0x52), 
                        ,   11, 
                    RPLT,   1, 
                    Offset (0x54)
                }

                OperationRegion (UPSM, SystemMemory, MMBA (0x02, "UPSB"), 0x0550)
                Field (UPSM, DWordAcc, NoLock, Preserve)
                {
                    UPVD,   32, 
                    UP04,   8, 
                    Offset (0x08), 
                    CLRD,   32, 
                    Offset (0x18), 
                    UP18,   8, 
                    UP19,   8, 
                    UP1A,   8, 
                    Offset (0x1C), 
                    UP1C,   16, 
                    Offset (0x20), 
                    UP20,   32, 
                    UP24,   32, 
                    UP28,   32, 
                    UP2C,   32, 
                    Offset (0xD2), 
                        ,   11, 
                    UPLT,   1, 
                    Offset (0xD4), 
                    Offset (0x544), 
                    UPMB,   1, 
                    Offset (0x548), 
                    T2PR,   32, 
                    P2TR,   32
                }

                OperationRegion (DNSM, SystemMemory, MMBA (0x03, "DSB0"), 0xD4)
                Field (DNSM, DWordAcc, NoLock, Preserve)
                {
                    DPVD,   32, 
                    DP04,   8, 
                    Offset (0x18), 
                    DP18,   8, 
                    DP19,   8, 
                    DP1A,   8, 
                    Offset (0x1C), 
                    DP1C,   16, 
                    Offset (0x20), 
                    DP20,   32, 
                    DP24,   32, 
                    DP28,   32, 
                    DP2C,   32, 
                    Offset (0xD2), 
                        ,   11, 
                    DPLT,   1, 
                    Offset (0xD4)
                }

                OperationRegion (DS3M, SystemMemory, MMBA (0x04, "DSB1"), 0x40)
                Field (DS3M, DWordAcc, NoLock, Preserve)
                {
                    D3VD,   32, 
                    D304,   8, 
                    Offset (0x18), 
                    D318,   8, 
                    D319,   8, 
                    D31A,   8, 
                    Offset (0x1C), 
                    D31C,   16, 
                    Offset (0x20), 
                    D320,   32, 
                    D324,   32, 
                    D328,   32, 
                    D32C,   32
                }

                OperationRegion (DS4M, SystemMemory, MMBA (0x05, "DSB2"), 0x0568)
                Field (DS4M, DWordAcc, NoLock, Preserve)
                {
                    D4VD,   32, 
                    D404,   8, 
                    Offset (0x18), 
                    D418,   8, 
                    D419,   8, 
                    D41A,   8, 
                    Offset (0x1C), 
                    D41C,   16, 
                    Offset (0x20), 
                    D420,   32, 
                    D424,   32, 
                    D428,   32, 
                    D42C,   32, 
                    Offset (0x564), 
                    DVES,   32
                }

                OperationRegion (DS5M, SystemMemory, MMBA (0x06, "DSB4"), 0x40)
                Field (DS5M, DWordAcc, NoLock, Preserve)
                {
                    D5VD,   32, 
                    D504,   8, 
                    Offset (0x18), 
                    D518,   8, 
                    D519,   8, 
                    D51A,   8, 
                    Offset (0x1C), 
                    D51C,   16, 
                    Offset (0x20), 
                    D520,   32, 
                    D524,   32, 
                    D528,   32, 
                    D52C,   32
                }

                OperationRegion (NHIM, SystemMemory, MMBA (0x07, "NHI0"), 0x40)
                Field (NHIM, DWordAcc, NoLock, Preserve)
                {
                    NH00,   32, 
                    NH04,   8, 
                    Offset (0x10), 
                    NH10,   32, 
                    NH14,   32
                }

                Method (PINI, 0, NotSerialized)
                {
                    If (OSDW ())
                    {
                        DBG1 ("TB3 _INI")
                        Acquire (TCFG, 0xFFFF)
                        R020 = R_20 /* \_SB_.PCI0.RP05.R_20 */
                        R024 = R_24 /* \_SB_.PCI0.RP05.R_24 */
                        R118 = RP19 /* \_SB_.PCI0.RP05.RP19 */
                        R119 = (RP19 + One)
                        R11A = RP1A /* \_SB_.PCI0.RP05.RP1A */
                        R11C = RP1C /* \_SB_.PCI0.RP05.RP1C */
                        R120 = R_20 /* \_SB_.PCI0.RP05.R_20 */
                        R124 = R_24 /* \_SB_.PCI0.RP05.R_24 */
                        R218 = R119 /* \_SB_.PCI0.RP05.R119 */
                        R219 = (R119 + One)
                        R21A = R11A /* \_SB_.PCI0.RP05.R11A */
                        R21C = R11C /* \_SB_.PCI0.RP05.R11C */
                        R220 = R120 /* \_SB_.PCI0.RP05.R120 */
                        R224 = R124 /* \_SB_.PCI0.RP05.R124 */
                        R318 = R119 /* \_SB_.PCI0.RP05.R119 */
                        R319 = (R119 + 0x02)
                        R31A = (R119 + 0x02)
                        R31C = Zero
                        R320 = Zero
                        R324 = Zero
                        R418 = R119 /* \_SB_.PCI0.RP05.R119 */
                        R419 = (R119 + 0x03)
                        R41A = (R119 + 0x03)
                        R41C = Zero
                        R420 = Zero
                        R424 = Zero
                        RVES = Zero
                        R518 = R119 /* \_SB_.PCI0.RP05.R119 */
                        R519 = (R119 + 0x04)
                        R51A = (R119 + 0x04)
                        R51C = Zero
                        R520 = Zero
                        R524 = Zero
                        R618 = Zero
                        R619 = Zero
                        R61A = Zero
                        R61C = Zero
                        R620 = Zero
                        R624 = Zero
                        RH10 = ((R220 & 0xFFFC) << 0x10)
                        RH14 = Zero
                        Sleep (One)
                        ICMB ()
                        Release (TCFG)
                    }
                    Else
                    {
                    }
                }

                Method (ICMB, 0, NotSerialized)
                {
                    TBTC (0x0D)
                    \_SB.TBFP (One, One)
                    Sleep (0x02F4)
                    Local0 = 0x08D0
                    Local1 = Timer
                    Local3 = Zero
                    While (Local0)
                    {
                        Local3 = UPCK ()
                        If ((Local3 == One))
                        {
                            DBG1 ("Upstream VID/DID okay")
                            Break
                        }
                        ElseIf ((Local0 == 0x07D0))
                        {
                            DBG1 ("Slow ICM boot !")
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((Local3 == Zero))
                    {
                        DBG1 ("Upstream VID/DID NOT OKAY")
                    }
                    Else
                    {
                        ICMS ()
                    }
                }

                Method (ICMS, 0, NotSerialized)
                {
                    \_SB.PCI0.RP05.POC0 = One
                    DBG2 ("ICME 1", \_SB.PCI0.RP05.ICME)
                    If ((\_SB.PCI0.RP05.ICME != 0x80000127))
                    {
                        If (\_SB.PCI0.RP05.CNHI ())
                        {
                            DBG2 ("ICME 2", \_SB.PCI0.RP05.ICME)
                            If ((\_SB.PCI0.RP05.ICME != 0xFFFFFFFF))
                            {
                                \_SB.PCI0.RP05.WTLT ()
                                \_SB.PCI0.RP05.ICME |= 0x06
                                DBG2 ("ICME 3", \_SB.PCI0.RP05.ICME)
                                Local0 = 0x03E8
                                While (((Local1 = (\_SB.PCI0.RP05.ICME & 0x80000000)) == Zero))
                                {
                                    Local0--
                                    If ((Local0 == Zero))
                                    {
                                        Break
                                    }

                                    Sleep (One)
                                }

                                Sleep (0x03E8)
                                DBG2 ("ICME 4", \_SB.PCI0.RP05.ICME)
                            }
                        }
                    }

                    \_SB.PCI0.RP05.POC0 = Zero
                }

                Method (TBTC, 1, Serialized)
                {
                    P2TR = Arg0
                    Local0 = 0x64
                    Local1 = T2PR /* \_SB_.PCI0.RP05.T2PR */
                    While (((Local2 = (Local1 & One)) == Zero))
                    {
                        If ((Local1 == 0xFFFFFFFF))
                        {
                            Return (Zero)
                        }

                        Local0--
                        If ((Local0 == Zero))
                        {
                            Break
                        }

                        Local1 = T2PR /* \_SB_.PCI0.RP05.T2PR */
                        Sleep (0x32)
                    }

                    P2TR = Zero
                }

                Method (CMPE, 0, Serialized)
                {
                    Notify (\_SB.PCI0.RP05, Zero) // Bus Check
                }

                Method (CNHI, 0, Serialized)
                {
                    Local0 = 0x0A
                    DBG1 ("Configure root")
                    While (Local0)
                    {
                        R_20 = R020 /* \_SB_.PCI0.RP05.R020 */
                        R_24 = R024 /* \_SB_.PCI0.RP05.R024 */
                        R_28 = R028 /* \_SB_.PCI0.RP05.R028 */
                        R_2C = R02C /* \_SB_.PCI0.RP05.R02C */
                        RPR4 = 0x07
                        If ((R020 == R_20))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((R020 != R_20))
                    {
                        Return (Zero)
                    }

                    DBG1 ("Configure UPSB")
                    Local0 = 0x0A
                    While (Local0)
                    {
                        UP18 = R118 /* \_SB_.PCI0.RP05.R118 */
                        UP19 = R119 /* \_SB_.PCI0.RP05.R119 */
                        UP1A = R11A /* \_SB_.PCI0.RP05.R11A */
                        UP1C = R11C /* \_SB_.PCI0.RP05.R11C */
                        UP20 = R120 /* \_SB_.PCI0.RP05.R120 */
                        UP24 = R124 /* \_SB_.PCI0.RP05.R124 */
                        UP28 = R128 /* \_SB_.PCI0.RP05.R128 */
                        UP2C = R12C /* \_SB_.PCI0.RP05.R12C */
                        UP04 = 0x07
                        If ((R119 == UP19))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((R119 != UP19))
                    {
                        Return (Zero)
                    }

                    DBG1 ("Wait for link training")
                    If ((WTLT () != One))
                    {
                        Return (Zero)
                    }

                    DBG1 ("Configure DSB")
                    Local0 = 0x0A
                    While (Local0)
                    {
                        DP18 = R218 /* \_SB_.PCI0.RP05.R218 */
                        DP19 = R219 /* \_SB_.PCI0.RP05.R219 */
                        DP1A = R21A /* \_SB_.PCI0.RP05.R21A */
                        DP1C = R21C /* \_SB_.PCI0.RP05.R21C */
                        DP20 = R220 /* \_SB_.PCI0.RP05.R220 */
                        DP24 = R224 /* \_SB_.PCI0.RP05.R224 */
                        DP28 = R228 /* \_SB_.PCI0.RP05.R228 */
                        DP2C = R22C /* \_SB_.PCI0.RP05.R22C */
                        DP04 = 0x07
                        D318 = R318 /* \_SB_.PCI0.RP05.R318 */
                        D319 = R319 /* \_SB_.PCI0.RP05.R319 */
                        D31A = R31A /* \_SB_.PCI0.RP05.R31A */
                        D31C = R31C /* \_SB_.PCI0.RP05.R31C */
                        D320 = R320 /* \_SB_.PCI0.RP05.R320 */
                        D324 = R324 /* \_SB_.PCI0.RP05.R324 */
                        D328 = R328 /* \_SB_.PCI0.RP05.R328 */
                        D32C = R32C /* \_SB_.PCI0.RP05.R32C */
                        D304 = 0x07
                        D418 = R418 /* \_SB_.PCI0.RP05.R418 */
                        D419 = R419 /* \_SB_.PCI0.RP05.R419 */
                        D41A = R41A /* \_SB_.PCI0.RP05.R41A */
                        D41C = R41C /* \_SB_.PCI0.RP05.R41C */
                        D420 = R420 /* \_SB_.PCI0.RP05.R420 */
                        D424 = R424 /* \_SB_.PCI0.RP05.R424 */
                        D428 = R428 /* \_SB_.PCI0.RP05.R428 */
                        D42C = R42C /* \_SB_.PCI0.RP05.R42C */
                        DVES = RVES /* \_SB_.PCI0.RP05.RVES */
                        D404 = 0x07
                        D518 = R518 /* \_SB_.PCI0.RP05.R518 */
                        D519 = R519 /* \_SB_.PCI0.RP05.R519 */
                        D51A = R51A /* \_SB_.PCI0.RP05.R51A */
                        D51C = R51C /* \_SB_.PCI0.RP05.R51C */
                        D520 = R520 /* \_SB_.PCI0.RP05.R520 */
                        D524 = R524 /* \_SB_.PCI0.RP05.R524 */
                        D528 = R528 /* \_SB_.PCI0.RP05.R528 */
                        D52C = R52C /* \_SB_.PCI0.RP05.R52C */
                        D504 = 0x07
                        If ((R219 == DP19))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    If ((R219 != DP19))
                    {
                        Return (Zero)
                    }

                    DBG1 ("Wait for down link")
                    If ((WTDL () != One))
                    {
                        Return (Zero)
                    }

                    DBG1 ("Configure NHI")
                    Local0 = 0x64
                    While (Local0)
                    {
                        NH10 = RH10 /* \_SB_.PCI0.RP05.RH10 */
                        NH14 = RH14 /* \_SB_.PCI0.RP05.RH14 */
                        NH04 = 0x07
                        If ((RH10 == NH10))
                        {
                            Break
                        }

                        Sleep (One)
                        Local0--
                    }

                    DBG2 ("NHI BAR", NH10)
                    If ((RH10 != NH10))
                    {
                        Return (Zero)
                    }

                    DBG1 ("CNHI done")
                    Return (One)
                }

                Method (UPCK, 0, Serialized)
                {
                    If (((UPVD & 0xFF00FFFF) == 0x15008086))
                    {
                        Return (One)
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Method (ULTC, 0, Serialized)
                {
                    If ((RPLT == Zero))
                    {
                        If ((UPLT == Zero))
                        {
                            Return (One)
                        }
                    }

                    Return (Zero)
                }

                Method (WTLT, 0, Serialized)
                {
                    Local0 = 0x07D0
                    Local1 = Zero
                    While (Local0)
                    {
                        If ((RPR4 == 0x07))
                        {
                            If (ULTC ())
                            {
                                If (UPCK ())
                                {
                                    Local1 = One
                                    Break
                                }
                            }
                        }

                        Sleep (One)
                        Local0--
                    }

                    Return (Local1)
                }

                Method (DLTC, 0, Serialized)
                {
                    If ((RPLT == Zero))
                    {
                        If ((UPLT == Zero))
                        {
                            If ((DPLT == Zero))
                            {
                                Return (One)
                            }
                        }
                    }

                    Return (Zero)
                }

                Method (WTDL, 0, Serialized)
                {
                    Local0 = 0x07D0
                    Local1 = Zero
                    While (Local0)
                    {
                        If ((RPR4 == 0x07))
                        {
                            If (DLTC ())
                            {
                                If (UPCK ())
                                {
                                    Local1 = One
                                    Break
                                }
                            }
                        }

                        Sleep (One)
                        Local0--
                    }

                    Return (Local1)
                }

                Name (IIP3, Zero)
                Name (PRSR, Zero)
                Name (PCIA, One)
                Method (PCEU, 0, Serialized)
                {
                    \_SB.PCI0.RP05.PRSR = Zero
                    If ((\_SB.PCI0.RP05.PSTA != Zero))
                    {
                        \_SB.PCI0.RP05.PRSR = One
                        \_SB.PCI0.RP05.PSTA = Zero
                    }

                    If ((\_SB.PCI0.RP05.LDXX == One))
                    {
                        \_SB.PCI0.RP05.PRSR = One
                        \_SB.PCI0.RP05.LDXX = Zero
                    }
                }

                Method (PCDA, 0, Serialized)
                {
                    If ((\_SB.PCI0.RP05.POFF () != Zero))
                    {
                        \_SB.PCI0.RP05.PCIA = Zero
                        \_SB.PCI0.RP05.PSTA = 0x03
                        \_SB.PCI0.RP05.LDXX = One
                        Local5 = (Timer + 0x00989680)
                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP05.LACR == One))
                            {
                                If ((\_SB.PCI0.RP05.LACT == Zero))
                                {
                                    Break
                                }
                            }
                            ElseIf ((\_SB.PCI0.RP05.UPSB.AVND == 0xFFFFFFFF))
                            {
                                Break
                            }

                            Sleep (0x0A)
                        }

                        \_SB.PCI0.RP05.GPCI = Zero
                        \_SB.PCI0.RP05.UGIO ()
                    }
                    Else
                    {
                    }

                    \_SB.PCI0.RP05.IIP3 = One
                }

                Method (POFF, 0, Serialized)
                {
                    Return ((!\_SB.PCI0.RP05.RTBT && !\_SB.PCI0.RP05.RUSB))
                }

                Name (GPCI, One)
                Name (GNHI, One)
                Name (GXCI, One)
                Name (RTBT, One)
                Name (RUSB, One)
                Name (CTPD, Zero)
                Method (CTBT, 0, Serialized)
                {
                    If ((\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF))
                    {
                        Local2 = \_SB.PCI0.RP05.UPSB.CRMW (0x3C, Zero, 0x02, 0x04000000, 0x04000000)
                        If ((Local2 == Zero))
                        {
                            \_SB.PCI0.RP05.CTPD = One
                        }
                    }
                }

                Method (UGIO, 0, Serialized)
                {
                    Local0 = (\_SB.PCI0.RP05.GNHI || \_SB.PCI0.RP05.RTBT)
                    Local1 = (\_SB.PCI0.RP05.GXCI || \_SB.PCI0.RP05.RUSB)
                    DBG3 ("UGIO", Local0, Local1)
                    If ((\_SB.PCI0.RP05.GPCI != Zero))
                    {
                        If (((Local0 == Zero) && (Local1 == Zero)))
                        {
                            Local0 = One
                            Local1 = One
                        }
                    }

                    Local2 = Zero
                    If ((Local0 != Zero))
                    {
                        If (Zero)
                        {
                            Local2 = One
                            \_SB.PCI0.RP05.CTPD = Zero
                        }
                    }

                    If ((Local1 != Zero))
                    {
                        If (Zero)
                        {
                            Local2 = One
                        }
                    }

                    If ((Local2 != Zero))
                    {
                        Sleep (0x01F4)
                    }

                    Local3 = Zero
                    If ((Local0 == Zero))
                    {
                        If (Zero)
                        {
                            \_SB.PCI0.RP05.CTBT ()
                            If ((\_SB.PCI0.RP05.CTPD != Zero))
                            {
                                Local3 = One
                            }
                        }
                    }

                    If ((Local1 == Zero))
                    {
                        If (Zero)
                        {
                            Local3 = One
                        }
                    }

                    If ((Local3 != Zero))
                    {
                        Sleep (0x64)
                    }

                    DBG3 ("UGIO finish", Local2, Local3)
                    Return (Local2)
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If (OSDW ())
                    {
                        PCEU ()
                    }
                }

                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    If (OSDW ())
                    {
                        If ((\_SB.PCI0.RP05.POFF () != Zero))
                        {
                            \_SB.PCI0.RP05.CTBT ()
                        }

                        PCDA ()
                    }
                }

                Method (UTLK, 2, Serialized)
                {
                    Local0 = Zero
                    If (Zero)
                    {
                        \_SB.PCI0.RP05.PSTA = Zero
                        While (One)
                        {
                            If ((\_SB.PCI0.RP05.LDXX == One))
                            {
                                \_SB.PCI0.RP05.LDXX = Zero
                            }

                            Local1 = Zero
                            Local2 = (Timer + 0x00989680)
                            While ((Timer <= Local2))
                            {
                                If ((\_SB.PCI0.RP05.LACR == Zero))
                                {
                                    If ((\_SB.PCI0.RP05.LTRN != One))
                                    {
                                        Break
                                    }
                                }
                                ElseIf (((\_SB.PCI0.RP05.LTRN != One) && (\_SB.PCI0.RP05.LACT == One)))
                                {
                                    Break
                                }

                                Sleep (0x0A)
                            }

                            Sleep (Arg1)
                            While ((Timer <= Local2))
                            {
                                If ((\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF))
                                {
                                    Local1 = One
                                    Break
                                }

                                Sleep (0x0A)
                            }

                            If ((Local1 == One))
                            {
                                \_SB.PCI0.RP05.MABT = One
                                Break
                            }

                            If ((Local0 == 0x04))
                            {
                                Break
                            }

                            Local0++
                            Sleep (0x03E8)
                        }
                    }
                }

                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32, 
                    BMIE,   3, 
                    Offset (0x18), 
                    PRIB,   8, 
                    SECB,   8, 
                    SUBB,   8, 
                    Offset (0x1E), 
                        ,   13, 
                    MABT,   1
                }

                OperationRegion (HD94, PCI_Config, 0x0D94, 0x08)
                Field (HD94, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    PLEQ,   1, 
                    Offset (0x08)
                }

                OperationRegion (A1E1, PCI_Config, 0x40, 0x40)
                Field (A1E1, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                    Offset (0x02), 
                    Offset (0x04), 
                    Offset (0x08), 
                    Offset (0x0A), 
                        ,   5, 
                    TPEN,   1, 
                    Offset (0x0C), 
                    SSPD,   4, 
                        ,   16, 
                    LACR,   1, 
                    Offset (0x10), 
                        ,   4, 
                    LDXX,   1, 
                    LRTN,   1, 
                    Offset (0x12), 
                    CSPD,   4, 
                    CWDT,   6, 
                        ,   1, 
                    LTRN,   1, 
                        ,   1, 
                    LACT,   1, 
                    Offset (0x14), 
                    Offset (0x30), 
                    TSPD,   4
                }

                OperationRegion (A1E2, PCI_Config, 0xA0, 0x08)
                Field (A1E2, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x01), 
                    Offset (0x02), 
                    Offset (0x04), 
                    PSTA,   2
                }

                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    Return (Zero)
                }

                Scope (PXSX)
                {
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (Zero)
                    }
                }

                Device (UPSB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                    Field (A1E0, ByteAcc, NoLock, Preserve)
                    {
                        AVND,   32, 
                        BMIE,   3, 
                        Offset (0x18), 
                        PRIB,   8, 
                        SECB,   8, 
                        SUBB,   8, 
                        Offset (0x1E), 
                            ,   13, 
                        MABT,   1
                    }

                    OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                    Field (A1E1, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                        Offset (0x02), 
                        Offset (0x04), 
                        Offset (0x08), 
                        Offset (0x0A), 
                            ,   5, 
                        TPEN,   1, 
                        Offset (0x0C), 
                        SSPD,   4, 
                            ,   16, 
                        LACR,   1, 
                        Offset (0x10), 
                            ,   4, 
                        LDIS,   1, 
                        LRTN,   1, 
                        Offset (0x12), 
                        CSPD,   4, 
                        CWDT,   6, 
                            ,   1, 
                        LTRN,   1, 
                            ,   1, 
                        LACT,   1, 
                        Offset (0x14), 
                        Offset (0x30), 
                        TSPD,   4
                    }

                    OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                    Field (A1E2, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                        Offset (0x02), 
                        Offset (0x04), 
                        PSTA,   2
                    }

                    Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                    {
                        Return (SECB) /* \_SB_.PCI0.RP05.UPSB.SECB */
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }

                    Method (PCED, 0, Serialized)
                    {
                        \_SB.PCI0.RP05.GPCI = One
                        If ((\_SB.PCI0.RP05.UGIO () != Zero))
                        {
                            \_SB.PCI0.RP05.PRSR = One
                        }

                        Local0 = Zero
                        Local1 = Zero
                        If ((Local1 == Zero))
                        {
                            If ((\_SB.PCI0.RP05.IIP3 != Zero))
                            {
                                \_SB.PCI0.RP05.PRSR = One
                                Local0 = One
                                \_SB.PCI0.RP05.LDXX = One
                            }
                        }

                        Local5 = (Timer + 0x00989680)
                        If ((\_SB.PCI0.RP05.PRSR != Zero))
                        {
                            Sleep (0x1E)
                            If (((Local0 != Zero) || (Local1 != Zero)))
                            {
                                \_SB.PCI0.RP05.TSPD = One
                                If ((Local1 != Zero)){}
                                ElseIf ((Local0 != Zero))
                                {
                                    \_SB.PCI0.RP05.LDXX = Zero
                                }

                                While ((Timer <= Local5))
                                {
                                    If ((\_SB.PCI0.RP05.LACR == Zero))
                                    {
                                        If ((\_SB.PCI0.RP05.LTRN != One))
                                        {
                                            Break
                                        }
                                    }
                                    ElseIf (((\_SB.PCI0.RP05.LTRN != One) && (\_SB.PCI0.RP05.LACT == One)))
                                    {
                                        Break
                                    }

                                    Sleep (0x0A)
                                }

                                Sleep (0x78)
                                While ((Timer <= Local5))
                                {
                                    If ((\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF))
                                    {
                                        Break
                                    }

                                    Sleep (0x0A)
                                }

                                \_SB.PCI0.RP05.TSPD = 0x03
                                \_SB.PCI0.RP05.LRTN = One
                            }

                            Local5 = (Timer + 0x00989680)
                            While ((Timer <= Local5))
                            {
                                If ((\_SB.PCI0.RP05.LACR == Zero))
                                {
                                    If ((\_SB.PCI0.RP05.LTRN != One))
                                    {
                                        Break
                                    }
                                }
                                ElseIf (((\_SB.PCI0.RP05.LTRN != One) && (\_SB.PCI0.RP05.LACT == One)))
                                {
                                    Break
                                }

                                Sleep (0x0A)
                            }

                            Sleep (0xFA)
                        }

                        \_SB.PCI0.RP05.PRSR = Zero
                        While ((Timer <= Local5))
                        {
                            If ((\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF))
                            {
                                Break
                            }

                            Sleep (0x0A)
                        }

                        If ((\_SB.PCI0.RP05.CSPD != 0x03))
                        {
                            If ((\_SB.PCI0.RP05.SSPD == 0x03))
                            {
                                If ((\_SB.PCI0.RP05.UPSB.SSPD == 0x03))
                                {
                                    If ((\_SB.PCI0.RP05.TSPD != 0x03))
                                    {
                                        \_SB.PCI0.RP05.TSPD = 0x03
                                    }

                                    If ((\_SB.PCI0.RP05.UPSB.TSPD != 0x03))
                                    {
                                        \_SB.PCI0.RP05.UPSB.TSPD = 0x03
                                    }

                                    \_SB.PCI0.RP05.LRTN = One
                                    Local2 = (Timer + 0x00989680)
                                    While ((Timer <= Local2))
                                    {
                                        If ((\_SB.PCI0.RP05.LACR == Zero))
                                        {
                                            If (((\_SB.PCI0.RP05.LTRN != One) && (\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF)))
                                            {
                                                \_SB.PCI0.RP05.PCIA = One
                                                Local1 = One
                                                Break
                                            }
                                        }
                                        ElseIf ((((\_SB.PCI0.RP05.LTRN != One) && (\_SB.PCI0.RP05.LACT == One)) && 
                                            (\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF)))
                                        {
                                            \_SB.PCI0.RP05.PCIA = One
                                            Local1 = One
                                            Break
                                        }

                                        Sleep (0x0A)
                                    }
                                }
                                Else
                                {
                                    \_SB.PCI0.RP05.PCIA = One
                                }
                            }
                            Else
                            {
                                \_SB.PCI0.RP05.PCIA = One
                            }
                        }
                        Else
                        {
                            \_SB.PCI0.RP05.PCIA = One
                        }

                        \_SB.PCI0.RP05.IIP3 = Zero
                    }

                    Method (AMPE, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.RP05.UPSB.DSB0.NHI0, Zero) // Bus Check
                    }

                    Method (UMPE, 0, Serialized)
                    {
                        Notify (\_SB.PCI0.RP05.UPSB.DSB2.XHC2, Zero) // Bus Check
                        Notify (\_SB.PCI0.XHC, Zero) // Bus Check
                    }

                    Name (MDUV, One)
                    Method (MUST, 1, Serialized)
                    {
                        DBG2 ("MUST", Arg0)
                        If (OSDW ())
                        {
                            If ((MDUV != Arg0))
                            {
                                MDUV = Arg0
                                UMPE ()
                            }
                        }

                        Return (Zero)
                    }

                    Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                    {
                        If (OSDW ())
                        {
                            PCED ()
                            \_SB.PCI0.RP05.UPSB.CRMW (0x013E, Zero, 0x02, 0x0200, 0x0200)
                            \_SB.PCI0.RP05.UPSB.CRMW (0x023E, Zero, 0x02, 0x0200, 0x0200)
                        }
                    }

                    Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                    {
                        If (!OSDW ())
                        {
                            If ((\_SB.PCI0.RP05.UPCK () == Zero))
                            {
                                \_SB.PCI0.RP05.UTLK (One, 0x03E8)
                            }

                            \_SB.PCI0.RP05.TBTC (0x05)
                        }
                    }

                    OperationRegion (H548, PCI_Config, 0x0548, 0x20)
                    Field (H548, DWordAcc, Lock, Preserve)
                    {
                        T2PC,   32, 
                        PC2T,   32
                    }

                    OperationRegion (H530, PCI_Config, 0x0530, 0x0C)
                    Field (H530, DWordAcc, Lock, Preserve)
                    {
                        DWIX,   13, 
                        PORT,   6, 
                        SPCE,   2, 
                        CMD0,   1, 
                        CMD1,   1, 
                        CMD2,   1, 
                            ,   6, 
                        PROG,   1, 
                        TMOT,   1, 
                        WDAT,   32, 
                        RDAT,   32
                    }

                    Method (CIOW, 4, Serialized)
                    {
                        WDAT = Arg3
                        DWIX = Arg0
                        PORT = Arg1
                        SPCE = Arg2
                        CMD0 = One
                        CMD1 = Zero
                        CMD2 = Zero
                        TMOT = Zero
                        PROG = One
                        Local1 = One
                        Local0 = 0x2710
                        While ((Zero < Local0))
                        {
                            If ((PROG == Zero))
                            {
                                Local1 = Zero
                                Break
                            }

                            Stall (0x19)
                            Local0--
                        }

                        If ((Local1 == Zero))
                        {
                            Local1 = TMOT /* \_SB_.PCI0.RP05.UPSB.TMOT */
                        }

                        Return (Local1)
                    }

                    Method (CIOR, 3, Serialized)
                    {
                        RDAT = Zero
                        DWIX = Arg0
                        PORT = Arg1
                        SPCE = Arg2
                        CMD0 = Zero
                        CMD1 = Zero
                        CMD2 = Zero
                        TMOT = Zero
                        PROG = One
                        Local1 = One
                        Local0 = 0x2710
                        While ((Zero < Local0))
                        {
                            If ((PROG == Zero))
                            {
                                Local1 = Zero
                                Break
                            }

                            Stall (0x19)
                            Local0--
                        }

                        If ((Local1 == Zero))
                        {
                            Local1 = TMOT /* \_SB_.PCI0.RP05.UPSB.TMOT */
                        }

                        If ((Local1 == Zero))
                        {
                            Return (Package (0x02)
                            {
                                Zero, 
                                RDAT
                            })
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                One, 
                                RDAT
                            })
                        }
                    }

                    Method (CRMW, 5, Serialized)
                    {
                        Local1 = One
                        If ((\_SB.PCI0.RP05.UPSB.AVND != 0xFFFFFFFF))
                        {
                            Local3 = Zero
                            While ((Local3 <= 0x04))
                            {
                                Local2 = CIOR (Arg0, Arg1, Arg2)
                                If ((DerefOf (Local2 [Zero]) == Zero))
                                {
                                    Local2 = DerefOf (Local2 [One])
                                    Local2 &= ~Arg4
                                    Local2 |= Arg3
                                    Local2 = CIOW (Arg0, Arg1, Arg2, Local2)
                                    If ((Local2 == Zero))
                                    {
                                        Local2 = CIOR (Arg0, Arg1, Arg2)
                                        If ((DerefOf (Local2 [Zero]) == Zero))
                                        {
                                            Local2 = DerefOf (Local2 [One])
                                            Local2 &= Arg4
                                            If ((Local2 == Arg3))
                                            {
                                                Local1 = Zero
                                                Break
                                            }
                                        }
                                    }
                                }

                                Local3++
                                Sleep (0x64)
                            }
                        }

                        DBG3 ("CRMW", Arg0, Local1)
                        Return (Local1)
                    }

                    Method (LSTX, 2, Serialized)
                    {
                        If ((T2PC != 0xFFFFFFFF))
                        {
                            Local0 = Zero
                            If (((T2PC & One) && One))
                            {
                                Local0 = One
                            }

                            If ((Local0 == Zero))
                            {
                                Local1 = 0x2710
                                While ((Zero < Local1))
                                {
                                    If ((T2PC == Zero))
                                    {
                                        Break
                                    }

                                    Stall (0x19)
                                    Local1--
                                }

                                If ((Zero == Local1))
                                {
                                    Local0 = One
                                }
                            }

                            If ((Local0 == Zero))
                            {
                                Local1 = One
                                Local1 |= 0x14
                                Local1 |= (Arg0 << 0x08)
                                Local1 |= (Arg1 << 0x0C)
                                Local1 |= 0x00400000
                                PC2T = Local1
                            }

                            If ((Local0 == Zero))
                            {
                                Local1 = 0x2710
                                While ((Zero < Local1))
                                {
                                    If ((T2PC == 0x15))
                                    {
                                        Break
                                    }

                                    Stall (0x19)
                                    Local1--
                                }

                                If ((Zero == Local1))
                                {
                                    Local0 = One
                                }
                            }

                            PC2T = Zero
                        }
                    }

                    Device (DSB0)
                    {
                        Name (_ADR, Zero)  // _ADR: Address
                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                        Field (A1E0, ByteAcc, NoLock, Preserve)
                        {
                            AVND,   32, 
                            BMIE,   3, 
                            Offset (0x18), 
                            PRIB,   8, 
                            SECB,   8, 
                            SUBB,   8, 
                            Offset (0x1E), 
                                ,   13, 
                            MABT,   1
                        }

                        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                        Field (A1E1, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            Offset (0x08), 
                            Offset (0x0A), 
                                ,   5, 
                            TPEN,   1, 
                            Offset (0x0C), 
                            SSPD,   4, 
                                ,   16, 
                            LACR,   1, 
                            Offset (0x10), 
                                ,   4, 
                            LDIS,   1, 
                            LRTN,   1, 
                            Offset (0x12), 
                            CSPD,   4, 
                            CWDT,   6, 
                                ,   1, 
                            LTRN,   1, 
                                ,   1, 
                            LACT,   1, 
                            Offset (0x14), 
                            Offset (0x30), 
                            TSPD,   4
                        }

                        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                        Field (A1E2, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            PSTA,   2
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB0.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Name (IIP3, Zero)
                        Name (PRSR, Zero)
                        Name (PCIA, One)
                        Method (PCEU, 0, Serialized)
                        {
                            \_SB.PCI0.RP05.UPSB.DSB0.PRSR = Zero
                            If ((\_SB.PCI0.RP05.UPSB.DSB0.PSTA != Zero))
                            {
                                \_SB.PCI0.RP05.UPSB.DSB0.PRSR = One
                                \_SB.PCI0.RP05.UPSB.DSB0.PSTA = Zero
                            }

                            If ((\_SB.PCI0.RP05.UPSB.DSB0.LDIS == One))
                            {
                                \_SB.PCI0.RP05.UPSB.DSB0.PRSR = One
                                \_SB.PCI0.RP05.UPSB.DSB0.LDIS = Zero
                            }
                        }

                        Method (PCDA, 0, Serialized)
                        {
                            If ((\_SB.PCI0.RP05.UPSB.DSB0.POFF () != Zero))
                            {
                                \_SB.PCI0.RP05.UPSB.DSB0.PCIA = Zero
                                \_SB.PCI0.RP05.UPSB.DSB0.PSTA = 0x03
                                \_SB.PCI0.RP05.UPSB.DSB0.LDIS = One
                                Local5 = (Timer + 0x00989680)
                                While ((Timer <= Local5))
                                {
                                    If ((\_SB.PCI0.RP05.UPSB.DSB0.LACR == One))
                                    {
                                        If ((\_SB.PCI0.RP05.UPSB.DSB0.LACT == Zero))
                                        {
                                            Break
                                        }
                                    }
                                    ElseIf ((\_SB.PCI0.RP05.UPSB.DSB0.NHI0.AVND == 0xFFFFFFFF))
                                    {
                                        Break
                                    }

                                    Sleep (0x0A)
                                }

                                \_SB.PCI0.RP05.GNHI = Zero
                                \_SB.PCI0.RP05.UGIO ()
                            }
                            Else
                            {
                            }

                            \_SB.PCI0.RP05.UPSB.DSB0.IIP3 = One
                        }

                        Method (POFF, 0, Serialized)
                        {
                            Return (!\_SB.PCI0.RP05.RTBT)
                        }

                        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                        {
                            If (OSDW ())
                            {
                                PCEU ()
                            }
                        }

                        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                        {
                            If (OSDW ())
                            {
                                PCDA ()
                            }
                        }

                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            If (OSDW ())
                            {
                                If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
                                {
                                    Local0 = Package (0x02)
                                        {
                                            "PCIHotplugCapable", 
                                            Zero
                                        }
                                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                    Return (Local0)
                                }
                            }

                            Return (Zero)
                        }

                        Device (NHI0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Name (_STR, Unicode ("Thunderbolt"))  // _STR: Description String
                            Method (PCED, 0, Serialized)
                            {
                                \_SB.PCI0.RP05.GNHI = One
                                If ((\_SB.PCI0.RP05.UGIO () != Zero))
                                {
                                    \_SB.PCI0.RP05.UPSB.DSB0.PRSR = One
                                }

                                Local0 = Zero
                                Local1 = Zero
                                Local5 = (Timer + 0x00989680)
                                If ((\_SB.PCI0.RP05.UPSB.DSB0.PRSR != Zero))
                                {
                                    Local5 = (Timer + 0x00989680)
                                    While ((Timer <= Local5))
                                    {
                                        If ((\_SB.PCI0.RP05.UPSB.DSB0.LACR == Zero))
                                        {
                                            If ((\_SB.PCI0.RP05.UPSB.DSB0.LTRN != One))
                                            {
                                                Break
                                            }
                                        }
                                        ElseIf (((\_SB.PCI0.RP05.UPSB.DSB0.LTRN != One) && (\_SB.PCI0.RP05.UPSB.DSB0.LACT == One)))
                                        {
                                            Break
                                        }

                                        Sleep (0x0A)
                                    }

                                    Sleep (0x96)
                                }

                                \_SB.PCI0.RP05.UPSB.DSB0.PRSR = Zero
                                While ((Timer <= Local5))
                                {
                                    If ((\_SB.PCI0.RP05.UPSB.DSB0.NHI0.AVND != 0xFFFFFFFF))
                                    {
                                        \_SB.PCI0.RP05.UPSB.DSB0.PCIA = One
                                        Break
                                    }

                                    Sleep (0x0A)
                                }

                                \_SB.PCI0.RP05.UPSB.DSB0.IIP3 = Zero
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                Return (Zero)
                            }

                            OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                            Field (A1E0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   32, 
                                BMIE,   3, 
                                Offset (0x10), 
                                BAR1,   32, 
                                Offset (0x18), 
                                PRIB,   8, 
                                SECB,   8, 
                                SUBB,   8, 
                                Offset (0x1E), 
                                    ,   13, 
                                MABT,   1
                            }

                            Method (RTPC, 1, Serialized)
                            {
                                If (OSDW ())
                                {
                                    If ((Arg0 <= One))
                                    {
                                        \_SB.PCI0.RP05.RTBT = Arg0
                                    }
                                }

                                Return (Zero)
                            }

                            Method (MUST, 1, Serialized)
                            {
                                Return (\_SB.PCI0.RP05.UPSB.MUST (Arg0))
                            }

                            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                            {
                                If (OSDW ())
                                {
                                    PCED ()
                                    \_SB.PCI0.RP05.CTBT ()
                                }
                            }

                            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                            {
                            }

                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If (OSDW ())
                                {
                                    Local0 = Package (0x11)
                                        {
                                            "AAPL,slot-name", 
                                            Buffer (0x07)
                                            {
                                                "Slot-4"
                                            }, 

                                            "name", 
                                            Buffer (0x24)
                                            {
                                                "Alpine Ridge Thunderbolt Controller"
                                            }, 

                                            "model", 
                                            Buffer (0x2D)
                                            {
                                                "Intel JHL6540 Alpine Ridge Thunderbolt 3 NHI"
                                            }, 

                                            "device_type", 
                                            Buffer (0x17)
                                            {
                                                "Thunderbolt-Controller"
                                            }, 

                                            "ThunderboltDROM", 
                                            Buffer (0x72)
                                            {
                                                /* 0000 */  0x88, 0x00, 0x11, 0x11, 0x11, 0x11, 0x11, 0x00,  // ........
                                                /* 0008 */  0x00, 0xBA, 0x65, 0x6A, 0xDB, 0x01, 0x58, 0x00,  // ..ej..X.
                                                /* 0010 */  0x01, 0x00, 0x0D, 0x00, 0x01, 0x00, 0x08, 0x81,  // ........
                                                /* 0018 */  0x80, 0x02, 0x80, 0x00, 0x00, 0x00, 0x08, 0x82,  // ........
                                                /* 0020 */  0x90, 0x01, 0x80, 0x00, 0x00, 0x00, 0x08, 0x83,  // ........
                                                /* 0028 */  0x80, 0x04, 0x80, 0x01, 0x00, 0x00, 0x08, 0x84,  // ........
                                                /* 0030 */  0x90, 0x03, 0x80, 0x01, 0x00, 0x00, 0x02, 0x85,  // ........
                                                /* 0038 */  0x0B, 0x86, 0x20, 0x01, 0x00, 0x64, 0x00, 0x00,  // .. ..d..
                                                /* 0040 */  0x00, 0x00, 0x00, 0x03, 0x87, 0x80, 0x05, 0x88,  // ........
                                                /* 0048 */  0x50, 0x40, 0x00, 0x05, 0x89, 0x50, 0x00, 0x00,  // P@...P..
                                                /* 0050 */  0x05, 0x8A, 0x50, 0x00, 0x00, 0x05, 0x8B, 0x50,  // ..P....P
                                                /* 0058 */  0x40, 0x00, 0x07, 0x01, 0x41, 0x53, 0x55, 0x53,  // @...ASUS
                                                /* 0060 */  0x00, 0x11, 0x02, 0x54, 0x48, 0x55, 0x4E, 0x44,  // ...THUND
                                                /* 0068 */  0x45, 0x52, 0x42, 0x4F, 0x4C, 0x54, 0x45, 0x58,  // ERBOLTEX
                                                /* 0070 */  0x33, 0x00                                       // 3.
                                            }, 

                                            "ThunderboltConfig", 
                                            Buffer (0x20)
                                            {
                                                /* 0000 */  0x00, 0x02, 0xFF, 0xFF, 0x0C, 0x00, 0x07, 0x01,  // ........
                                                /* 0008 */  0x01, 0x00, 0x0A, 0x00, 0x07, 0x01, 0x02, 0x00,  // ........
                                                /* 0010 */  0x0B, 0x00, 0x07, 0x01, 0x01, 0x00, 0x0D, 0x00,  // ........
                                                /* 0018 */  0x07, 0x01, 0x02, 0x00, 0x01, 0x00, 0x02, 0x00   // ........
                                            }, 

                                            "linkDetails", 
                                            Buffer (0x08)
                                            {
                                                 0x08, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00   // ........
                                            }, 

                                            "power-save", 
                                            One, 
                                            Buffer (One)
                                            {
                                                 0x00                                             // .
                                            }
                                        }
                                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                    Return (Local0)
                                }

                                Return (Zero)
                            }

                            Method (SXFP, 1, Serialized)
                            {
                                DBG2 ("SXFP", Arg0)
                                If ((Arg0 == Zero)){}
                            }
                        }
                    }

                    Device (DSB1)
                    {
                        Name (_ADR, 0x00010000)  // _ADR: Address
                        Name (_SUN, One)  // _SUN: Slot User Number
                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                        Field (A1E0, ByteAcc, NoLock, Preserve)
                        {
                            AVND,   32, 
                            BMIE,   3, 
                            Offset (0x18), 
                            PRIB,   8, 
                            SECB,   8, 
                            SUBB,   8, 
                            Offset (0x1E), 
                                ,   13, 
                            MABT,   1
                        }

                        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                        Field (A1E1, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            Offset (0x08), 
                            Offset (0x0A), 
                                ,   5, 
                            TPEN,   1, 
                            Offset (0x0C), 
                            SSPD,   4, 
                                ,   16, 
                            LACR,   1, 
                            Offset (0x10), 
                                ,   4, 
                            LDIS,   1, 
                            LRTN,   1, 
                            Offset (0x12), 
                            CSPD,   4, 
                            CWDT,   6, 
                                ,   1, 
                            LTRN,   1, 
                                ,   1, 
                            LACT,   1, 
                            Offset (0x14), 
                            Offset (0x30), 
                            TSPD,   4
                        }

                        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                        Field (A1E2, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            PSTA,   2
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Device (UPS0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                            Field (ARE0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   16
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                If (OSDW ())
                                {
                                    Return (One)
                                }

                                Return (Zero)
                            }

                            Device (DSB0)
                            {
                                Name (_ADR, Zero)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1, 
                                    Offset (0x3E), 
                                        ,   6, 
                                    SBRS,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB0.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        If (OSDW ())
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB3)
                            {
                                Name (_ADR, 0x00030000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB3.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }

                                Device (UPS0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                                    Field (ARE0, ByteAcc, NoLock, Preserve)
                                    {
                                        AVND,   16
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        If (OSDW ())
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }

                                    Device (DSB0)
                                    {
                                        Name (_ADR, Zero)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1, 
                                            Offset (0x3E), 
                                                ,   6, 
                                            SBRS,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB3.UPS0.DSB0.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }
                                        }
                                    }

                                    Device (DSB3)
                                    {
                                        Name (_ADR, 0x00030000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB3.UPS0.DSB3.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB4)
                                    {
                                        Name (_ADR, 0x00040000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB3.UPS0.DSB4.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB5)
                                    {
                                        Name (_ADR, 0x00050000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB3.UPS0.DSB5.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }

                                    Device (DSB6)
                                    {
                                        Name (_ADR, 0x00060000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB3.UPS0.DSB6.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }
                                }
                            }

                            Device (DSB4)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB4.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }

                                Device (UPS0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                                    Field (ARE0, ByteAcc, NoLock, Preserve)
                                    {
                                        AVND,   16
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        If (OSDW ())
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }

                                    Device (DSB0)
                                    {
                                        Name (_ADR, Zero)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1, 
                                            Offset (0x3E), 
                                                ,   6, 
                                            SBRS,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB4.UPS0.DSB0.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB3)
                                    {
                                        Name (_ADR, 0x00030000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB4.UPS0.DSB3.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB4)
                                    {
                                        Name (_ADR, 0x00040000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB4.UPS0.DSB4.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB5)
                                    {
                                        Name (_ADR, 0x00050000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB4.UPS0.DSB5.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }

                                    Device (DSB6)
                                    {
                                        Name (_ADR, 0x00060000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB4.UPS0.DSB6.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }
                                }
                            }

                            Device (DSB5)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB5.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }

                            Device (DSB6)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB1.UPS0.DSB6.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }
                        }
                    }

                    Device (DSB2)
                    {
                        Name (_ADR, 0x00020000)  // _ADR: Address
                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                        Field (A1E0, ByteAcc, NoLock, Preserve)
                        {
                            AVND,   32, 
                            BMIE,   3, 
                            Offset (0x18), 
                            PRIB,   8, 
                            SECB,   8, 
                            SUBB,   8, 
                            Offset (0x1E), 
                                ,   13, 
                            MABT,   1
                        }

                        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                        Field (A1E1, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            Offset (0x08), 
                            Offset (0x0A), 
                                ,   5, 
                            TPEN,   1, 
                            Offset (0x0C), 
                            SSPD,   4, 
                                ,   16, 
                            LACR,   1, 
                            Offset (0x10), 
                                ,   4, 
                            LDIS,   1, 
                            LRTN,   1, 
                            Offset (0x12), 
                            CSPD,   4, 
                            CWDT,   6, 
                                ,   1, 
                            LTRN,   1, 
                                ,   1, 
                            LACT,   1, 
                            Offset (0x14), 
                            Offset (0x30), 
                            TSPD,   4
                        }

                        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                        Field (A1E2, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            PSTA,   2
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB2.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Name (IIP3, Zero)
                        Name (PRSR, Zero)
                        Name (PCIA, One)
                        Method (PCEU, 0, Serialized)
                        {
                            \_SB.PCI0.RP05.UPSB.DSB2.PRSR = Zero
                            If ((\_SB.PCI0.RP05.UPSB.DSB2.PSTA != Zero))
                            {
                                \_SB.PCI0.RP05.UPSB.DSB2.PRSR = One
                                \_SB.PCI0.RP05.UPSB.DSB2.PSTA = Zero
                            }

                            If ((\_SB.PCI0.RP05.UPSB.DSB2.LDIS == One))
                            {
                                \_SB.PCI0.RP05.UPSB.DSB2.PRSR = One
                                \_SB.PCI0.RP05.UPSB.DSB2.LDIS = Zero
                            }
                        }

                        Method (PCDA, 0, Serialized)
                        {
                            If ((\_SB.PCI0.RP05.UPSB.DSB2.POFF () != Zero))
                            {
                                \_SB.PCI0.RP05.UPSB.DSB2.PCIA = Zero
                                \_SB.PCI0.RP05.UPSB.DSB2.PSTA = 0x03
                                \_SB.PCI0.RP05.UPSB.DSB2.LDIS = One
                                Local5 = (Timer + 0x00989680)
                                While ((Timer <= Local5))
                                {
                                    If ((\_SB.PCI0.RP05.UPSB.DSB2.LACR == One))
                                    {
                                        If ((\_SB.PCI0.RP05.UPSB.DSB2.LACT == Zero))
                                        {
                                            Break
                                        }
                                    }
                                    ElseIf ((\_SB.PCI0.RP05.UPSB.DSB2.XHC2.AVND == 0xFFFFFFFF))
                                    {
                                        Break
                                    }

                                    Sleep (0x0A)
                                }

                                \_SB.PCI0.RP05.GXCI = Zero
                                \_SB.PCI0.RP05.UGIO ()
                            }
                            Else
                            {
                            }

                            \_SB.PCI0.RP05.UPSB.DSB2.IIP3 = One
                        }

                        Method (POFF, 0, Serialized)
                        {
                            Return (!\_SB.PCI0.RP05.RUSB)
                        }

                        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                        {
                            If (OSDW ())
                            {
                                PCEU ()
                            }
                        }

                        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                        {
                            If (OSDW ())
                            {
                                PCDA ()
                            }
                        }

                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            If (OSDW ())
                            {
                                If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
                                {
                                    Local0 = Package (0x02)
                                        {
                                            "PCIHotplugCapable", 
                                            Zero
                                        }
                                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                    Return (Local0)
                                }
                            }

                            Return (Zero)
                        }

                        Device (XHC2)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Name (SDPC, Zero)
                            OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                            Field (A1E0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   32, 
                                BMIE,   3, 
                                Offset (0x18), 
                                PRIB,   8, 
                                SECB,   8, 
                                SUBB,   8, 
                                Offset (0x1E), 
                                    ,   13, 
                                MABT,   1
                            }

                            Method (PCED, 0, Serialized)
                            {
                                \_SB.PCI0.RP05.GXCI = One
                                If ((\_SB.PCI0.RP05.UGIO () != Zero))
                                {
                                    \_SB.PCI0.RP05.UPSB.DSB2.PRSR = One
                                }

                                Local0 = Zero
                                Local1 = Zero
                                Local5 = (Timer + 0x00989680)
                                If ((\_SB.PCI0.RP05.UPSB.DSB2.PRSR != Zero))
                                {
                                    Local5 = (Timer + 0x00989680)
                                    While ((Timer <= Local5))
                                    {
                                        If ((\_SB.PCI0.RP05.UPSB.DSB2.LACR == Zero))
                                        {
                                            If ((\_SB.PCI0.RP05.UPSB.DSB2.LTRN != One))
                                            {
                                                Break
                                            }
                                        }
                                        ElseIf (((\_SB.PCI0.RP05.UPSB.DSB2.LTRN != One) && (\_SB.PCI0.RP05.UPSB.DSB2.LACT == One)))
                                        {
                                            Break
                                        }

                                        Sleep (0x0A)
                                    }

                                    Sleep (0x96)
                                }

                                \_SB.PCI0.RP05.UPSB.DSB2.PRSR = Zero
                                While ((Timer <= Local5))
                                {
                                    If ((\_SB.PCI0.RP05.UPSB.DSB2.XHC2.AVND != 0xFFFFFFFF))
                                    {
                                        \_SB.PCI0.RP05.UPSB.DSB2.PCIA = One
                                        Break
                                    }

                                    Sleep (0x0A)
                                }

                                \_SB.PCI0.RP05.UPSB.DSB2.IIP3 = Zero
                            }

                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If ((U2OP == One))
                                {
                                    Local0 = Package (0x06)
                                        {
                                            "USBBusNumber", 
                                            Zero, 
                                            "AAPL,xhci-clock-id", 
                                            One, 
                                            "UsbCompanionControllerPresent", 
                                            One
                                        }
                                }
                                Else
                                {
                                    Local0 = Package (0x04)
                                        {
                                            "USBBusNumber", 
                                            Zero, 
                                            "AAPL,xhci-clock-id", 
                                            One
                                        }
                                }

                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }

                            Name (HS, Package (0x01)
                            {
                                "XHC"
                            })
                            Name (FS, Package (0x01)
                            {
                                "XHC"
                            })
                            Name (LS, Package (0x01)
                            {
                                "XHC"
                            })
                            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                            {
                                If (OSDW ())
                                {
                                    Return (Package (0x02)
                                    {
                                        0x6D, 
                                        0x04
                                    })
                                }
                                Else
                                {
                                    Return (Package (0x02)
                                    {
                                        0x6D, 
                                        0x03
                                    })
                                }
                            }

                            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                            {
                                If (OSDW ())
                                {
                                    PCED ()
                                }
                            }

                            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                            {
                            }

                            Method (RTPC, 1, Serialized)
                            {
                                If (OSDW ())
                                {
                                    If ((Arg0 <= One))
                                    {
                                        \_SB.PCI0.RP05.RUSB = Arg0
                                    }
                                }

                                Return (Zero)
                            }

                            Method (MODU, 0, Serialized)
                            {
                                Return (\_SB.PCI0.RP05.UPSB.MDUV)
                            }

                            Device (RHUB)
                            {
                                Name (_ADR, Zero)  // _ADR: Address
                                Device (HS01)
                                {
                                    Name (_ADR, One)  // _ADR: Address
                                    Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                                    {
                                        0xFF, 
                                        0x09, 
                                        Zero, 
                                        Zero
                                    })
                                    Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                                    {
                                        ToPLD (
                                            PLD_Revision           = 0x1,
                                            PLD_IgnoreColor        = 0x1,
                                            PLD_Red                = 0x0,
                                            PLD_Green              = 0x0,
                                            PLD_Blue               = 0x0,
                                            PLD_Width              = 0x0,
                                            PLD_Height             = 0x0,
                                            PLD_UserVisible        = 0x1,
                                            PLD_Dock               = 0x0,
                                            PLD_Lid                = 0x0,
                                            PLD_Panel              = "UNKNOWN",
                                            PLD_VerticalPosition   = "UPPER",
                                            PLD_HorizontalPosition = "LEFT",
                                            PLD_Shape              = "UNKNOWN",
                                            PLD_GroupOrientation   = 0x0,
                                            PLD_GroupToken         = 0x0,
                                            PLD_GroupPosition      = 0x0,
                                            PLD_Bay                = 0x0,
                                            PLD_Ejectable          = 0x0,
                                            PLD_EjectRequired      = 0x0,
                                            PLD_CabinetNumber      = 0x0,
                                            PLD_CardCageNumber     = 0x0,
                                            PLD_Reference          = 0x0,
                                            PLD_Rotation           = 0x0,
                                            PLD_Order              = 0x0,
                                            PLD_VerticalOffset     = 0x0,
                                            PLD_HorizontalOffset   = 0x0)

                                    })
                                    Name (SSP, Package (0x02)
                                    {
                                        "XHC2", 
                                        0x03
                                    })
                                    Name (SS, Package (0x02)
                                    {
                                        "XHC2", 
                                        0x03
                                    })
                                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                                    {
                                        Local0 = Package (0x04)
                                            {
                                                "kUSBWakePortCurrentLimit", 
                                                0x0BB8, 
                                                "kUSBSleepPortCurrentLimit", 
                                                0x0BB8
                                            }
                                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                        Return (Local0)
                                    }
                                }

                                Device (HS02)
                                {
                                    Name (_ADR, 0x02)  // _ADR: Address
                                    Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                                    {
                                        0xFF, 
                                        0x09, 
                                        Zero, 
                                        Zero
                                    })
                                    Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                                    {
                                        ToPLD (
                                            PLD_Revision           = 0x1,
                                            PLD_IgnoreColor        = 0x1,
                                            PLD_Red                = 0x0,
                                            PLD_Green              = 0x0,
                                            PLD_Blue               = 0x0,
                                            PLD_Width              = 0x0,
                                            PLD_Height             = 0x0,
                                            PLD_UserVisible        = 0x1,
                                            PLD_Dock               = 0x0,
                                            PLD_Lid                = 0x0,
                                            PLD_Panel              = "UNKNOWN",
                                            PLD_VerticalPosition   = "UPPER",
                                            PLD_HorizontalPosition = "LEFT",
                                            PLD_Shape              = "UNKNOWN",
                                            PLD_GroupOrientation   = 0x0,
                                            PLD_GroupToken         = 0x0,
                                            PLD_GroupPosition      = 0x0,
                                            PLD_Bay                = 0x0,
                                            PLD_Ejectable          = 0x0,
                                            PLD_EjectRequired      = 0x0,
                                            PLD_CabinetNumber      = 0x0,
                                            PLD_CardCageNumber     = 0x0,
                                            PLD_Reference          = 0x0,
                                            PLD_Rotation           = 0x0,
                                            PLD_Order              = 0x0,
                                            PLD_VerticalOffset     = 0x0,
                                            PLD_HorizontalOffset   = 0x0)

                                    })
                                    Name (SSP, Package (0x02)
                                    {
                                        "XHC2", 
                                        0x04
                                    })
                                    Name (SS, Package (0x02)
                                    {
                                        "XHC2", 
                                        0x04
                                    })
                                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                                    {
                                        Local0 = Package (0x04)
                                            {
                                                "kUSBWakePortCurrentLimit", 
                                                0x0BB8, 
                                                "kUSBSleepPortCurrentLimit", 
                                                0x0BB8
                                            }
                                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                        Return (Local0)
                                    }
                                }

                                Device (SSP1)
                                {
                                    Name (_ADR, 0x03)  // _ADR: Address
                                    Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                                    {
                                        0xFF, 
                                        0x09, 
                                        Zero, 
                                        Zero
                                    })
                                    Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                                    {
                                        ToPLD (
                                            PLD_Revision           = 0x1,
                                            PLD_IgnoreColor        = 0x1,
                                            PLD_Red                = 0x0,
                                            PLD_Green              = 0x0,
                                            PLD_Blue               = 0x0,
                                            PLD_Width              = 0x0,
                                            PLD_Height             = 0x0,
                                            PLD_UserVisible        = 0x1,
                                            PLD_Dock               = 0x0,
                                            PLD_Lid                = 0x0,
                                            PLD_Panel              = "UNKNOWN",
                                            PLD_VerticalPosition   = "UPPER",
                                            PLD_HorizontalPosition = "LEFT",
                                            PLD_Shape              = "UNKNOWN",
                                            PLD_GroupOrientation   = 0x0,
                                            PLD_GroupToken         = 0x0,
                                            PLD_GroupPosition      = 0x0,
                                            PLD_Bay                = 0x0,
                                            PLD_Ejectable          = 0x0,
                                            PLD_EjectRequired      = 0x0,
                                            PLD_CabinetNumber      = 0x0,
                                            PLD_CardCageNumber     = 0x0,
                                            PLD_Reference          = 0x0,
                                            PLD_Rotation           = 0x0,
                                            PLD_Order              = 0x0,
                                            PLD_VerticalOffset     = 0x0,
                                            PLD_HorizontalOffset   = 0x0)

                                    })
                                    Name (HS, Package (0x02)
                                    {
                                        "XHC", 
                                        One
                                    })
                                    Name (FS, Package (0x02)
                                    {
                                        "XHC", 
                                        One
                                    })
                                    Name (LS, Package (0x02)
                                    {
                                        "XHC", 
                                        One
                                    })
                                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                                    {
                                        If ((U2OP == One))
                                        {
                                            Local0 = Package (0x0A)
                                                {
                                                    "UsbCPortNumber", 
                                                    One, 
                                                    "UsbPowerSource", 
                                                    One, 
                                                    "kUSBWakePortCurrentLimit", 
                                                    0x0BB8, 
                                                    "kUSBSleepPortCurrentLimit", 
                                                    0x0BB8, 
                                                    "UsbCompanionPortPresent", 
                                                    One
                                                }
                                        }
                                        Else
                                        {
                                            Local0 = Package (0x08)
                                                {
                                                    "UsbCPortNumber", 
                                                    One, 
                                                    "UsbPowerSource", 
                                                    One, 
                                                    "kUSBWakePortCurrentLimit", 
                                                    0x0BB8, 
                                                    "kUSBSleepPortCurrentLimit", 
                                                    0x0BB8
                                                }
                                        }

                                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                        Return (Local0)
                                    }
                                }

                                Device (SSP2)
                                {
                                    Name (_ADR, 0x04)  // _ADR: Address
                                    Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                                    {
                                        0xFF, 
                                        0x09, 
                                        Zero, 
                                        Zero
                                    })
                                    Name (_PLD, Package (0x01)  // _PLD: Physical Location of Device
                                    {
                                        ToPLD (
                                            PLD_Revision           = 0x1,
                                            PLD_IgnoreColor        = 0x1,
                                            PLD_Red                = 0x0,
                                            PLD_Green              = 0x0,
                                            PLD_Blue               = 0x0,
                                            PLD_Width              = 0x0,
                                            PLD_Height             = 0x0,
                                            PLD_UserVisible        = 0x1,
                                            PLD_Dock               = 0x0,
                                            PLD_Lid                = 0x0,
                                            PLD_Panel              = "UNKNOWN",
                                            PLD_VerticalPosition   = "UPPER",
                                            PLD_HorizontalPosition = "LEFT",
                                            PLD_Shape              = "UNKNOWN",
                                            PLD_GroupOrientation   = 0x0,
                                            PLD_GroupToken         = 0x0,
                                            PLD_GroupPosition      = 0x0,
                                            PLD_Bay                = 0x0,
                                            PLD_Ejectable          = 0x0,
                                            PLD_EjectRequired      = 0x0,
                                            PLD_CabinetNumber      = 0x0,
                                            PLD_CardCageNumber     = 0x0,
                                            PLD_Reference          = 0x0,
                                            PLD_Rotation           = 0x0,
                                            PLD_Order              = 0x0,
                                            PLD_VerticalOffset     = 0x0,
                                            PLD_HorizontalOffset   = 0x0)

                                    })
                                    Name (HS, Package (0x02)
                                    {
                                        "XHC", 
                                        0x02
                                    })
                                    Name (FS, Package (0x02)
                                    {
                                        "XHC", 
                                        0x02
                                    })
                                    Name (LS, Package (0x02)
                                    {
                                        "XHC", 
                                        0x02
                                    })
                                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                                    {
                                        If ((U2OP == One))
                                        {
                                            Local0 = Package (0x0A)
                                                {
                                                    "UsbCPortNumber", 
                                                    0x02, 
                                                    "UsbPowerSource", 
                                                    0x02, 
                                                    "kUSBWakePortCurrentLimit", 
                                                    0x0BB8, 
                                                    "kUSBSleepPortCurrentLimit", 
                                                    0x0BB8, 
                                                    "UsbCompanionPortPresent", 
                                                    One
                                                }
                                        }
                                        Else
                                        {
                                            Local0 = Package (0x0A)
                                                {
                                                    "UsbCPortNumber", 
                                                    0x02, 
                                                    "UsbPowerSource", 
                                                    0x02, 
                                                    "kUSBWakePortCurrentLimit", 
                                                    0x0BB8, 
                                                    "kUSBSleepPortCurrentLimit", 
                                                    0x0BB8, 
                                                    "UsbCompanionPortPresent", 
                                                    Zero
                                                }
                                        }

                                        DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                        Return (Local0)
                                    }
                                }
                            }
                        }
                    }

                    Device (DSB4)
                    {
                        Name (_ADR, 0x00040000)  // _ADR: Address
                        Name (_SUN, 0x02)  // _SUN: Slot User Number
                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                        Field (A1E0, ByteAcc, NoLock, Preserve)
                        {
                            AVND,   32, 
                            BMIE,   3, 
                            Offset (0x18), 
                            PRIB,   8, 
                            SECB,   8, 
                            SUBB,   8, 
                            Offset (0x1E), 
                                ,   13, 
                            MABT,   1
                        }

                        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                        Field (A1E1, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            Offset (0x08), 
                            Offset (0x0A), 
                                ,   5, 
                            TPEN,   1, 
                            Offset (0x0C), 
                            SSPD,   4, 
                                ,   16, 
                            LACR,   1, 
                            Offset (0x10), 
                                ,   4, 
                            LDIS,   1, 
                            LRTN,   1, 
                            Offset (0x12), 
                            CSPD,   4, 
                            CWDT,   6, 
                                ,   1, 
                            LTRN,   1, 
                                ,   1, 
                            LACT,   1, 
                            Offset (0x14), 
                            Offset (0x30), 
                            TSPD,   4
                        }

                        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                        Field (A1E2, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            PSTA,   2
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Device (UPS0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                            Field (ARE0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   16
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                If (OSDW ())
                                {
                                    Return (One)
                                }

                                Return (Zero)
                            }

                            Device (DSB0)
                            {
                                Name (_ADR, Zero)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1, 
                                    Offset (0x3E), 
                                        ,   6, 
                                    SBRS,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB0.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        If (OSDW ())
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }
                                }
                            }

                            Device (DSB3)
                            {
                                Name (_ADR, 0x00030000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB3.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }

                                Device (UPS0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                                    Field (ARE0, ByteAcc, NoLock, Preserve)
                                    {
                                        AVND,   16
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        If (OSDW ())
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }

                                    Device (DSB0)
                                    {
                                        Name (_ADR, Zero)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1, 
                                            Offset (0x3E), 
                                                ,   6, 
                                            SBRS,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB3.UPS0.DSB0.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }
                                        }
                                    }

                                    Device (DSB3)
                                    {
                                        Name (_ADR, 0x00030000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB3.UPS0.DSB3.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB4)
                                    {
                                        Name (_ADR, 0x00040000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB3.UPS0.DSB4.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB5)
                                    {
                                        Name (_ADR, 0x00050000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB3.UPS0.DSB5.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }

                                    Device (DSB6)
                                    {
                                        Name (_ADR, 0x00060000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB3.UPS0.DSB6.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }
                                }
                            }

                            Device (DSB4)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB4.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }

                                Device (UPS0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                                    Field (ARE0, ByteAcc, NoLock, Preserve)
                                    {
                                        AVND,   16
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        If (OSDW ())
                                        {
                                            Return (One)
                                        }

                                        Return (Zero)
                                    }

                                    Device (DSB0)
                                    {
                                        Name (_ADR, Zero)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1, 
                                            Offset (0x3E), 
                                                ,   6, 
                                            SBRS,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB4.UPS0.DSB0.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB3)
                                    {
                                        Name (_ADR, 0x00030000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB4.UPS0.DSB3.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB4)
                                    {
                                        Name (_ADR, 0x00040000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB4.UPS0.DSB4.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                If (OSDW ())
                                                {
                                                    Return (One)
                                                }

                                                Return (Zero)
                                            }
                                        }
                                    }

                                    Device (DSB5)
                                    {
                                        Name (_ADR, 0x00050000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB4.UPS0.DSB5.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }

                                    Device (DSB6)
                                    {
                                        Name (_ADR, 0x00060000)  // _ADR: Address
                                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                        Field (A1E0, ByteAcc, NoLock, Preserve)
                                        {
                                            AVND,   32, 
                                            BMIE,   3, 
                                            Offset (0x18), 
                                            PRIB,   8, 
                                            SECB,   8, 
                                            SUBB,   8, 
                                            Offset (0x1E), 
                                                ,   13, 
                                            MABT,   1
                                        }

                                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                        {
                                            Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB4.UPS0.DSB6.SECB */
                                        }

                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            If (OSDW ())
                                            {
                                                Return (One)
                                            }

                                            Return (Zero)
                                        }
                                    }
                                }
                            }

                            Device (DSB5)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB5.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }

                            Device (DSB6)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
                                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                                Field (A1E0, ByteAcc, NoLock, Preserve)
                                {
                                    AVND,   32, 
                                    BMIE,   3, 
                                    Offset (0x18), 
                                    PRIB,   8, 
                                    SECB,   8, 
                                    SUBB,   8, 
                                    Offset (0x1E), 
                                        ,   13, 
                                    MABT,   1
                                }

                                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                                {
                                    Return (SECB) /* \_SB_.PCI0.RP05.UPSB.DSB4.UPS0.DSB6.SECB */
                                }

                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    If (OSDW ())
                                    {
                                        Return (One)
                                    }

                                    Return (Zero)
                                }
                            }
                        }
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (OSDW ())
                        {
                            If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
                            {
                                Local0 = Package (0x02)
                                    {
                                        "PCI-Thunderbolt", 
                                        One
                                    }
                                DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                                Return (Local0)
                            }
                        }

                        Return (Zero)
                    }
                }
            }

            Name (RP15.PXSX._STA, Zero)  // _STA: Status
            Device (RP15.SDXC)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Scope (LPCB)
            {
                Device (EC)
                {
                    Name (_HID, "ACID0001")  // _HID: Hardware ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }

                Device (PMCR)
                {
                    Name (_HID, EisaId ("APP9876"))  // _HID: Hardware ID
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadWrite,
                            0xFE000000,         // Address Base
                            0x00010000,         // Address Length
                            )
                    })
                }
            }
        }
    }

    Method (_SB.PCI0.XDCI._STA, 0, NotSerialized)  // _STA: Status
    {
        If ((DVID != 0xFFFF))
        {
            Return (0x0F)
        }
        Else
        {
            Return (Zero)
        }
    }

    Method (DTGP, 5, NotSerialized)
    {
        If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
        {
            If ((Arg1 == One))
            {
                If ((Arg2 == Zero))
                {
                    Arg4 = Buffer (One)
                        {
                             0x03                                             // .
                        }
                    Return (One)
                }

                If ((Arg2 == One))
                {
                    Return (One)
                }
            }
        }

        Arg4 = Buffer (One)
            {
                 0x00                                             // .
            }
        Return (Zero)
    }

    Scope (\)
    {
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                STAS = One
            }
        }

        Method (OSDW, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (One)
            }

            Return (Zero)
        }
    }

    Device (RMDT)
    {
        Name (_HID, "RMD0000")  // _HID: Hardware ID
        Name (RING, Package (0x0100){})
        Mutex (RTMX, 0x00)
        Name (HEAD, Zero)
        Name (TAIL, Zero)
        Method (PUSH, 1, NotSerialized)
        {
            Acquire (RTMX, 0xFFFF)
            Local0 = (HEAD + One)
            If ((Local0 >= SizeOf (RING)))
            {
                Local0 = Zero
            }

            If ((Local0 != TAIL))
            {
                RING [HEAD] = Arg0
                HEAD = Local0
            }

            Release (RTMX)
            Notify (RMDT, 0x80) // Status Change
        }

        Method (FTCH, 0, NotSerialized)
        {
            Acquire (RTMX, 0xFFFF)
            Local0 = Zero
            If ((HEAD != TAIL))
            {
                Local0 = DerefOf (RING [TAIL])
                TAIL++
                If ((TAIL >= SizeOf (RING)))
                {
                    TAIL = Zero
                }
            }

            Release (RTMX)
            Return (Local0)
        }

        Method (COUN, 0, NotSerialized)
        {
            Acquire (RTMX, 0xFFFF)
            Local0 = (HEAD - TAIL) /* \RMDT.TAIL */
            If ((Local0 < Zero))
            {
                Local0 += SizeOf (RING)
            }

            Release (RTMX)
            Return (Local0)
        }

        Method (P1, 1, NotSerialized)
        {
            PUSH (Arg0)
        }

        Method (P2, 2, Serialized)
        {
            Name (TEMP, Package (0x02){})
            TEMP [Zero] = Arg0
            TEMP [One] = Arg1
            PUSH (TEMP)
        }

        Method (P3, 3, Serialized)
        {
            Name (TEMP, Package (0x03){})
            TEMP [Zero] = Arg0
            TEMP [One] = Arg1
            TEMP [0x02] = Arg2
            PUSH (TEMP)
        }

        Method (P4, 4, Serialized)
        {
            Name (TEMP, Package (0x04){})
            TEMP [Zero] = Arg0
            TEMP [One] = Arg1
            TEMP [0x02] = Arg2
            TEMP [0x03] = Arg3
            PUSH (TEMP)
        }

        Method (P5, 5, Serialized)
        {
            Name (TEMP, Package (0x05){})
            TEMP [Zero] = Arg0
            TEMP [One] = Arg1
            TEMP [0x02] = Arg2
            TEMP [0x03] = Arg3
            TEMP [0x04] = Arg4
            PUSH (TEMP)
        }

        Method (P6, 6, Serialized)
        {
            Name (TEMP, Package (0x06){})
            TEMP [Zero] = Arg0
            TEMP [One] = Arg1
            TEMP [0x02] = Arg2
            TEMP [0x03] = Arg3
            TEMP [0x04] = Arg4
            TEMP [0x05] = Arg5
            PUSH (TEMP)
        }

        Method (P7, 7, Serialized)
        {
            Name (TEMP, Package (0x07){})
            TEMP [Zero] = Arg0
            TEMP [One] = Arg1
            TEMP [0x02] = Arg2
            TEMP [0x03] = Arg3
            TEMP [0x04] = Arg4
            TEMP [0x05] = Arg5
            TEMP [0x06] = Arg6
            PUSH (TEMP)
        }
    }
}

