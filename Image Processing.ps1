for($x = 0; $x -le 18999; $x += 4) {
	Copy-Item "$x.png" -Destination "output\$x.png"
}

for($x = 1; $x -le 18999; $x += 4) {
	$RAND1 = ((1 .. 11 | Get-Random) - 6)
	magick "$x.png" -filter Cubic -resize 512x480! -resize 256x240! -brightness-contrast $RAND1 -quality 70 "output\$x.jpeg"
}

for($x = 2; $x -le 18999; $x += 4) {
	$RAND0 = (5 .. 10 | Get-Random)
	$RAND1 = (384 .. 640 | Get-Random)
	$RAND2 = ((-1, 1 | Get-Random)*(5 .. 10 | Get-Random))
	$RAND3 = ((-1, 1 | Get-Random)*(5 .. 10 | Get-Random))
	magick -size 256x240 xc: +noise Random -colorspace LinearGray -alpha set -channel A +level "0,$($RAND0)%" +channel "temp\noise$x.png"
	magick "$x.png" -filter cubic -resize 512x480! -resize 256x240! -resize "$($RAND1)x480!" -resize 256x240! -brightness-contrast "$($RAND2)x$($RAND3)" "temp\$x.png"
	magick "temp\$x.png" "temp\noise$x.png" -gravity center -compose over -composite -quality 70 "output\$x.jpeg"
	
	Remove-Item "temp\noise$x.png"
	Remove-Item "temp\$x.png"
}

for($x = 3; $x -le 18999; $x += 4) {
	$RAND0 = (10 .. 20 | Get-Random)
	$RAND1 = (240 .. 256 | Get-Random)
	$RAND2 = (224 .. 240 | Get-Random)
	$RAND3 = ((-1, 1 | Get-Random)*(10 .. 20 | Get-Random))
	$RAND4 = ((-1, 1 | Get-Random)*(10 .. 20 | Get-Random))
	$RAND5 = (0 .. 255 | Get-Random)
	$RAND6 = (0 .. 239 | Get-Random)
	$RAND7 = (0 .. 255 | Get-Random)
	$RAND8 = (0 .. 239 | Get-Random)
	magick -size 256x240 xc: +noise Random -colorspace LinearGray -alpha set -channel A +level "0,$($RAND0)%" +channel "temp\noise$x.png"
	magick -size 256x240 xc: -sparse-color barycentric "$($RAND5),$($RAND6) white  $($RAND7),$($RAND8) black" -alpha set -channel A +level "0,10%" +channel "temp\gradient$x.png"
	magick "$x.png" -filter cubic -resize "$($RAND1)x$($RAND2)!" -resize 256x240! -resize "512x480!" -resize 256x240! -brightness-contrast "$($RAND3)x$($RAND4)" "temp\$x.png"
	magick "temp\$x.png" "temp\noise$x.png" -gravity center -compose over -composite "temp\temp$x.png"
	magick "temp\temp$x.png" "temp\gradient$x.png" -gravity center -compose over -composite -quality 50 "output\$x.jpeg"
	
	Remove-Item "temp\noise$x.png"
	Remove-Item "temp\gradient$x.png"
	Remove-Item "temp\$x.png"
	Remove-Item "temp\temp$x.png"
}