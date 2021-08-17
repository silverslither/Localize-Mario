# Localize-Mario
Repo containing scripts and code used to generate artificial training info for localizing Mario.
This is used to aid FibidyDibity's project in which he aims to combine the entire https://www.speedrun.com/smb1/ leaderboard into one video.
# Usage (For Windows)
Using FCEUX, obtain a movie file of a speedrun of NES Super Mario Bros., and dump an avi file.
When doing so, make sure to run ```localize.lua``` to save localization info.
This will not work if you have placed ```localize.lua``` in a protected folder, such as a subdirectory of ```C:\Program Files\```.
After doing so, remove the first line of the text file, as that is a redundant frame 0 and rename the text file for organization.
I have discovered an issue in which the lagframe following the ```Start``` press on the title screen where Mario disappears still registers Mario as onscreen, and that would have to be manually corrected.

Afterwards, open a PowerShell window in the directory containing the files and run the ffmpeg command corresponding to your output (you can find the commands in ```powershell-scripts.txt```. For small movies that output just one AVI file, simply run the ffmpeg command. For large movies with more than one AVI file, create a text file named ```input.txt``` in the same dir, with the following contents:
```
file [Drive]:\path\to\file\input.avi
file [Drive]:\path\to\file\input_part2.avi
.
.
.
```
Make sure it is encoded in UTF-8 (or ASCII, haven't tested that tho) and run the ffmpeg command.
You can change ```DIR``` to anything you want for organization.

Warning: For very large movies with 6-digit or higher framecounts, change ```%05d.png``` to ```%06d.png``` or similar.

Since ffmpeg outputs 5-digit filenames, we need to remove leading zeroes. 
To do that, we can run several PowerShell scripts consecutively (You can do it with one command but I'm not good with PowerShell, this gets the job done), which are located in the same file as the ffmpeg commands.

For large movies with 6-digit framecounts, add an extra script at the beginning:
```
Get-ChildItem . -File -Filter "0?????.png" |
ForEach-Object {
	Rename-Item $_.FullName $($_.Name -replace '0+(?=\d\d\d\d\d)', '')
}
```
Now that you have the image files, you can remove the dumped AVI files.

To process the images, run each GIMP script (Copy + Paste) once in Filters > Script-Fu > Console, and change ```NUM``` to ceil((the number of total images)/4).
If the number of images is not an even multiple of 4, GIMP might throw an error at the end. Simply ignore it.

What you should now have is a folder containing the images, and a text file. 
You can combine multiple movies using the Increment File Name PowerShell script, and by incrementing the first number at the start of every line in the text file and combining two text files (idk how to do that yet, search it up yourself).
For the PowerShell script, change ```INC``` to the length of the previous movie(s).

Note that the output images all have .png extensions, however the majority are actually encoded with JPEG. It shouldn't matter too much, however it is important to know. 
You can verify whether an image is a PNG or a JPEG by checking to see if it is a Very High Quality image, or using a hex editor.
