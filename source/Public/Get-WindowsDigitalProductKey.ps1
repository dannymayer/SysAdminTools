# TODO: Fix formatting
# TODO: Paramatize function
Function ConvertToKey($Key) {
	$Keyoffset = 52
	$IsWin8 = [int]($Key[66] / 6) -band 1
	$HF7 = 0xF7
	$Key[66] = ($Key[66] -band $HF7) -bOr (($IsWin8 -band 2) * 4)
	$i = 24
	[String]$Chars = "BCDFGHJKMPQRTVWXY2346789"
	Do {
		$Cur = 0
		$X = 14
		Do {
			$Cur = $Cur * 256
			$Cur = $Key[$X + $Keyoffset] + $Cur
			$Key[$X + $Keyoffset] = [math]::Floor([double]($Cur / 24))
			$Cur = $Cur % 24
			$X = $X - 1
		}While ($X -ge 0)
		$i = $i - 1
		$KeyOutput = $Chars.SubString($Cur, 1) + $KeyOutput
		$Last = $Cur
	}While ($i -ge 0)
	$Keypart1 = $KeyOutput.SubString(1, $Last)
	$Keypart2 = $KeyOutput.Substring(1, $KeyOutput.length - 1)

	If ($Last -eq 0 ) {
		$KeyOutput = "N" + $Keypart2
	}
	Else {
		$KeyOutput = $Keypart2.Insert($Keypart2.IndexOf($Keypart1) + $Keypart1.length, "N")
	}

	$KeyProduct = ""
	For ($i = 0; $i -le 24; $i++) {
		$KeyProduct = $KeyProduct + $KeyOutput[$i] 
		If ((($i + 1) % 5 -eq 0) -and ($i -ne 0) -and ($i -le 20) ) {
			$KeyProduct = $KeyProduct + "-"
		}
	}
	return $KeyProduct
}
$rawProductId = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -name DigitalProductId
$productKey = ConvertToKey $rawProductId.DigitalProductId
Write-Output $productKey