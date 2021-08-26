# Localize-Mario
Repo containing scripts and code used to generate artificial training info for localizing Mario, as well as the camera position.
This is used to aid FibidyDibity's project in which he aims to combine the entire https://www.speedrun.com/smb1/ leaderboard into one video.
# Prerequisites
Windows 7 or above (preferably Windows 10)

Windows PowerShell: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell

FFmpeg: https://www.wikihow.com/Install-FFmpeg-on-Windows

ImageMagick: https://imagemagick.org/script/download.php

# Usage (For Windows)
Using FCEUX, obtain a movie file of a speedrun of NES Super Mario Bros. (with a 5-digit framecount!), and dump an avi file.
Also run both ```localize.lua``` and ```camera.lua``` to save localization info.
This will not work if you have placed ```localize.lua``` or ```camera.lua``` in a protected folder, such as a subdirectory of ```C:\Program Files\```.
After doing so, remove the first line of the ```localize.lua``` output, as that is a redundant frame 0, remove the frames up to the first frame of 1-1 in the ```camera.lua``` output, and rename the text files for organization.
I have discovered an issue in which the lagframe following the ```Start``` press on the title screen where Mario disappears still registers Mario as onscreen, and that would have to be manually corrected.

Afterwards, open a PowerShell window in the directory containing the files and run the ffmpeg command corresponding to your output (you can find the commands in ```FFmpeg Commands.ps1```.
For small movies that output just one AVI file, run the first ffmpeg command. For large movies with more than one AVI file, create a text file named ```input.txt``` in the same dir, with the following contents:
```
file [Drive]:\path\to\file\input.avi
file [Drive]:\path\to\file\input_part2.avi
.
.
.
```
Make sure it is encoded in UTF-8 (or ASCII, haven't tested that tho) and run the second ffmpeg command.
You can change ```DIR``` to anything you want for organization.

You may notice that the first frame is named ```1.png```, not ```0.png```. Simply copy a black frame and rename it to ```0.png```.

Since ffmpeg outputs 5-digit filenames, we need to remove leading zeroes. 
To do that, we can run ```Remove Leading Zeros.ps1```

Now that you have the image files, you can remove the dumped AVI files.

To process the images, create two folders inside the folder containing the images named ```output``` and ```temp```, and run ```Image Processing.ps1```, replacing ```NUM``` at the start of each script with the largest image index. In the end, you should have the same amount of images in ```output``` as outside it.

You may move ```output``` as well as the localization info to a safe location, and delete the folder originally containing it (make sure nothing important is there!)

What you should now have is a folder containing the images, and two text files. 
You can combine multiple movies using the Increment File Name PowerShell script, and by incrementing the first number at the start of every line in the text file and combining two text files (idk how to do that yet, search it up yourself).
For the PowerShell script, change ```INC``` to the length of the previous movie(s).
