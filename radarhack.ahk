﻿#Include classMemory.ahk

setbatchlines -1
Process, Wait, csgo.exe
csgo := new _ClassMemory("ahk_exe csgo.exe", "", hProcessCopy)
if !IsObject(csgo)
{
if (hProcessCopy = "")
msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten
msgbox A_LastError %A_LastError%
ExitApp
}

base := csgo.getModuleBaseAddress("client.dll")

Pattern := [0x74, 0x15, 0x8B, 0x47, 0x08, 0x8D, 0x4F, 0x08]
 
addres := csgo.modulePatternScan("client.dll", Pattern*)
offsetradarhack := (addres - base) - 1
 
F10::
t := !t

Data := t
Size := 1

VarSetCapacity(Buf, Size, 0)
NumPut(Data, Buf, "Uchar")

csgo.writeRaw(base + offsetradarhack, &Buf, Size)
return