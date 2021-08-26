Get-ChildItem . -File -Filter "0????.png" |
ForEach-Object {
	Rename-Item $_.FullName $($_.Name -replace '0+(?=\d\d\d\d)', '')
}

Get-ChildItem . -File -Filter "0???.png" |
ForEach-Object {
	Rename-Item $_.FullName $($_.Name -replace '0+(?=\d\d\d)', '')
}

Get-ChildItem . -File -Filter "0??.png" |
ForEach-Object {
	Rename-Item $_.FullName $($_.Name -replace '0+(?=\d\d)', '')
}

Get-ChildItem . -File -Filter "0?.png" |
ForEach-Object {
	Rename-Item $_.FullName $($_.Name -replace '0+(?=\d)', '')
}