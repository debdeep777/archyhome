Maintained using indentation folding and searched using the headings.
Settings have to be applied to this file only using vim -S TODOsettings.vim

# Folding Help:
 
  zi 	switch folding on or off
 * za 	toggle current fold open/closed
   zc 	close current fold
 * zR 	open all folds
 * zM 	close all folds
   zv 	expand folds to reveal cursor
  
 * zj,zk	jumps to the next/previous fold, even when unfolded
   zo,(zO)	open fold (recursively)
   zc,(zC)	closefold (recursively)
 * zA	toggle folds recursively
  
Folding Options (Should change in TODOsettings.vim file to make it permanent.)
 set foldnestmax=10      "deepest fold is 10 levels
 set nofoldenable        "dont fold by default
 set foldlevel=1         "this is just what i use
 set shiftwidth=1 	to consider spaces as one foldlevel away
 
Searching Help:

```
:set foldopen-=search  		"to stop folds from opening on search, which is even better.
:folddoopen s/old/new/ge 	"to replace old with new in the lines which are not folded. 
```


Warning: 
 Smartindent is on, hence use <F2> before pasting into it.
 
Want: 
 Not more than 2 stages of folding
 Search within the visible folded text
 Search within the invisible text inside folds
 INdent = on
 
# Install Broadcom WiFi Driver and restart to get internet access.
 
  
# Goto terminal and install:
 
 sudo apt-get install unetbootin gparted linuxdcpp ffmpeg libavcodec-extra-52 vim tree openssh-server default-jre
 
 * tree
 * vim
 * vlc
 * ubuntu studio theme (sudo apt-get install ubuntustudio-theme ubuntustudio-icon-theme ubuntustudio-wallpapers ubuntustudio-gdm-theme)
 * latexpdf (sudo apt-get install textlive-latex-base)
 * Limewire, Frostwire
 * Vuze {
 	INSTALL JAVA FIRST: sudo apt-get install default-jre
 	Then install vuze from anywhere (package manager/terminal/website)
 	(For total manual installation, see http://forlong.blogage.de/en/entries/2008/12/2/How-to-install-and-update-Vuze-formerly-Azureus-4-on-Ubuntu
 NOTE: A modification to be done in the tutorial given above: To add vuze to the menu, you need to create a file named vuze.desktop. Create the file in the location /usr/share/applications instead of /usr/local/share/application)
 	}
 * Others: Creox, bb
  
# Create a startup script to mount Hard disk drives:
 
  * Goto /media/ and create 3 directories called "windows", "disk3", storage".
 	cd /media/
 	sudo mkdir windows disk3 storage
  * Create a file named "mounting" with following content:
 
 ##startup script to mount the disk drives
 sudo mount /dev/sda1 /media/windows
 sudo mount /dev/sda3 /media/disk3
 sudo mount /dev/sda5 /media/storage
 #EOF
 
  * Change file permission to +x:
 	chmod +x mounting
  * Copy the file to /etc/init.d/:
 	sudo cp mounting /etc/init.d/
  * Update:
 	sudo update-rc.d mounting defaults
 
# Enable Visual Effects:
 
 * Enable Wobbly Windows
 * Enable Shift Switcher (Cover) and Change Shortcut to <Ctrl>+<Tab> for next window and <Ctrl>+<Shift>+<Tab> for previous window.
 
# Installing sound driver:
 
 * In terminal, write: sudo gedit /etc/modprobe.d/alsa-base.conf
 * In the end of the file, add this line: options snd-hda-intel model=6stack-dell (For that dell studio 1435)
 options snd-hda-intel model=ideapad (For lenovo ideapad Z560)
 * Save the file and Reboot.
 * Open pulse audio and enjoy full features.
 
# Recording sound from output stream:
 
 * Open pulse audio, goto Volume control > Input Devices > Show: Monitors. You will see the bar responding to the output sound.
 * Click on the green tick sign to "Set as Fallback"
 * Open sound Recorder and record.
 
# Converting media:
 
 sudo apt-get install ffmpeg libavcodec-extra-52 ( optional: libavcodec-unstripped-52 or libavcodec-unstripped-51)
 ffmpeg -i samjho\ na.flv -vn -ar 44100 -ab 128k -f mp3 samjho\ na.mp3
 
 ffmpeg -i Scorpions\ -\ Believe\ In\ Love.mp4 -ab 128k -ar 44100 -b 200k -r 20 -s 640x480 -aspect 4:3 -f avi BIL.avi
 follow somuda's blog: soumyashantnayak.blogspot.com

## mp4 encoding for mac and incorrect color in subsequent gif 
			
Mac computers cannot plot mp4 files that are generated from png files. So, we use the following encoding instead.
```
ffmpeg -i pacman_%3d.png -pix_fmt yuv420p vid4.mp4
```

* If the starting number in the input sequence is not 1, specify it using `-start_number <num>` before the `-i` option like this:
```
ffmpeg -start_number 50 -i pacman_%3d.png -pix_fmt yuv420p vid4.mp4
```


Next, convert the output mp4 to gif to get correct color reproduction using
```
ffmpeg -i vid4.mp4 vid4.gif
```

## Use `-crf` along with framerate `-r` to produce smaller video
* Larger the framerate, bigger the video (good range 20-28)
* Larger the `crf` smaller the video (good range 20-30)
 
# Printing:
 
 to know the printer names attached to your computer: lpstat -v
 to make one of the printers the default one: lpoptions -d <printer_name>
 (sometimes this step is necessary)
 for printing files, use the syntax: lpr -P <printer_name> <filename>
 	the output will be of the format: device for <printer_name>: <device>
 Printing to PDF:
 	lpstat -P Print_to_PDF filename	(Here, by default, the printer name is Print_to_PDF)
 (Note: Sometimes, it produces blank pages i.e. does not print anything. In that case, delete the printer from Menu> Printing and add a generic cpus:/ printer with the name Print_to_PDF (If you want to use that name at all))
 
# IP and hostname resolution
 
 List hostnames and ips:
 arp -a
 avahi-browse -a
 For IP <---> Hostname, use resolveip: 
 resolveip IP/Hostname
 
 Sometimes, one way: IP --> Host: 
 host ip_address
 but most of the time this fails due to the DNS server, I think.
 For IP <--- Host, nslookup:
 nslookup host
 This also does not work for internal hosts.
 
# Live ports:
 
 Know the live ports of your OWN hosts, and the connected ips:
 sudo netstat -tpan
 
 Know if a particluar port is open or not in a remote host:
 nmap -p port host/ip
 
```
 nmap --script=smb-enum-users 192.168.2.167 -p 445|perl -le 'while(<STDIN>){if(/^.*?\\(\w+)\s+.*/) { print "$1"; }}'
```
 
# Boot from LiveCD iso using GRUB:
 
 Add this to /boot/grub/grub.cfg in proper place with proper modification:
 
 menuentry "Booting ISO" {
  insmod part_msdos
  insmod ntfs
  set root='(hd0,msdos6)'
  loopback loop /new/liveDVDmint/ubuntu-11.10-desktop-i386.iso
  linux (loop)/casper/vmlinuz boot=casper iso-scan/filename=/new/liveDVDmint/ubuntu-11.10-desktop-i386.iso noeject noprompt --
  initrd (loop)/casper/initrd.lz
 }
 
 The command "set root='(hd0,msdos6)'" is equivalent to mounting the 6th partition of the zero-th hard disk as root (/). The command 'insmod' is still unknown to me but the 2nd line (insmod ntfs) tells that the partition type is ntfs. The path name after "loopback loop" tells the location of the iso.
 The Last 2 lines are enough to resurrect any linux system with a kernel image (in this case, vmlinuz) and a ramdisk (initrd). Define their relative locations and you are good to go. For different distro, the location and names of kernel and initrd are different. Website says, this piece of code is enough to boot a linux:
 menuentry "My custom Linux" {
 set root=(hd0,5)
 linux /boot/vmlinuz
 initrd /boot/initrd.img
 }
 This is NOT tested. If does not work, then Maybe the the options are needed to be changed.
 
 For Windows, instead of kernel and initrd, use "chainloader +1" after defining root. A standard grub.cfg file is a good example.
 
 
# Handy Commands:
 
 See the size of partitions: 
 	df -h  
 		(-h stands for human-readable. It applies to 'ls' too)
 See the dependency of a package: 
 	apt-cache depends <package name>
 See the packages which are depndent on a package (reverse-dependency)
 	apt-get rdepends <package-name>
 Search for a package or metapackage: 	
 	aptitude search <search_string>
 See the list of open files:
 	lsof
 
# Manually download Flash Videos:
 
 (i)   Visit the YouTube video and wait for it to be downloaded fully.
     Then, run from the command line the command "lsof -n | grep Flash" which shows the files (even memory files!), and filters to those that have Flash in their name.
     You get something like "plugin-co 2461 user 17u REG 8,5 1693301 524370 /tmp/FlashXXVkHEM6 (deleted)".
 
     In Linux, if a file is deleted, it is actually gone only when all programs that opened it earlier are closed. That is, the Flash plugin is using a trick to hide the /tmp/FlashXXVkHEM6 file. It creates it and immediately deletes it. But since the Flash plugin keeps running, it can apparently still use it.
 
 (ii)   From the above line we note the number 2461, which is the process ID. In your case it will be probably different. Then, run "cd /proc/2461/fd" and finally execute "ls -l". This will show you the memory files, and specifically "lrwx------ 1 user user 64 2011-09-16 10:23 17 -> /tmp/FlashXXVkHEM6 (deleted)". The number 17 (in my case) is the filename you can use to access the deleted /tmp/FlashXXVkHEM6. Therefore, simply run "cp 17 /tmp/myyoutubevideo.flv" and you restore the Youtube Video!
 
 
# Peforming xserver activities through tty or remote ssh shells:
 
 After logging in, set the DISPLAY variable to :0.0 or to :0 or any other if necessary (which can be found by issuing w command and looking at the "from" field)
 
 export DISPLAY=:0.0
 
 Then  issue your commands like you do in the terminal.
 
 Note: apparently you cannot run a gui program in other user's tty even by setting the DISPLAY to the user's tty.
 
# Simple GTK pop-ups:
 
 First export DISPLAY 
 There is a software called zenity that'll do your work. See zenity --help for more options. Example:
 
 zenity --info --text "hello there!"
 
# Send messages to other users in terminal:
 
 The "wall" command will  post the strings followed to ALL logged-in user's terminal. Example:
 
 wall
 hi there
 ^D
 
 If you want to send a set of strings to a specific user's terminal who is already logged in, use:
 
 write target_username
 your text here
 ^D
 
 (Note: in order to receive message, the target user must have his mesg set to y. If not, he/she have to to issue the command: mesg y)
 
 (strange thing is that, you don't need sudo to broadcast a wall message where you have to depend on the target user's choice to send a message to one specific user. Counterintuitive, huh?)
 
# Lock screen from terminal:
 
 In GNOME use "gnome-screensaver-command -l"
 
 In general this also works: "xscreensaver-command -lock"
 
 You may need to install required packages: gnome-screensaver and xscreensaver
 
 
# Convert m4a to mp3
 
 
 This shell script is quite handy for converting a directory of .m4a sound files to .mp3's. This script requires that you have LAME and FAAD2 installed already.

```
#!/bin/bash 
for i in *.m4a; do 
	echo "Converting: ${i%.m4a}.mp3" 
	faad -o - "$i" | lame - "${i%.m4a}.mp3" 
done
```
 
(Note: The $ evaluates the variable i. So, if you type `Converting $i`, no problem. The part `${i%.m4a}.mp3` means that it searches for the string '.m4a' in the end of `$i`, deletes it (if exists) and appends .mp3)
 
 You then need to make it executable, and move it to the /bin directory.
``` 
 su 
 chmod +x m4a2mp3 
 mv m4a2mp3 /bin/
```
 
 Now you can simply type m4a2mp3 in the shell and it will convert any M4A files contained within the current directory to MP3. The script does not delete the old m4a files, but that can be easily added to the script if you wanted.
 
# Taking pictures through webcam 
 
 Easiest way:
 To take a picture while looking at the video feed:
 mplayer -vf screenshot tv://
 Press s to take a picture which will have names shot0001.png, shot0002.png etc.
 
 To play the webcam feed:
 mplayer tv://

 To specify particular device, do
 mplayer tv:// -tv device=/dev/video1
 
 To take a picture without any video feed:
 mplayer -vo png -frames 5 tv://
 and the desired picture is the 5th one, 00000005.png
 
 Using Mplayer (Haven't checked yet because of long list of arguments):
 mplayer tv:// -tv driver=v4l2:device=/dev/video0:width=1600:height=1200:outfmt=rgb24 -frames 3 -vo jpeg
 Using ffmpeg:
 
 ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-0c45_USB_camera-video-index0 -vframes 1 test.jpeg
 
 The author captures two frames and uses the second one:
 
 ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-0c45_USB_camera-video-index0 -vframes 1 test%3d.jpeg
 
 
 There is a software that does the job simply (not checked):
 fswebcam -r 640x480 --jpeg 85 -D 1 shot.jpg
 
# Streaming audio using cvlc: (not tested yet. GUI vlc streaming is straightforward and works :))
 
 you want a huge amount of streaming options, both in format and streaming protocols.
 
 VLC offers a huge range of options for both the protocol used to stream as well as the format of the stream. It also acts as both source and server, taking the audio input and streaming it (although it actually does this using the Live555 streaming media module). You can use http, rtp, rtsp among others and transcode the stream into pretty much any format you can think of. It can be quite complicated to setup. VLC can be run via a GUI or via the commandline using cvlc. The VLC wiki (http://wiki.videolan.org/Documentation:Streaming_HowTo) has lots of information about the various streaming options, but the documentation is sadly outdated. After lots of trial and error, I finally came to the following command that worked for me:
 cvlc -vvv alsa://hw:0,0 --sout '#transcode{acodec=mp2,ab=32}:rtp{dst=192.168.1.5, port=1234,sdp=rtsp://192.168.1.5:8085/stream.sdp}'
 
 This basically takes the microphone input, transcodes it into an MP2 file and then streams it via rtp to the address rtsp://192.168.1.5:8085/stream.sdp. If you then open "rtsp://192.168.1.5:8085/stream.sdp" in VLC on the client PC you get live audio, in near real time! The delay is about 1.5 seconds and requires*very little bandwidth. Sadly, there are three problems with this. First; only one client could connect at a time, secondly; the stream seems to fail after a while, sometimes after five minutes, sometime after two hours, but it would always fail and third it very CPU intensive (I am thinking this is why the stream failed on my box). 
 
 
# Adding environment variables like proxy etc permanently
 
 Add the data to the file /etc/environment, and/or the file /etc/bash.bashrc in appropriate form
 
# Adjusting brightness (The ultimate method)
 
 There is a directory that stores the values of backlight brightness. To go to the folder, do:
 ls /sys/class/backlight
 
 In our case, the result acpi_video0 is the directory. cd into the directory. Then ls. Among them, the file 'brightness' contains the value of current brightness.
 To see the current brightness, do:
  cat brightness
 You'll get 10 which is the maximum brightness.
 To change this brightness, simply replace the value with desired brightness:
 echo 5 > brightness
 
# Touchpad and vertical scrolling
 
 Installing xf86-input-synaptics will make your touchpad work except for the verticla scrolling.
 To enable it, open the file /etc/X11/xorg.conf.d/50-synaptics.conf
 In the first section:
 Section "InputClass"
 Identifier "touchpad"
 Driver "synaptics"
 		
 along with the other options, add this line
 
 Option "VertEdgescroll" "on"
 
 Now save and resrat xinit.
 
 
# systemctl command
 Example: Adding dhcpcd to systemctl
 ln -s /usr/lib/systemd/system/dhcpcd.service /etc/systemd/system/multi-user.targer.wants/dhcpcd.service
 
# Vim helps:

## Newer vim moves

* Navigation: along with Ctrl-U/D/Y/E, use H/M/L to jump to top, middle, and bottom part of the screen. Then, use zb/zt to adjust the screen. Scroll by the first character of the line using `-` and `+`.
* While searching, press Ctrl-G/T to jump between partial search highlights
* Ctrl-X Ctrl-K to get correct spelling from the dictionary while typing a word
* Hop indents in insert mode with Ctrl-D/T. Jump to default indent with `S` (substitute line) in normal mode, deleting the current line. 
* `:browse oldfiles` or `:bro ol` opens a list of last opened files. Useful after closing a file and navigating away.
* Delete or change up to a mark with "d`a" or "c`a". Also delete till the occurrence of search string using `d/string`, or maybe, `d/str<C-G><C-T><C-T>ing<CR>`

* `"0p` to paste last copied segment even after using `d` or `c` in the meantime.
* `:/` to search for the last searched string
* Use buffer instead of tabs for the same project

## Ex commands

We can apply a command on a range of lines using ex commands.

* Ex commands start with `:`, followed by a line range to produce a set of line numbers, and a command to apply to those lines. The line range and the command can take additional arguments.

* Line range is separated using a comma (or semicolon for absolute reference) e.g.:
`:5,10` means the lines from 5 to 10
`:.,10` means the from current line to line 10
`:.,+10` means the from current line to the next 10 lines
`:1,$` (alternatively, `:%`) means from line 1 to the last line
`:'t,\string` means from the line containing mark `t` to the line where the string `string` appears next after the cursor (Note: to get the next occurrence of `string` after the mark `t` (instead of the occurrence of `string` after the current cursor position), using the separator `;` instead of a comma)

* A line range can be further filtered using a regular expression `re` by appending a `g/re/`. To negate the regular expression `re` we can append `v/re/` instead. 
e.g.
`:% g/string/` means all lines in the file where `string` appears
`:/this,+10 g/sring/` means all lines between the appearance of `this` after the current line and 10 lines after that appearance such that the string `sring` appears in it
`:'t,$ v/string/` means all lines between the tag `t` and the end of the file such that the string `string` does *not* appear

* A command goes after the (filtered) line range. It applies like a for loop to each line in the range.

`j` to join the line to the next
`d` to delete the line
`m` to move line, followed by a destination (e.g. `m$` to move to the end of the file)
`co` to copy line, followed by a destination (e.g. `:1,10 co +10` copies to 10 lines below)
`p` to print line (to a temporary window, which can be saved or further edited)
`s` to substitute, followed by search sting and replacement string and whether on each line or not (possibly with confirmation) (e.g. `s/foo/bar/gc`)
`!` to call an external command, followed by the external command (e.g. `:5,10 !sort` that sorts the lines 5 through 10)
`norm` to run a command (e.g. `:.,+10norm @a` to run the macro `@a` on the next 10 lines)
`w` to write to disk (e.g. `:% g/hello/w test.txt` to save all lines with `hello` to a file)
`r` read (e.g. `:$r !date` to read the date into the last line)

Acting on a line range (i.e. *not* to each line in the range but as a whole)
`c` to change the line range, followed by text 
`a` to append the line range, followed by text 
`i` to insert before the line range, followed by text 
(e.g. `:.,+10 c<CR>` followed by `hello<CR>.<CR>` to change (delete and then add) the next 10 lines by the test `hello`. Note that `.<CR>` is to indicate end of input.)

* A command can take a prefix to modify the line number it is acting on
e.g.
`:5,10 g/hello/-1j` joins each line that has the string `hello` to its *previous* line (as opposed to the next line) via `-1` modifier on the line number obtained by the range `5,10 g/hello/`.
	

## Basic vim
 
 Type vimtutor to go through a short interactive tutorial.
 For slightly advanced and very useful tutorial: http://linuxgazette.net/152/srinivasan.html
 Navigation: The most popular way to scroll will be Ctrl-Y/E, Ctrl-D/U. W/w, E/e, B/b to move left-right via words, `5b`, `5e` to hop 5 word backward and forward, `}`,`{` to move to prev/next blank lines. And most importantly, `)`,`(` to hop sentences i.e. hop the fullstops.

 Mainly use w,e,b to go left-right, ),( and },{ to hop fullstops and paragraphs, j,k to up down. Ctrl-U/D to move the screen by half page up/down.
 
 Operators: Start selecting text using `v`, move cursor to select strings, then: copy- y, change - c, delete- d, yank- y, paste- p.
 Handy commands:
```
 	de - delete upto the end of the current word
 	db - delete upto the beginning of the current word
 	d) - delete upto the beginning of the current sentence
 	d) - delete upto the end of the current sentence
 	diw, ciw - cut, change words inside which the cursor is.
 	yaw - copy a word (the current word)
 	ci(, ci" - change inside () or " ". Can be replaced by di,ca,da
 	gf - to quickly go to the filename on which the cursor is
 	yy/Y - copy whole line
 	dd - cut whole line
 	D - delete till the end of the line
 	das, dis - delete the current sentence (i.e. enclosed by dots or some vague identifiers(very shady))
 	5Y, 5dd - copy/cut 5 lines
 	`` (two back-ticks, not apostrophe) - jump to the previous cursor position 
 	dtx - change till the next occurrence of character x
 	ctx - delete till the next occurrence of character x
 	jtx - jump till the next occurrence of character x
 	ktx - jump till the previous occurrence of character x
 	fx, Fx - jump left, right to the next occurrence of the character x
 		(for example, dt. deletes the text till the next dot from the current position)
 	xp  - to swap two consecutive letters like "taht" to "that"
 	ddp - switch the current line and the next
 	A;  - append a semicolon to the end of the line.
 	>>  - increase indent of current line.
 	<<  - decrease indent of current line.
``` 
 
 ##############################################################################
 A list of tricks found in the [page](http://stackoverflow.com/questions/726894/what-are-the-dark-corners-of-vim-your-mom-never-told-you-about?rq=1)
 
 Moving around in vim: All the long moving around can be done by bB,eE,)(,}{, and the special f/F{char}, t/T{char}. Once f or F  is pressed followed by a character, pressing ; and , will take the cursor matching the same character further in that direction. t or T takes one character before the target character.
 
 Tip: To open a hyperlink in your browser, bring the cursor inside the link text and type `gx`.
 
 Redo in VIM: press Ctrl+R, and not a capital U.
 
 Duyuuuelete everything till the end of the word by pressing . at your heart's desire.
 
 ci(xyz[Esc] -- This is a weird one. Here, the 'i' does not mean insert mode. Instead it means inside the parenthesis. So this sequence cuts the text inside parenthesis you're standing in and replaces it with "xyz". It also works inside square and figure brackets -- just do `ci[` or `ci{` correspondingly. Naturally, you can do di (if you just want to delete all text without typing anything. You can also do a instead of i if you want to delete the parentheses as well and not just text inside them.
 
 ci" - cuts the text in current quotes
 
 ciw - cuts the current word. This works just like the previous one except that ( is replaced with w.
 
 C - cut the rest of the line and switch to insert mode.
 
 ZZ -- save and close current file (WAY faster than Ctrl-F4 to close the current tab!)
 
 ddp - move current line one row down
 
 xp -- move current character one position to the right
 
 U - uppercase, so viwU upercases the word
 
 ~ - switches case, so viw~ will reverse casing of entire word
 
 Ctrl+u / Ctrl+d scroll the page half-a-screen up or down. This seems to be more useful than the usual full-screen paging as it makes it easier to see how the two screens relate. For those who still want to scroll entire screen at a time there's Ctrl+f for Forward and Ctrl+b for Backward. Ctrl+Y and Ctrl+E scroll down or up one line at a time.
 
 Crazy but very useful command is zz -- it scrolls the screen to make this line appear in the middle. This is excellent for putting the piece of code you're working on in the center of your attention. Sibling commands -- zt and zb -- make this line the top or the bottom one on the sreen which is not quite as useful.
 
 % finds and jumps to the matching parenthesis.
 
 de -- delete from cursor to the end of the word (you can also do dE to delete until the next space)
 
 bde -- delete the current word, from left to right delimiter
 
 df[space] -- delete up until and including the next space
 
 dt. -- delete until next dot
 
 dd -- delete this entire line
 
 ye (or yE) -- yanks text from here to the end of the word
 
 ce - cuts through the end of the word
 
 bye (yiw) -- copies current word (makes me wonder what "hi" does!)
 
 yy -- copies the current line
 
 cc -- cuts the current line, you can also do S instead. There's also lower cap s which cuts current character and switches to insert mode.
 
 viwy or viwc. Yank or change current word. Hit w multiple times to keep selecting each subsequent word, use b to move backwards
 
 vi{ - select all text in figure brackets. va{ - select all text including {}s
 
 vi(p - highlight everything inside the ()s and replace with the pasted text
 
 b and e move the cursor word-by-word, similarly to how Ctrl+Arrows normally do. The definition of word is a little different though, as several consecutive delmiters are treated as one word. If you start at the middle of a word, pressing b will always get you to the beginning of the current word, and each consecutive b will jump to the beginning of the next word. Similarly, and easy to remember, e gets the cursor to the end of the current, and each subsequent, word.
 
 similar to b/e, capital B and E move the cursor word-by-word using only whitespaces as delimiters.
 
 capital D (take a deep breath) Deletes the rest of the line to the right of the cursor, same as Shift+End/Del in normal editors (notice 2 keypresses -- Shift+D -- instead of 3)
 ############################################################################
 Others shared:
 
 One that I rarely find in most Vim tutorials, but it's INCREDIBLY useful (at least to me), is the
 
 g; and g,
 
 to move (forward, backward) through the changelist.
 
  vity and vitc can be shortened to yit and cit respectively. –  Nathan Fellman Sep 7 '09 at 8:27 
 
 
 
 Not sure if this counts as dark-corner-ish at all, but I've only just learnt it...
 
 :g/rgba/y A
 
 will yank all lines containing "rgba" into the a buffer. I used it a lot recently when making Internet Explorer stylesheets.
 
 
 Jumping the marks: To create a mark, press m and then any letter, say a. So, `ma` creates a mark named `a`. Now you can move around here and there. To come back to mark `a`, press a backtick and the markname i.e `\`a`. If you want to hop marks created in a different file which is not even open in vim right now, you have to create the marks with capital letters. For example, if you create a mark named `F` by `mF` in file called file1 and exit it and open another file called file2and you want to jump to the mark F in file1, all you need to do is press `mF`.
 
 One very important mark is `.`, the mark at which the file was last edited. So, after opening a file, pressing `tick` followed by dot will take you to the place where the file was last edited. You can go back further into the last edited place list by pressing `g;` and forward by `g,`.
 
Other useful special marks are "`[" and "`]" which take you to the beginning and the ending of the last yanked location. On the other hand, "`<" and "`>" for the last section.
 
 
 Typing `==` will correct the indentation of the current line based on the line above.
 
Actually, you can do one `=` sign followed by any movement command. e.g. `=ap` or `=G` or `=a{`
 
For example, you can use the % movement which moves between matching braces. Position the cursor on the { in the following code:

``` 
 if (thisA == that) {
 //not indented
 if (some == other) {
 x = y;
 }
 }
```

``` 
 And press =% to instantly get this:
 
 if (thisA == that) {
     //not indented
     if (some == other) {
         x = y;
     }
 }
```
Alternately, you could do `=a{` within the code block, rather than positioning yourself right on the { character.
 
 `gg=G` corrects indentation for entire file. 
 
 ##############################################################################
 
 
 Creating visual blocks: Ctrl + v
 Select the previously selected visual block: gv
 
 Insert a string str in front of every line in a visual block:
 1. Select the visual block
 2. Press I. It will take you to the beginning of the first string of the first line of the visual block.
 3. Enter the string str.
 4. Press Esc
 
 Similarly, making any change in every line of a visual block involves similar steps.
 
 Insert Mode (i) commands: 
 Ctrl-w delete upto the word before the cursor
 Ctrl/Shift-Left/Right to move left/right by one word as usual
 Ctrl-Y, Ctrl-E mimics (copy-pastes) the characters above and below the cursor.
 
 Ctrl-@ to insert the strings entered in the previous insert mode session and stop insert mode
 Ctrl-A to insert the strings entered in the previous insert mode session 
 
 
 Word Completion: Press Ctrl-P, Ctrl-N to complete the current half-typed word by the matching word found just before/after the current position. If you don't want the matching word occurring immediately before/after the current position, i.e. if you want options, then press "Ctrl-X Ctrl-P" or "Ctrl-X Ctrl-N" for a drop down list of matching word occurring before/after the current position. To complete the word using words from dictionary, press "Ctrl-X Ctrl-K" to get a list. This is useful when you don't know the spelling of some word and you need help on the way typing the word. You can type a couple of letters and type Ctrl-X Ctrl-K then keep typing until you can narrow down the dictionary list and select one. Also, to auto-complete filenames or path, press"Ctrl-X Ctrl-F".
 
 
 When autoindent is on (:set autoindent or :set ai), and a new line starts after some whitespaces respecting the indentation, you might want to press backspace to go to the previous indentation mark. But in this case, backspaces only deletes one whitespace at a time. To delete indents one by by one, press Ctrl-D, and insert indents, Ctrl-T.
 Note: A more powerful indenting option is "smartindent" which brings back your cursor by one tab when you type the ending bracket } to {.
 
 Note: After using smartindent, the autoindent options seems useless. It is faaar better and fun to use. Never use autoindent again. Spread the word.
 
 Searching a string: `/string` will highlight all the matches. This is case sensitive. `:set ignorecase` or equivalently `:set ic`will get rid of that limitation. Pressing n and N will take you back and forth among the search results. `:set noic` will turn of the ignorecase option. Also, * and # will search the previous and next occurrence of the current word on which the cursor lies. Again, case sensitive if `:set ic` is not set. 
 
Replace: Replacing is done by the command :substitute or :s. These are some examples with explain the basics:
 
```
 :%s/foo/bar/g
 Replaces foo by bar everywhere in the file.
 
 :%s/foo/bar/gc
 Replaces foo by bar everywhere in the file with confirmation.
 
 :s/foo/bar/g
 Replaces foo by bar everywhere in the current line.
 
 :s/\<foo\>/bar/gc
 Replaces foo by bar with confirmation everywhere in the file only when foo is found as a whole word i.e. enclosed by spaces.
```
 
 Once again, `:set ic` and `:set noic` will play a role.
 
 Spell Check: To turn on spell check, type :set spell and hit enter. (Optionally, :set spell spelllang=en_us for language selection). Press `]s` and `[s` to hop the misspelled words and type z= to get a dropdown list of possible correct spellings. Note that `[[` and `]]` takes you to the beginning and ending of the file, similar to GG and gg. To turn off spelling mode, type, :set nospell. You can always all include "set spell" in .vimrc to enable default spell check in the default language en_us. While in insert mode (i), typing "Ctrl-X s" will give you a drop-down list of correct spelling of the last misspelled word.
 
 Edit .vimrc to set necessary options. If it doesn't exist, copy it from etc. 
 Here are some necessary augmentations to make life simpler:
 
 syntax on
 (for highlighting the keywords in different colors based on the extension)
 
 set clipboard=unnamedplus
 (to copy yanked texts to X-system buffer instead of vim buffer, which is useful for yanking from vim and pasting in another program, say firefox. But this gives a little problem regarding pasting, which is arbitrary. Need to fix this.)
 
 set spell spelllang=en_us
 (to enable spell check in en_us. spelllang=all will allow all languages)
 
 set linebreak
 (to display long lines after breaking them at spaces i.e. after a word is finished instead of breaking it in the middle of a word)
 
 set visualbell
 (the screen flashes if you hit Esc more than once to help you control your OCD)
 
 imap <c-l> <c-g>u<Esc>[s1z=`]a<c-g>u
 (This option accelerates the process of auto correct like crazy. While in insert mode, if you have made a spelling mistake, you can press Ctrl-L to quickly accept the first spelling suggestion of the last misspelled word, create a undo node, come back to your original position and enter insert mode. If you don't like the auto correct, you can press u to undo or Ctrl-R to redo. Here is how it works:
 	<c-g>u 	inserts an undo-break	
 	[s 	moves to the last spelling mistake
 	1z= 	chooses the first suggestion
 	`] 	move to the last insert point
 	a 	append text
 )
 
 set wildmenu
 (for option list the :option by pressing tab. For example, :color <Tab>)
 
 Smooth Scrolling: The following code to be added to .vimrc in order to smoothen the scrolling in vim. This affects only affects Ctrl-D, Ctrl-U.
 Important note: Remember that the ^ character indicates a control character; copy-paste will produce invalid results and these must be entered manually (with CTRL-V)!
 To enter ^Y in the file, type Ctrl-V,  Ctrl-Y. And similarly for ^E.
 
 function SmoothScroll(up)
     if a:up
         let scrollaction="^Y"
     else
         let scrollaction="^E"
     endif
     exec "normal " . scrollaction
     redraw
     let counter=1
     while counter<&scroll
         let counter+=1
         sleep 10m
         redraw
         exec "normal " . scrollaction
     endwhile
 endfunction
 nnoremap <C-U> :call SmoothScroll(1)<Enter>
 nnoremap <C-D> :call SmoothScroll(0)<Enter>
 inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
 inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i
 
 
 Make vim open new buffer in new tabs: (useful while pressing gf on a filename/path, :o :e etc)
 
 " Experimental. Remove if buggy.
 " This is incredibly good. I like it.
 " set hidden actually lets you open another buffer by :o, :e etc even when the
 " current file has unmodified changes. Fun!
 set hidden
 :au BufAdd,BufNewFile * nested tab sball
 
 Help for tabs:
 gt, gT to navigate through tabs
 :qa to quit all, :wqa to save and quit all, :qa! to quit all without saving 
 Most important of all:
 Press :tabo to close all other tabs except the current one. There is a catch though, it does not care if there is any modified buffer in the other tabs. It ignores them, i.e. the changes in all the other buffers are gone.
 
 Find out more for tab navigation
 
 Syntax folding in VIM:
 
 zi 	switch folding on or off
 za 	toggle current fold open/closed
 zc 	close current fold
 zR 	open all folds
 zM 	close all folds
 zv 	expand folds to reveal cursor
 
 
 Open recently opened files in vim:
 
 :bro ol
  
 This is short for :browse oldfiles. It will show a list of 100 recently opened file. You can navigate through the list to get the number corresponding to your desired file (sorry, no / to search). Press q to quit the navigation mode  and get the prompt and enter the number. The code in the previous subsection will ensure that the new buffer is opened in a new tab.

 Selecting, changing and editing tags (such as <a> text </a>):
 You can jump between tags using visual operators, in example:

      Place the cursor on the tag.
          Enter visual mode by pressing v.
 	     Select the outer tag block by pressing a+t or i+t for inner tag block.
 
 	     Your cursor should jump forward to the matching closing html/xml tag. To jump backwards from closing tag, press o or O to jump to opposite tag.
 
 	     Now you can either exit visual by pressing Esc, change it by c or copy by y.
  
#5. Setting VI keybindings for the terminal emulator:
 
 Edit your .inputrc file (or create if it does not exist) and insert the following:
 set editing-mode vi
 set keymap vi-command
 
 Note: You have to export the EDITOR variable ans vim: export EDITOR=vim
 Or, save it it the file that contains the env variable. Where you save your proxy info. i.e. 
 echo "EDITOR=vim" >> /etc/environment
 echo "VISUAL=vim" >> /etc/environment
 
 Now save and open the terminal. It'll behave like vim in insert mode. Although it not as powerful as vim, it is surely something. All the basic vim commands are usable. You can press v to enter the text editor for better editing. 
 Here is the cheatsheet: http://www.catonmat.net/download/bash-vi-editing-mode-cheat-sheet.txt
 "
 
# Copying some stuff to all users that are created
 
 Copy stuff into the folder /etc/skel/. While useradd, they will be copied to the corresponding home of the user. These can include dot files like .bashrc, .vimrc etc. Also, you can copy some directories.
 
# Search for all http links in a file by grep

``` 
 cat filename | grep 'http://[^"]*'
```

 Alternatively, and more intuitively (more useful too), extracting mp3 links from a html file in Vim:
 
 Open the file. Type:
 gg
 (goto the beginning of the file)
 /\.mp3
 (searches for all occurrence of .mp3 and the cursor waits on the first occurrence of it)
 qr
 (starts recording a macro named r)
 yi"
 (yanks all link inside " " and cursor moves to the beginning of the corresponding " ")
 G
 (goes to the end of the file)
 o Esc p
 (Inserts a new line and goes to normal mode and pastes the link in the end)
 (two back ticks. Two single apostrophies also work)
 (to go back to the previous cursor position, which is the beginning of the " ")
 nn
 (Here, the number of n's may vary depending on the format of the page. first n takes the cursor to .mp3 inside of the current " " and the second takes it to the next one, which maybe part of the text in a hyperlink rather than being part of a link. In that case you need to enter 3 n's i.e. nnn)
 q
 (now that we have completed the loop, we stop recording the macro, which was named r)
 
 Now press @r to run the macro once more and the 5@r to repeat it 5 times. At the end of the process, you have a all the links at the end of the file, which you can yank and paste in a file called dumpfile.  
 
 The whole sequence of key presses to create the macro named "r" is: 
 gg/\.mp3<Enter>qryi"Go<Esc>p``nnq
 
 (note: here the `` two backticks, not apostrophies. Remember this otherwise it might cause trouble)
 
 Notes: Instead of using  two backticks, which may give "mark not set" error, you can actually set a mark every time the cursor is on the search string by giving it a name (say b) using mb. When jumping to that position, use \``b` and it will be back to that position again.
 
 You can save the macro named r inside .vimrc using
 let @r = 'yi"Go<Esc>p''nnq'
 
 Inside vim you can actually issue "rp to paste the content of the macro to copy it to vimrc.
 
 Then you can dump the output in a file by >> and wget -i dumpfile to download them.
 
 Note: A better and much faster way to download all the files:
 
 cat dumpfile | parallel --gnu "wget -c -b -q {}"
 
 alternatively:
 
 parallel -j #number wget < dumpfile
 
 
 Caution: stopping wget (pkill) and restarting has some weird download issue.
 Try not to stop the wget once it's running. Weird. Even with -c. Needs to be checked.
 
 
 This command requires a package called parallel which allows parallel downloads unlike a "wget -i listfile".
 Here, -c resumes partially downloaded file download, -b sends the wget processes to background, and -q is for quiet mode, i.e. does not generate a logfile while downloading. One problem is that you cannot see the progress of the downloads which is the price of -q, otherwise, you can always cat the wget-logfile to check the download progress. But, doesn't matter if the connection is reliable, because we don't want thousands of log files to fill up our space.
 
# Lock screen for terminal
 
 Note: It is  important to have a password for the user before issuing the command. Type:
 vlock -c 
 to lock the current virtual terminal. 
 vlock -a
 locks all the virtual terminals belonging to the user.
 It doesn't work on X11 so in order to lock everything, Press ctrl+alt+F1/12 to move to one tty which is logged in, or log in. Then issue this command. Once done, it doesn't let you press ctrl+alt+f2/12 to move to another tty.
 
 To set up a terminal based screensaver, use cmatrix. It gives you a matrix style screensaver without any screen lock facility.
 
 In order to use two of these prgram together, type:
 
 cmatrix; vlock -a
 
 It works fine. For aesthetic purposes, one user recommended:
 
 cmatrix -a -b -u 5; vlock -a
 
# Vimperator matters:
 
 Setting the Ctrl+i editor to vim:
 
 Type:
 
 :set editor='xterm -e vim'
 
 Make the command line bar (status bar) smaller:
 
 :highlight Normal -append font-size: 10pt;
 
 
 Other helps:
 
 Navigation forward/backward: Ctrl+o, Ctrl+i or :ba, :fo, H, L
 Goto the root of the current website: gU (it takes www.site.com/page/page2 to www.site.com)
 Close tab: :q, Save and close tab: ZZ
 
 Tab navigation:
 Change tabs: gt, gT
 Goto the previously selected tab: Ctrl+6
 Goto the tab numbered <n>: g<n>
 When there are too many tabs, pressing b will show all the tabs. Enter the number of the tab and hit Enter to go to it.
 
 
 Set local marks: ma, goto mark a: `\`a`
 
 Open download tab: :downl
 
 Highlight search: :set hsl
 
 Hide scrollbar: :set nosb (To turn back on: :set nosb)
 
 To copy the hinted url to clipboard: (; to enter the) y
 
 Disable vimperator temporarily: Shift-Esc
 
 To hide firefox menubar: :set gui=nomenu
 To access firefox menu:
 :emenu [key_word]
 # or
 :em[tab]
 
 
 TODOs: 	Choose between address bar and vimperator command line bar because both contain the address, although it's hard to copy-paste from vimperator bar
 	Checked: Remove some more bars to get more space
 	Easy way to look at the title of the page 
 	Autohide statusbar, or transparency
 	Smooth scrolling ( implemented. see .vimperatorrc)
 
 Browsing help
 
 Go back in the current tab: H
 Go forward in current tab: L
 
 reload the .vimperatorrc without restarting firefox
 :source ~/.vimperatorrc
 
 Toggle between page and its source code: gf
 Open the source code in EDITOR: gF
 
 Saving things: Press ; to enter the hint mode, press the right key, then the number.
 s for without prompt, a for with prompt, although both come with prompt initially if "Ask every time" is on.
 
 Saving the destination of a link (Save link as): ;s<link number> or ;a<link number>
 Saving an object (save image as, save the object etc): ;S<link number>, ;A<link number>
 
 Copy link location: ;y (yank, basically, in hint mode)
 Copy link text (that's the best that can be done without a mouse): ;Y
 
 Copy current link to the buffer: y
 Copy highlighted link to the buffer: Y ( Don't know how to highlight in vimperator bar)
 
 Imp: Copy non-link text from the page:
 
 Caret mode (c) gives you a cursor and you can move around with vim keystrokes and select things using visual block(v) and copy text (y). But there is a catch. Caret mode does not land the cursor on the portion of the page that you are viewing. So, it is important to search a string with / and reach the portion of the page where you want the cursor to be, and then press c to enter caret mode.
 
 Opening a link in new window (F) and same window (f) are easy, but modify the link before opining them requires Hint mode (;) and capital letter. For example, ;T or ;W or ;O lets you edit the thing.
 
 Very interesting:
 Follow the link labeled next or > if it exists: `]]`
 Follow the link labeled prev or < if it exists: `[[`
 
 Open right-click menu of a link: ;c
 
 Add the current page to bookmark: a(then Enter)
 Remove the current page from bookmark list: A
 
 Undo closed tabs: u
 Undo last 5 closed tabs: 10u
 
 Toggle between current and the tab opened last: Ctrl-^ (Actually, Ctrl-6)
 Run same command on tabs from 
 
 Stop a loading page: Ctrl-C
 
 Detach a tab from its current window and be on its own: :tabdetach
 Attach a tab to another firefox windos: :tabattach <number>
 
 Show all the navigation history of the current tab: :back <Tab>
 Open the previous tab history link in a new tab: :back <Tab> <home> <delete "back" and type "tab"/"tabopen" etc> <Enter>
 
# Wireless mouse and USB speaker
 
 For wireless(bluetooth) mouse, install bluez4. It should work.
 For USB speaker,
 cat /proc/asound/cards
 to see the available cards. In my case, the USB one is 2. Now edit vim 
 /usr/share/alsa/alsa.conf
 
 
 
 
 and change the line
 defaults.pcm.card 0
 to
 defaults.pcm.card 2
 and save.
 
 To accelerate the process of changing this value, I did this:
 Create another alsa.conf file next to it(i.e. in the same directory), called alsa.conf.other which contains the altered value i.e. pcm.card 2.
 cp /usr/share/alsa/alsa.conf /usr/share/alsa/alsa.conf.other
 vim /usr/share/alsa/alsa.conf
 (Edit the desired value and save it.)
 
 Now this code interchanges these two files:
 
 # we have alsa.conf and alsa.conf.other. We want to interchange them.
 cp /usr/share/alsa/alsa.conf /usr/share/alsa/alsa.conf.tmp
 rm /usr/share/alsa/alsa.conf
 cp /usr/share/alsa/alsa.conf.other /usr/share/alsa/alsa.conf
 rm /usr/share/alsa/alsa.conf.other
 cp /usr/share/alsa/alsa.conf.tmp /usr/share/alsa/alsa.conf.other
 rm /usr/share/alsa/alsa.conf.tmp 
 
 
 
 
34. Interaction between different consoles through pipes:
 
 In a console, create a pipe names mypipe using mkfifo:
 mkfifo mypipe
 
 (You can see that this file is a pipe by ls -l mypipe)
 
 To use these pipes, redirect the output of a command (say ls -l) to mypipe via:
 ls -l > mypipe
 (the cursor will wait)
 
 Now goto another console and take that output out of the pipe via:
 
 cat < mypipe
 (The cursor on the other console will resume)
 
 
33. Simple sketch of keylogger:
 
 Identify your keyboard id with: xinput --list
 
 Log keystrokes with: `xinput --test $id`
 (Observation: instead of --test, --test-xi2 is working. And for minimal output, id=12 is good)
 
 Match numbers to keys with: xmodmap -pke
 
 
 Dumping this output to a file seems to be a challenging task since the command gives an output after we hit Ctrl+C. So, the doing >>dumpfile dumps a chunk of data instead of line per event. In fact, if we use --test, it doesn't even dump. To avoid this, we use:
 stdbuf -o0 xinput test 12 > logfile
 
 Read:
 
35. Dumping stdout without buffering:
 
 You can explicitly set the buffering options of the standard streams using a setvbuf call in C (see this link), but if you're trying to modify the behaviour of an existing program try stdbuf (part of coreutils starting with version 7.5 apparently).
 
 This buffers stdout up to a line:
 
 stdbuf -oL command > output
 
 This disables stdout buffering altogether:
 
 stdbuf -o0 command > output
 
 
36. Using awk to reformat the output:
``
 stdbuf -o0 xinput test 12 | awk -F' ' '{printf $3}'
``

This means, consider the lines of the output as a sequence divided by the character ' '. Then print the 3rd element of that sequence.
 
36.5. so, here is the complete keylogger:
 
 # The dumping part of the keylogger. A file called mykeylogger
```
 stdbuf -o0 xinput test 11 | stdbuf -o0 awk '/ press /' | stdbuf -o0 awk -F' ' '{print $3}' >> dump 
``` 

 # The decoding part of it. A different file called decode.sh
 
``` 
 for line in $(cat dump)
 do
 	xpr="$(xmodmap -pke | awk "NR==$line-7" | awk '{ print $4}')"
 #	echo $xpr
 	case "$xpr" in
 		Return)
 			echo -e "\n" >> out2
 			;;
 		space)
 			echo " " >> out2
 			;;
 		*)
 			echo -n $xpr >> out2
 	esac
 	echo -n " " >> out2 
 done  
 echo -e "\n" >> out2
 cat out2
```
 
# Password protecting text files in VIM:
 
 To encrypt a file while creating:
 $vim -x filename
 (You will be asked to enter a password twice)
 
 To open the file:
 $vim filename
 (You will be asked to enter the password)
 
 To edit the file and save it with the same password:
 $vim filename
 When finished editing, enter :wq!
 
 To change the password:
 $vim +X filename
 
 Tip: to verify that the file is encrypted, always check by cat filename
 
 
# Detect filetype even without the extension:
 
 file filename
 
 It will give you useful information about the filetype of filename using its magic numbers. Whatever that means.
 
 
# Incremental terminal history search:
 
 In terminal enter:
 
 gedit  ~/.inputrc
 
     then copy paste and save 
``` 
 "\e[A": history-search-backward
 "\e[B": history-search-forward
 "\e[C": forward-char
 "\e[D": backward-char
```
 
     FROM now on and many agree this is the most useful terminal tool saves you a lot of writing/memorizing... all you need to do to find a previous command is to enter say the first 2 or 3 letters and upward arrow will take you there quickly say i want: 
 
```
 for f in *.mid ; do timidity "$f"; done
```
 
 all i need to do is enter
 
```
 fo
 
```
 and hit upward arrow command will soon appear 
 
 
# Few Terminal keyboard shortcuts
 
 Ctrl-k 	clear all characters after the cursor 
 Ctrl-u 	Clears all characters before the cursor
 Ctrl-w 	clears word before the cursor. a word is set of characters separated by spaces
 Ctrl-l 	clear screen 
 
# Copy the content of a file to the X clipboard (so that right click - paste works)
 
 xclip -sel clip < /path/of/the/file
 
# Git tutorial

## Removing a large file from the commit history
```
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch path/to/file.jpg' \
  --prune-empty --tag-name-filter cat -- --all
```
Then do
```
git push origin --force --all
```
to delete the same in the remote repo.

* If it is a directory, use `rm -r ...` instead of `rm`.


## Create a respository
 Created account in github. Created a repository called `testconfigs` under the username 
`<username>`.

### SSH access to github

* Generated public ssh key by: `ssh-keygen`
No passphrase, no name (this is important because we won't be adding this public key using `ssh-add`). Since this has the default name, the program accepts it by some accident. This needs a fix.
* Then follow this to run ssh-add:
```
 eval `ssh-agent -s`
```
 (Here, these are two backticks, not apostrophes). Then run:
```
 ssh-add
 cat ~/.ssh/id_rsa.pub
```
* Copy this output of `id_rsa.pub` and paste it in the website's ssh-key field after logging in.
 
* Then check that you have ssh access to github using: 
```
ssh -T git@github.com
```
(Caution: _not_ your username or id, but the username `git`)
This is most probably a routine check that you have the access. This does not give you a remote tty or you do not need to stay logged in to perform git tasks. You can probably skip this step.

* Next, update your name and email address in the config using
```
git config --global user.email "email@domain.com"
git config --global user.nam "Name"
```

- To copy own ssh public key into another server's `.ssh/authorized_keys` so that you can login without password, do
```
 .ssh/id_rsa.pub | ssh user@server 'cat >> .ssh/authorized_keys'
```

- To avoid writing the full `user@server` address, add a nickname in your `.ssh/config` like this:
```
Host nickname
  User debdeep
  HostName serve.server.address
```

### To push/pull git repository without password
Change the url origin type of your repository to an ssh-based one using:
```
git remote set-url origin git@github.com:<username>/<repository_name>.git
```

### Back to creating a repository
 Create some empty directory as your repository, which will be your working directory. Then run: `git init`
 This will create a `.git` file in the directory.
 Now add the address of the remote host, which we are naming `gitty`
```
 git remote add gitty git@github.com:<username>/testconfig
```
 
 The repository `testconfigs` will be referred to as `gitty`.
 
 You can see all the remote hosts by: `git remote -v`
 If needed, you can delete a remote host by : `git remote rm nickname_of_host`
 
 Now download all the files from the master branch  of `gitty` by: `git pull gitty master`
 Now your working  directory  will have all the files stored in `gitty`. You can modify them, add more files etc. After modification, add the files to the modification list using:
```
 git add file1
 git add file2
 git add file3
```
 etc.
 
 After they are added to the _changelist_, it is the time to commit to the change and add a comment about the changes:
```
 git commit -m "Added file1, file2, changed file3"
```
 
 After committing, it is time to upload the change back to the place by:
```
 git push gitty master
```
 (Obviously we are uploading to the master branch here)
 (Here, for the first time you may be asked to enter your email id and username. Follow the instruction to add these info to the file `~/.gitconfig`)
 
 And we are done.


## Maintaining the local repo:
 Create a new repository in the website. Copy the clone address. Locally do
```
	 git clone https://github.com/username/reponame
```
 Now you have a local repo.
```
         cd reponame
```
 Add files/make changes e.g. `cp path/file .`
 Add to the git list : `git add file`
```
 git commit -m 'message'
 git push
```
 Provide username and password for your git repo.
 If you don't want to enter username/passwd repeatedly, add a remote repo:
```
  git remote add petname git@github.com:username/reponame
```
 Next, push to the repo called `petname` like this
```
  git push petname
```
 Then you won't be asked for credentials anymore. And by default it will get pushed to the master branch .
 
## Adding and committing only the files that are in the git ls-files list:
```
 git commit -am "Staging and committing all the modifications done to files in git ls-files"
```
 
 Alternatively, `get commit -a -m text"` works.

## Merging branches
If we want to merge the branch `remote_branch` to the branch `local_branch` (the terms `remote` and `local` are well-defined in that sense), we do the following.

* Create a branch
```
git branch local_branch
```
* Checkout to the (`local`) branch using
```
git checkout local_branch
```
* Merge the other branch (`remote`) to the current one (`local`)
```
git merge remote_branch
```
Note: you may get 'branch does not exist' error, in that case, `checkout` to the remote branch first and then get back to the local one.

* Merge conflicts will arise which can be resolved with launching a diffing tool with
```
git mergetool
```

### Replacing _all_ files without resolving conflicts

* **See below for alternative** ~~ To replace all the local files with the remote files, do 
```
git merge --strategy-option theirs
```
* To keep local files and discard the remote files while merging do
```
git merge --strategy-option ours
```
~~

**Caution:** Better alternative is to go through `git mergetool` and open it with `vimdiff` and then
 - Make the remote branch the final version with `:%diffget RE`
 - Make the local  branch the final version with `:%diffget LO`

## Using `vimdiff` as a mergetool:
* **Caution:** Quit unfinished merging work with `:cquit` (or `:cq`, to exit with an error code) so that next time `git mergetool` will launch `vimdiff` again. Otherwise, the file is all messed up with strings like `HEADER >>>>>>` and is saved as a real file and `mergetool` does not do anything.

If you quit `vimdiff` midway and would like to reset the merge again, 
 1. first cancel the merge
```
git reset --merge
```
 2. and perform the merge again with
```
git merge remote_branch
```
 3. fix merge conflicts
```
git mergetool
```

* There are 3 windows on top:
	left: local: the file from the branch we are current staying, i.e. the local branch
	right: remote: the file from the branch from which we are merging, the remote branch
	middle: base: a common ancestor of both local and remote from which both of the files were originated and diverted

Bottom window: final version of the merged file in the local branch, after merging

* We navigate in the bottom file (using `[c` and `]c`), changing lines if needed. To add changes from the remote version (i.e. from branch `remote_branch`), do `:diffget RE`
Alternatively, `BA` or `LO` for base or local.
* To apply the same change to the _whole_ file:
 - Make the final version of the file same as the remote copy with `:%diffget RE`:
 - Make the final version of the file same as the local copy with `:%diffget LO`
* If the lines get misaligned, do `:diffupdate`

* After merging is done, save the final version (Bottom window) of the file and quit.
* Git `.orig` files using `git clean -fd` 
- Might need to add the file again using `git add filename`
* Commit the current branch with `git commit -m 'merged remote_branch with local_branch'`
* Delete the branch that is merged with the current (local) branch using
```
git branch -d remote_branch
```
**Caution:** attempting to delete the remote branch without committing the merged local branch first will throw warning sign. That would be a reminder that the current needs to to committed.
 
## Scenarios

* **Pull from the internet and discard your local changes:**
```
git reset --hard
git clean -f
git pull
```
Here, `clean -f` to remove untracked files. `clean -fd` deletes untracked directories as well. Before `clean -f`, we can do `clean -d` to see which files are to be removed.

* Pull from the internet and set aside the local (uncommited) changes:
```
git stash
git pull
```
Then to pop back the local uncommitted changes on top of that using
```
git stash pop
```
To delete the stash, do `git stash drop` instead.

* **Desired Method**: Pull from the internet and put the current __committed__ changes as next commit after the remote version
[(nice explanation for the reason to rebase)](https://megakemp.com/2019/03/20/the-case-for-pull-rebase/)
```
git pull --rebase
```
(or just `git pull -r`)

This might need merge-conflict resolution 
```
git mergetool --tool=vimdiff
```
and cleanup 
```
git clean -df
```
Then, to indicate that rebasing is done, we do
```
git rebase --continute
```
followed by `git push` to push the final local change. (Note that  `git commit` is not required and has been done automatically)

This creates a commit history of the order `last remote commit, merged local commit`.

This (`--rebase`) is better for history and creates 2 commit histories compared to just `git pull` (with default `--merge` behavior), which creates 3 commit histories in the order `last remove commit, last local commit, merged commit`.

To recover from a failed `rebase` and revert to the state before the attempted `pull` (i.e. local changes remain in local directory), do
```
git rebase --abort
```

**Note**: `git pull --rebase` should be used over just `git pull` where we do not want to advertise that a merging has been done, e.g. when working on the same branch. This is the most common scenario.


* See the difference between file in two different branches
```
git diff branch_1 branch_2 -- filename.txt
```
The output will have the following:
  * Common lines are in white
  * Lines in branch_1 (and not in branch_2) are in red (and with `-`)
  * Lines in branch_2 (and not in branch_1) are in green (and with `+`)
To use `vimdiff`, replace `git diff` with `git difftool`.

* To change a conflicted file (with conflict markers) into the state of its last commit, do `git restore filename`

* See the commit history _of the current branch_
```
git log
```
or with ` git log -p ` to see all the changes (patches) to files. Other useful options are `--pretty=oneline` or `stat`.

* Delete `.orig` files (record of merging) after merging is done using
```
 git clean -fd
```
* Maintain  empty directories in your repository by creating `.gitkeep` file (conventional name)
```
touch empty_dir/.gitkeep
```
and tell to `.gitignore` to not ignore it using
```
# Inside .gitignore
empty_dir/*
!empty_dir/.gitkeep
```

## Rebasing (basing the current commit on) seems irrelevant and confusing to mess with history
`git rebase` linearizes two diverging branch heads. If we have a diverging branch `exp` of the `main` branch, we can do
```
git checkout exp
git rebase main
```
to make the changes of `exp` as a next commit to the ones in `main`. At this point, the last commit of `main` becomes a previous commit for `exp`. So, we can just merge `exp` to `main` using
```
git checkout main
git merge exp
```

**Q**: How to change files with conflict markers to its state before attempted merge?
```
git merge --abort
```
Note, for uncommitted files, this might revert the files back to last committed state.

## Removing sensitive information from github repo

[Main article](https://docs.github.com/en/github/authenticating-to-github/removing-sensitive-data-from-a-repository)

* To change the email address of all previous commits
```
git filter-branch -f --commit-filter '
      if [ "$GIT_AUTHOR_EMAIL" = "OLD_EMAIL" ];
      then
              GIT_AUTHOR_EMAIL="NEW_EMAIL";
              git commit-tree "$@";
      else
              git commit-tree "$@";
      fi' HEAD
```
Then, force push the repo with
```
git push --force
```
 
 
# All about wifi
 
 Theory (vague):
 
 The wlan card is: wlp6s0
 The program "netctl-auto" automates the connecting process.
 "wifi-menu" creates a profile and keeps it in /etc/netctl.
 "netctl-auto start/enable <profile>" attaches the profile to netctl and finally,
 "netctl-auto start/enable netctl-auto@wlp6s0.service" forces wlp6s0 to connect to the internet using the <profile>.
 
 This clears up several jobs:
 
 * Setting up wifi for the first time:
``` 
 ifconfig wlp6s0 up
 to bring the wlan to life, if it was down.
```
 
 `wifi-menu`
 to create a profile.
``` 
 dhcpcd wlp6s0
```
 to get ip through dhcp.
```
 systemctl enable dhcpcd.service
```
 to make it work over reboots.
 
```
 systemctl start netctl-auto@wlp6s0
```
 to let netctl-auto handle the automatic connection
```
 systemctl enable netctl-auto@wlp6s0
```
 to make it work over reboots.
```
 netctl-auto enable <profile>
```
 to make the profile work over reboots.
 
 
 * Deleting a profile, while it is already enabled:
 
 The first step is to tell netctl-auto to stop using the profile.
 
```
 netctl-auto disable <profile>
```
 should do that. But unfortunately, it still uses the profile somehow. You can verify it by issuing "systemctl restart netctl-auto@wlp6s0" and see that it is again connecting to the same profile. THe solution is to delete the profile.
 
```
 rm /etc/netctl/<profile>
 netctl-auto disable <profile>
 systemctl restart netctl-auto@wlp6s0
```
 
 and "ifconfig" to verify that the wlp6s0 is free.
 
 Note that: there is no such method to stop the profile using a single netctl-auto command.
 
 * Setting up a new profile:
 
 To set up the profile, issue
 wifi-menu
 
 If you get error (maybe through journalctl -xn) that "the interface is already up", it means that the profile still exists somehow. Follow the previous steps of "Deleting a profile".
 
 After wifi-menu finishes creating the profile, if "systemctl enable/start netctl-auto@wlp6s0" is already issued, you should be able to connect. 
 Otherwise, issue
```
 systemctl start netctl-auto@wlp6s0
 systemctl enable netctl-auto@wlp6s0
```
 
 Optionally, use
 netctl-auto enable <profile>
 to make it an automatic profile.
 
 * Switching to a new profile:
 
 Use wifi-menu to create a new profile and use
 netctl-auto switch-to <profile>
 
 * Reconnecting to a profile:
 
 #start the netctl-auto service to activate an already enabled profile through "netctl-auto enable <profile>" command:
 
 systemctl restart netctl-auto@wlp6s0.service
 
 If the profile you are trying to connect to is not already enable, you can always connect to it by "wifi-menu". To enable dhcp service, make sure "dhcpcd wlp6s0" is already issued, or enabled (stays over reboots) using 
 systemctl enable dhcpcd.service
 
 
 A possible solution to slow wifi: Sometimes, page loads very fast just after the wifi is connected, then after a few seconds, it seems to get stuck.
 Tried the following and probably worked: blacklist the module b43:
 
 Create the file /etc/modprobe.d/blacklist.conf add add this in it:
 
 # Blocking the b43
 blacklist b43
 
 And reboot. So the module will not load by default. You can check this by:
 lsmod | grep b43
 
 So, here, we wish to use the module brcmsmac, and the dependent module bcma. Some online forum says that the this module is slower and wl module should be used even though it is very unstable and only found in AUR.
 
 Also, to stop the console beep, this might help:
 # Do not load the 'pcspkr' module on boot.
 blacklist pcspkr
 (The drawback is that if you want the beep sometimes, you will have to manually modprobe or insmod the module)
 
# Enabling cron job for arch linux
 
 systemctl enable cronie
 
 (Cron for arch linux in NOT enabled by default. So you must start it.)
 
 Setting vim to be the default editor:
 
 echo "EDITOR=vim" >> /etc/environment
 echo "VISUAL=vim" >> /etc/environment
 (It needs restarting/relogging-in to read from environment file. To get instantly, use: export EDITOR=vim etc)
 
 My current crontab entry is: 
 
 
 # Minute   Hour   Day of Month       Month          Day of Week        Command    
 */10 */3 * * * cd /storage/Lenovo/lin && ./agitifyTODO.sh >> outfile 
 */10 */3 * * * ./updateArchy.sh 
 # Supposed to happen every 10 minute of every 3rd hours
 
 #*/2 * * * * export DISPLAY=:0 && zenity --info --text "hi"
 # Pop up every 2 minutes
 
 The files agitify.sh and updateArchy.sh can be found in my github.
 
# Microphone recording
 
 Record from the microphone in wav format:
 arecord out.wav
 Or, more conveniently,
 rec out.wav
 
 The following commands require the package "sox".
 
 The package sox provides almost everything regarding audio handling. Here is how you can monitor your microphone input without recording it (with a dB monitor, that too, stereo):
 rec -n stat
 
 Without the dB monitor:
 rec -q -n stat
 
 Show it for 5 seconds then stop:
 rec -q -n stat trim 0 5
 
 Repeat after every 5 milliseconds:
 while true; do rec -q -n stat trim 0 0.05; done
 
 Repeat after every 5 milliseconds, but only show the Maximum amplitude in that 5ms time interval:
```
 while true; do echo $(rec -q -n stat trim 0 0.05 2>$1 | awk '/^Maximum amplitude/ { print $3 }') ; done
```
 
 Keep recording from standard output and echo 1 if the volume level is above certain threshold (0.15), and return 0 otherwise:
```
 while true; do echo $(rec -n stat trim 0 0.5 2>&1 | awk '/^Maximum amplitude/ { print $3 < .15 ? 0 : 1 }'); done
``` 

 Following similar command pattern, the following code mutes the master audio level if the input level is more than the threshold, otherwise unmutes:
```
 while true; do amixer set Master $(rec -n stat trim 0 0.5 2>&1 | awk '/^Maximum amplitude/ { print $3 < .15 ? 0 : 1 }'); done
```
 
 Returns "high" if the amplitude is higher than the threshold, or returns "low":
```
 while true; do ampli=$(rec -q -n stat trim 0 0.25 2>&1 | awk '/^Maximum amplitude/ { print $3 < 0.15 ? 0 : 1 }'); if [ $ampli -eq 1 ]; then echo "high"; else echo "low"; fi; done
```
 (Self-note: Very mysteriously, 3 > 0.15 ? 1 :0 does not work)
 
 Simulating key stokes:
 Package called "xdotool" can send keystroked to X11 like this:
 xdotool key k
 
 So, here is the code to simulate a keypress of "j" simulated ny a tap on the mic or a clap:
```
 while true; do ampli=$(rec -q -n stat trim 0 0.25 2>&1 | awk '/^Maximum amplitude/ { print $3 < 0.15 ? 0 : 1 }'); if [ $ampli -eq 1 ]; then xdotool key j; fi; done
```
 
 This can be used while endlessly scrolling 9gag/facebook page without hands. Best tool for forever alone guy.
 
# Sharing keyboard and mouse between multiple computers:
 
 We have two computers called archy and pratima-3z. we want to use archy's inputs in pratima-3z. Install package called synergy. Archy has the following configuration file:
 
 section: screens
 archy:
 pratima-3z:
 end
 
 section: aliases
 pratima-3z:
 10.10.101.124
 end
 
 section: links
 archy:
 right = pratima-3z
 pratima-3z:
 left = archy
 end
 
 section: options
 screenSaverSync = false
	    vector<double> C_lrtb = get_lrtb(PArr[i].CurrPos);
 # My KVM uses Scroll Lock to switch screens, so set the
 # hotkey to lock the cursor to the screen to something else
 keystroke(f12) = lockCursorToScreen(toggle)
 end
 
 To run the server: synergs -f --config ~/.synergy.conf
 -f is for foreground.
 
 In the client, run synergyc -f ipaddress
 
 Note: Keyboard can be used only when the mouse is in the corresponding screen.
 
 
# A fun script to rotate the mouse pointer (10 times) in a circle of radius 250 in clockwise direction. Needs xdotool package.
 
 # Script for fun rotation. Check manpage for more details

```
 for i in {0..3600}
 do
 	xdotool mousemove --polar $i 250
 done
```
 
 Note: An example is the .myscr script wifire
 
# Detaching a process from terminal:
 
 The usual method is to add an & after it. For example: firefox &
 But when you have already issued the command and the process demands the terminal to stay in place, and you do not wanna restart the process with &, this might help:
 Press ctrl+z to stop the process
 Then type: bg 
 to send it to the background as a job
 Then type: disown
 to declare that you are disowning the job from the current terminal so that you can close the terminal without affecting the process.
 
 
# Auto login to arch
 
 Create the file:
 /etc/systemd/system/getty@tty1.service.d/autologin.conf
 ( Create directories whenever necessary)
 
 Then enter the following:
 
 [Service]
 ExecStart=
 ExecStart=-/usr/bin/agetty --autologin root --noclear %I 38400 linux
 
 And save it. Here is the actual link with a few more options. Probably has info about faster booting method.
 https://wiki.archlinux.org/index.php/Automatic_login_to_virtual_console
 
# Making the default font of Arch linux pretty
 
 To enable the effect for one user, create a file called .fonts.conf and copy this xml code inside:
 <?xml version="1.0"?>
 <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
 <fontconfig>
   <match target="font" >
     <edit mode="assign" name="rgba" >
       <const>rgb</const>
     </edit>
   </match>
   <match target="font" >
     <edit mode="assign" name="hinting" >
       <bool>true</bool>
     </edit>
   </match>
   <match target="font" >
     <edit mode="assign" name="hintstyle" >
       <const>hintslight</const>
     </edit>
   </match>
   <match target="font" >
     <edit mode="assign" name="antialias" >
       <bool>true</bool>
     </edit>
   </match>
   <match target="font">
     <edit mode="assign" name="lcdfilter">
       <const>lcddefault</const>
     </edit>
   </match>
 </fontconfig>
 
 Now, to make it available system-wide, copy the same xml code in a file called 29-prettify.conf and place it in /etc/fonts/conf.avail/
 Then make a symbolic link by:
 ln -s /etc/fonts/conf.avail/29-prettify.conf /etc/fonts/conf.d/29-prettify.conf
 Now run:
 fc-cache
 
 Now it should work.
 
# Uninstall infinality font sets:
 
 sudo pacman -S --asdeps lib32-freetype2 lib32-cairo lib32-fontconfig
 
 Then restart the x-server: pkill xinit
 
# Calibre setup with Kobo glo
 
 Install Calibre and the package udisks
 
 pacman -S udisks calibre
 
 Then connect the device, after some time it eill be detected.
 
 For Bookshelf management, follow this link:
 http://www.teleread.com/ebooks/using-calibre-for-e-book-management-chapter-6-managing-kobo-bookshelves/
 (The plugin they mention here is KoboTouch Extended)
 
 Basically,
 1. Preferences > Create your Own column > Add > Enter "Book Shelf", "bookshelf" (without quotes) > Apply
 2. Install KoboTouch Extended plugin
 3. Preferences > Addon > Select KoboTouch plugin > Customize> Scroll down to where they talk about Book Shelf > Enter "#bookshelf" (without quote) > Apply > Restart.
 
# Rules to ensure that files stay in certain directory with the same Book Shelf name:
 
 While importing, Calibre creates a directory with the same name as the Author and keeps the file inside. And while copying the files to the device, it keeps the same directory structure. 
 
 1. So, in order to keep several files in a directory, after importing the files to calibre, you must bulk edit their metadata and change the Author's name to the desired one. Note: In this process, the actual Author's name will be changed, which is the price we are paying.
 
 Second, creating Bookshelfs in calibre to avoid frantic tapping on the device, which is very frustrating given the speed of the device.
 
 Here is what we want:
 1. We wish to keep all the books in either of the book shelves
 2. For a file, it's book shelf name should be the same as the directory which it belongs to. 
 3. No intersecting book shelves
 
 In order to do that, after importing the books and changing the author's name, we need to do the following:
 2. Select files, bulk edit metadata, goto custom tags/metadata and enter the same name as the directory name/author's name.
 
 So, in brief, after importing the files from a place, immediately bulk edit the metadata, change the author name, custom tag to the directory name, then send to the device.
 
 
# Batch resize images before I forget how to:
 
 This one resizes all the jpgs to 1024x768:
```
 find . -iname '*.jpg' -exec convert {} -resize 1024x768 {} \;
```

To ignore aspect ratio, use a `!` after the dimension like this
```
 find . -iname '*.jpg' -exec convert {} -resize 1024x768! {} \;
```

The following command will resize an image to a width of 200:
```
convert example.png -resize 200 example.png
```

The following command will resize an image to a height of 100:
```
convert example.png -resize x100 example.png
```

# Delete all even or odd numbered file in the directory
```
ls --color=none *.png | awk 'NR % 2 == 1 { print }' | xargs rm -r
```

Here, the option `--color=none` makes sure that the output of `ls` produces text-only string for `awk` and does not produce terminal color characters (e.g. try `ls > testfile`).


# Disk repair/error check
 Linux kernels mount devices read-only when their filesystems have errors. You can repair the filesystem with:
``` 
 sudo fsck.vfat -y /dev/sdc
```

 
 (replace sdc by the right one)
 
# Very light http server: lightpd
 
 https://wiki.archlinux.org/index.php/lighttpd
 pacman -S lighttpd
 
 Config: /etc/lighttpd/lighttpd.conf
 Check if config file's syntax is correct: lighttpd -t -f /etc/lighttpd/lighttpd.conf
 Default location of index.html file: /srv/http
 
 To create the index.html file:
 echo 'TestMe!' >> /srv/http/index.html
 chmod 755 /srv/http/index.html
 
 Starting and reloading:
 systemctl start lighttpd
 systemctl reload lighttpd
 
 Enabling over boot: systemctl enable lighttpd

 To enable php, install php, php-cgi and then add the following to /etc/lighttpd/lighttpd.conf (Note: not inside conf.d/fastcgi.conf etc, unlike what the arch wiki for lighttpd says):
  # Make sure to install php and php-cgi. See:                                                             
  # https://wiki.archlinux.org/index.php/Fastcgi_and_lighttpd#PHP
  
  server.modules += ("mod_fastcgi")
  
  # FCGI server
  # ===========
  #
  # Configure a FastCGI server which handles PHP requests.
  #
  index-file.names += ("index.php")
  fastcgi.server = ( 
      # Load-balance requests for this path...
      ".php" => (
          # ... among the following FastCGI servers. The string naming each
          # server is just a label used in the logs to identify the server.
          "localhost" => ( 
              "bin-path" => "/usr/bin/php-cgi",
              "socket" => "/tmp/php-fastcgi.sock",
              # breaks SCRIPT_FILENAME in a way that PHP can extract PATH_INFO
              # from it 
              "broken-scriptfilename" => "enable",
              # Launch (max-procs + (max-procs * PHP_FCGI_CHILDREN)) procs, where
              # max-procs are "watchers" and the rest are "workers". See:
              # https://redmine.lighttpd.net/projects/1/wiki/frequentlyaskedquestions#How-many-php-CGI-processes-will-lighttpd-spawn 
              "max-procs" => 4, # default value
              "bin-environment" => (
                  "PHP_FCGI_CHILDREN" => "1" # default value
              )
          )
      )   
  )
 
 
 Finally, set  in /etc/php/php.ini
  cgi.fix_pathinfo = 1
 and systemctl reload lighttpd.service to have the effect of this new setting and test it works by the following php file content:
 <?php
 phpinfo();
 ?>

 To give php read/write access to a particular directory called 'data', do the following
 Find the user that runs the http process by
 ps aux | grep httpd
 In my case, the user is http and root. I'll give the access to http.
 (internet suggests other keywords such as www-data etc)
 Make the user owner of the directory 
 chown -R http:http /path/to/directory/data

 Displaying console output while running shell commands thorough shell_exec() in php: add 2>&1 at the end of the shell command.
 

 Error code display while running php:
 This is very useful while debugging but very dangerous while running because it is possible to figure out code from error messages. 

 Edit /etc/php/php.ini
 Change the line 
  display_errors = Off
 to
  display_errors = On
 Important: Do not forget to revert it later.

 Another way is to add the following codes to your php files:
 echo ('showing errors!');
 ini_set('display_errors', 1);
 ini_set('display_startup_errors', 1);
 error_reporting(E_ALL);


# Creating an access point in your system
 
 Link: https://bbs.archlinux.org/viewtopic.php?id=162895
 Download the create_ap directory from git or otherwise
 Not NAT or bridge needed. The script has options to set them or not.
 There are important dependencies. Check README or the create_ap file to find out.
 
 Running:
 
 systemctl disable netctl-auto@wlp6s0.service
 # So that is does not conflict with our .myscr file "wifi", where we enabled it)
 systemctl stop netctl-auto@wlp6s0.service
 # so that already running service stops as well, disabling it alone is hence not enough
 ifconfig wlp6s0 up
 # To bring the interface up (important)
 # Then enter the directory and see help to set up aps
 # For example, the share your LAN's internet through wifi access poing called "koboglo" with passphrase "lenovo1234"
 ./create_ap wlp6s0 eth0 koboglo lenovo1234
 
 
# Mounting unclean ntfs partition caused by windows
 
 install package called: ntfsprogs
 Then issue the command : ntfsfix /dev/sda1
 
# Reconnect wifi and reload firefox's latest tab 
 
 # Reconnect wifi
 wifi
 
 # Sending Firefox the reload command, CTRL+R
 xdotool search --desktop 3 --class "Firefox" key --clearmodifiers "CTRL+R"
 # Here, --desktop 3 is necessary without which xdotools was unable to activate
 # The Number 3 is because firefox is located in the 4th taglist in awesome window manager. The count goes from 0,1,2,3,4,.. etc
 # You can find the desktop number using: xprop | grep WM_DESKTOP
 # and then clicking on the window with mouse
 
 # Activating the firefox window
 xdotool search --desktop 3 --class "Firefox" windowactivate                                                        
 
# Turn off screen blackening/scrensaver:
 
 Turn off:
 
 xset s off
 
 To see the screensaver options:
 
 xset q
 
 To change screen timeout time to 1 hour:
 
 xset s 3600 3600
 

 
# Calculate the size of a directory including its subdirectories
The linux command `du` (see `man du`) estimates file space usage. To see the the total size of the directory `directory` along with all its subdirectories, do

 `du -sh direcory/`

 Here, the `-s` parameter shows the total sum of all the files and subdirectories and `-h` shows the result in a human readable format.

 To show the size of all directory and subdirectory in the current location in ascending order, use
 
```
du -sh ./* | sort -h
```

 Here, `sort -h` sorts in the human-readable format.

 This method does not show you the hidden files or directories. So, here is one trick to do exactly that:

```
du -sch .[!.]* * | sort -h
```

The parameter `-c` produces a grand total. The shell pattern following the parameters make sure we are searching for all files including the ones that start with a dot. Whatever. There is a program specifically made for disk analyzing and cleanup purposes and it is awesome. It's called [ncdu](https://dev.yorhel.nl/ncdu).
 Just install it and run `ncdu` and feel the wind.
 
# Print Screen in linux using imagemagick
 
```
import filename.png
```
 
 gives you a mouse pointer to click on the desired window to take a picture to filename.png.
 
 To take the full screen shot,
 
```
import -window root filename.png
```
 
 Numbering files so that they do not get overwritten (provided you take not more than one picture every second):
 
```
import -verbose -window root capture-$(date +%d-%h-%Y-%H-%M-%S).png
```
 
 In this case,
 
```
sleep 5; import -window root file.png;
```
 
 will be more effective.
 
 Does not work: Taking a screenshot of screen 0 (of DISPLAY 0)through some shell: If you log in through ssh and want to capture a screenshot at that moment, issue:
 
```
import -window root -display :0.0 -screen capture-$(date +%d-%h-%Y-%H-%M-%S).png
```
 
 
# Set up the correct time zone to avoid wrong date/time in Gmail/gtalk
 
timedatectl set-timezone Asia/Kolkata

For US, we can do
```
timedatectl set-timezone US/Eastern
```
Or, 
```
timedatectl set-timezone US/Central
```
(Note that these timezones are not available via autocomplete or listed in `timedatectl list-timezones`.)

You can check if the change is applied using

```
timedatectl status
```


 
* To see the current time date info,
 timedatectl status
 
 Doesn't work:To avoid the jumbled time over reboots between different OS like windows, force linux to use RTC time instead of it's usual UTC.
 timedatectl set-local-rtc 1
 
 Useful for now: Time synchronisation with a time server:
 timedatectl set-ntp true
 to activate this synchronisation, and to see if it is active:
 timedatectl status
 
 systemctl status chronyd.service
 should show the running daemon, but in this case, it is not working. Maybe you have to set it up. It launches a service which you can see by 
 systemctl status systemd-timesyncd.service  -l
 The Config file which has to be modified for this to work is:/etc/systemd/timesyncd.conf
 
 Final (standalone working solution):
 
 (a) Install ntp
 (b) Edit the config file: /etc/ntp.conf
 (c) Set up the right servers: By default it uses the arch severs and they should be enough. But for faster and/or more accurate syncing, we can use the indian servers which are up. The list can be found on: http://www.pool.ntp.org/
 
 For the time being, these are working:
 
 # indian and asian servers
 server 1.in.pool.ntp.org
 server 0.asia.pool.ntp.org
 server 2.asia.pool.ntp.org
 
 (d) Running the programme: A daemon is generally ran in the background so that the time can be synced all the time. But in our case, we only need to run it once whenever we need, without needing to write the daemon in the background. So, we run:
 
 ntpd -qg
 
 Here, -q is for one-time run. The -g parameter is very important since it allows ntp to sync time even when the time difference is significantly high.

 I guess it uses timezone info which should be preconfigured at your timedatectl. 

 (e) This process changes the system time only and NOT the hardware clock. That is why it does not persist over reboots. To keep this time, issue

 hwclock --systohc

 This actually sets the hw clock to be the local time. If you want to set UTC to be the hardware clock then use --utc along with --systohc.

 
 
# Show percentage bar while copying using cp
 (has to be a better way though)
 
 #!/bin/sh
 #
 # cpbar -- era 2008-05-21 for unix.com
 #
 # Depends:
 #  stat
 #  cp
 #  awk
 
 syntax () {
     echo "Syntax: $0 srcfile destfile" >&2
     echo " " "$@" >&2
     exit 1
 }
 
 test -r "$1" || syntax "File '$1' not found"
 test -d "$2" && syntax "Must name destination file ('$2' is a directory)"
 
 size=`stat -c %s "$1"`
 
 cp "$1" "$2" &
 cppid=$!
 
 trap 'echo; kill $cppid; rm -f "$2"; exit 127' 1 2 3 5 15
 
 while true; do
     nsize=`stat -c %s "$2"`
     awk -v f1="$1" -v f2="$2" -v size=$size -v nsize=$nsize '
 	BEGIN { printf "Copying %s to %s: %4.2f%%\r", f1, f2, 100*nsize/size }'
     case $nsize in $size) break ;; esac
     sleep 1
 done
 
 echo
 
 wait $cppid
 
 ###END
 
 
# Setting up static ip
 
 To set the ip and the netmask (subnet mask) (broadcast address will be set automatically, is it needed to change ever)
 
 ifconfig enp7s0 10.208.22.26 netmask 255.255.255.0 up
 
 Set the default gateway:
 ip route add default via 10.208.22.1
 
 Setting up dns:
 Edit the file: resolv.conf (beware: not resole.conf)
 Add the 
 nameserver 10.16.25.15
 
 
# To see the default programme for a certain filetype, we need xdg-mime.
 Note: now we can solve opening files through firefox download window.
 
 To get mime type of photo.jpg:
 
 $ xdg-mime query filetype photo.jpg
 
 photo.jpg
     image/jpeg
 
 Get default application
 
 To get default .desktop file starter for image/jpeg mime type:
 
 $ xdg-mime query default image/jpeg
 
 gpicview.desktop;
 
 Set the default file-browser
 
 To make Thunar the default file browser, i.e. the default application for opening folders:
 
 $ xdg-mime default Thunar.desktop inode/directory
 
 Set the default PDF viewer
 
 To use xpdf as the default PDF viewer:
 
 (wont work, read further)
 $ xdg-mime default xpdf.desktop application/pdf
 
 
 For a root user like myself, the above command won't work since I am not in one of those normal user scenario, so we will have to change the file
 /usr/share/applications/mimeinfo.cache
 and put the desired programme name.desktop as the first choice.
 Save the file and issue the xdg-mime query kind of command to check whether it worked or not. Worked for me.
 
 Example:
 Making ranger the default file manager:
 
 a. Target filetype is directory. We need the mime-type.
 
 file --mine-type -b random_directory
 
 We get the output: inode/directory. So, this is our target mime-type.
 
 b. Create a .desktop file for ranger. Save the following content in a file called ranger.desktop.
 
 [Desktop Entry]
 Name=Ranger
 Exec=ranger
 Terminal=true
 Type=Application
 MimeType=inode/directory;
 
 c. Install this .desktop file using:
 
 desktop-file-install ranger.desktop
 
 d. Check that this is installed in this location: /usr/share/applications/
 
 e. Now, make it the default application using (from any location):
 
 xdg-mime default ranger.desktop inode/directory
 
 f. Check that it is working using:
 xdg-open random_directory
 
 Note: There is an alternative to the step e. You can edit this file /usr/share/applications/mimeinfo.cache and manually type
 inode/directory=ranger.desktop;
 Or, you can engage many applications for one mime-type like this:
 inode/directory=ranger.desktop;thunar.desktop;nautilus.desktop;
 But the .desktop file which comes first becomes the default one.
 Note: Step e actually modifies  the file ~/.local/share/applications/mimeapps.list which is local (user-specific). Editing the actual /usr/share/applications/mimeinfo.cache actually applies to system-wide, but gets reverted on system update.
 
# Make the volume control for mplayer ( the keys 0 and 9) work, or make them independent of the system volume control:
 
 Create the file ~/.mplayer/config
 and add this line to it:
 softvol=1
 
 
# Reducing your screen brightness and add red colour at night so that you can fall asleep better, or not get blinded by electronic devices (like twilight in Android)
 
 Run it from command line or with systemctl.
 Set the latitude and longitude of your location in the config file:
```
 ~/.config/redshift.conf
```
 Set the screen to be 0, and other things. Set the colour temperature also.
 
 
# Managing tasks task warrior
 
 Install. It's called just task. pacman -S task
 Then run it. You'll be prompted to create the config file. Say yes.
 Modify the .taskrc file to use the light-256 theme, that works best with white terminal background. If you ever consider shifting to darker terminal, maybe explore the other themes, recommended: dark-256, obviously.
 
 git add the files .taskrc, and the directory .task so that you can have them forever.
 
 Basic commands: 
 Create a task: task add "Name of the task"
 List the tasks: task
 Mark a task done: task ID done (IDs are 1, 2 3, ... etc)
 Delete a task (including one that is done): task ID delete
 Modify a task name: task ID modify "new and modified task description"
 Add comments to already-existing task description (annotate): task ID annotate "and another thing"
 Add more info to a task: task ID modify project:projectname due:duedate
 Modify many tasks to add a common project name: task ID1 ID2 ID3 modify project:projectname
 Schedule a task to automatically disappear after a given time: task 1 modify until:eoy
 Schedule a task to automatically appear after a given time: task 1 modify wait:30th
 
 Modify(e.g. change tagnames) a set of tasks by some attribute(e.g. project) : task project:projectname modify +tagname
 
 Print [next] tasks with specific attributes:
 
 print all the tasks in the "prj" project name: task project:prj
 print all the tasks in the "prj" project name and empty tag name: task project:prj tag:
 take all the tasks with "prj" project name and empty tag name and give them the tag name "newtag": task project:prj tag: modify +newtag
 print all tasks which are started: task started (write "task reports" to see all possible options)
 
 Now, some more info, to be better: http://taskwarrior.org/docs/best-practices.html
 
  Assign a project to your tasks if possible:
 
 task ID modify project:Home
 
 Assign due dates where appropriate, for the important tasks:
 
 task ID modify due:31st
 
 When you start working on a task, mark it started:
 
 task ID start
 
 If you know the priority of a task:
 
 task ID modify priority:M
 
 Add useful tags to a task:
 
 task ID modify +problem +house
 
 Add the special tag +next to a task, to boost its urgency:
 
 task ID modify +next
 
 Represent dependencies, where appropriate, because there is a big difference in the urgency of a blocking task, than that of a blocked task:
 
 task ID modify depends:OTHER_ID
 
 Try not to have large, long-term tasks that will sit on your list forever. It can be very satisfying and motivating to complete tasks, so create more, but smaller, tasks. 
 
  
 Adding due dates:
 
 The rules for date and time format can be changed from rc.dateformat setting (find out how to change it), but the default setting is the British Convention.
 example:
 
 task add Open the store due:2015-01-31T08:30:00
 task add Pay the rent due:eom
 
 Other handy commands that can be used to mention due date/time:
 
 Date & Time
 
 Taskwarrior supports date and time values. Date fields are used to track task creation, due date, scheduled date, end date and so on, as well as providing a date type for use with UDA fields.
 
 Whichever format is used to accept and display date and time, Taskwarrior resolves it to a UTC epoch value, accurate to one second. This is called Unix Time, POSIX time, or Epoch time.
 
 But you have full control over the format entered and the format displayed, and this document is a demonstration of this.
 Due Date Example
 
 Let us begin with an example of specifying a due date when the task is created:
 
 $ task add Pay the rent due:2015-01-31
 
 Or adding a due date to an existing task:
 
 $ task add Pay the rent
 $ task 1 modify due:2015-01-31
 
 Finally removing a due date from a task:
 
 $ task 1 modify due:
 
 This examples uses the default rc.dateformat, which is Y-M-D, to read the date from the command line.
 rc.dateformat
 
 The rc.dateformat setting allows you to specify other formats for date input. An example is the default, Y-M-D, which means a date is:
 
     a 4-digit year ('Y')
     followed by a hyphen ('-')
     followed by a 2-digit month ('M')
     followed by a hyphen ('-')
     followed by a 2-digit day ('D')
 
 Here are the possible elements of rc.dateformat:
 
 m 	1 or 2 digit month number, eg '1', '12'
 M 	2 digit month number, eg '01', '12'
 d 	1 or 2 digit day of month number¸ eg '1', '12'
 D 	2 digit day of month number, eg '01', '30'
 y 	2 digit year, eg '12', where the century is assumed to be '20', therefore '2012'
 Y 	4 digit year, eg '2015'
 h 	1 or 2 digit hours, eg '1', '23'
 H 	2 digit month hours, eg '01', '23'
 n 	1 or 2 digit minutes, eg '1', '59'
 N 	2 digit minutes, eg '01', '59'
 s 	1 or 2 digit seconds, eg '1', '59'
 S 	2 digit seconds, eg '01', '59'
 v 	1 or 2 digit week number, eg '1', '52'
 V 	2 digit week number, eg '01', '52'
 a 	3-character English day name abbreviation, eg 'mon', 'tue'
 A 	Complete English day name, eg 'monday', 'tuesday'
 b 	3-character English month name abbreviation, eg 'jan', 'feb'
 B 	Complete English month name, eg 'january', 'february'
 Everything else 	All other format characters are taken as literals
 
 Including Time
 
 Using rc.dateformat you can specify a date with or without elements that include time. If your dateformat omits any time elements, then you just specify the date, and the time defaults to 00:00:00.
 
 An example shows this using a temporary override:
 
 $ task add Pay the rent due:2015-01-01
 $ task 1
 
 Name          Value
 ------------- ------------------------------------------
 ID            1
 Description   Pay the rent
 Status        Pending
 Entered       2015-01-02 16:57:44 (8 seconds)
 Due           2015-01-01 00:00:00
 Last modified 2015-01-02 16:57:44 (8 seconds)
 UUID          6eb7c4d7-6323-4ee3-bf13-63c580de3712
 Urgency       9.58
 
 $ task add Open the store due:2015-01-01T08:30:00 rc.dateformat:Y-M-DTH:N:S
 $ task 2
 
 Name          Value
 ------------- ------------------------------------------
 ID            2
 Description   Open the store
 Status        Pending
 Entered       2015-01-02 16:58:15 (6 seconds)
 Due           2015-01-01 08:30:00
 Last modified 2015-01-02 16:58:15 (6 seconds)
 UUID          bc8f9b89-8dea-4dae-87e5-b320b651c25c
 Urgency       9.419
 
 The first task added used the default rc.dateformat value of Y-M-D. You can see that the due date was recorded with time 00:00:00.
 
 The second task added specified an rc.dateformat override value of Y-M-DTH:N:S. You can see that the due date was recorded with time 08:30:00, as specified.
 
 You can specify date, or date + time, but whatever you specify must match your rc.dateformat setting.
 Reports
 
 The rc.dateformat setting is used for both specifying dates on the command line, and displaying them in reports. Most reports allow a further override, for report-specific display formats, such as rc.report.REPORT.dateformat, but there are others. See man taskrc for a complete list.
 
 For display purposes, there are two additional elements:
 
 j 	1, 2 or 3 digit day-of-year number, sometimes referred to as a Julian date, eg '1', '11', or '365'
 J 	3 digit day of year number, sometimes referred to as a Julian date, eg '001', '011', or '365'
 
 Synonyms 2.4.0
 
 In addition to formatted dates, you can use a date synonym instead:
 
 $ task add Pay the rent due:eom
 
 Here the synonym eom means 'end of the month'. Synonyms are a useful shortcut to entering lengthy dates. Here is the full set:
 
 now
 today 	
 sod 	
 eod 	
 yesterda
 tomorrow
 monday, 
 january,
 later, s
 soy 	
 eoy 	
 soq 	
 eoq 	
 som 	
 socm 	
 eom, eoc
 
 Here, eo=end of, so=starting of (the next), soc=starting of the current, d=day, w= week, m=month, y=year, q=quarter etc. See http://taskwarrior.org/docs/dates.html for more details.
 
 
  A recurring task is a task with a due date that keeps coming back as a reminder. Here is an example:
 
 task add Pay the rent due:1st recur:monthly until:2015-03-31
 
 
 To get rid of unnecessary info that is displayed, this page can be a lifesaver:http://taskwarrior.org/docs/verbosity.html
 
 The most useful info are:
 
 Adding the line
 verbose=no
 to the file .taskrc will help you get rid of the footnote and header.
 
 Here is an example of a custom report called "verybasic" which contains very specific columns that we want, in our desired order. Either add the following lines to .taskrc or add "task " to the beginning of every line and run individually in terminal (both have the same effect):
 
 report.verybasic.description='A list with very basic information, created by me.'
 report.verybasic.columns=id,project,tags,description.count,due
 report.verybasic.sort=start-,urgency-
 report.verybasic.filter=status:pending
 
 To make this report your default output report, add to your .taskrc:
 default.command=verybasic
 
 or, issue this command in terminal: task config default.command 'verybasic'
 
 To see this custom report in action, just run "task verybasic". Detailed documentation found at: http://taskwarrior.org/docs/tutorials/report.html
 
 To undo a change that you have made:
 task undo

 Task warrior has a very good calendar display with useful info showing. Use
  task calendar
 You can combine more commands to generate desired output.
 
 A task warrior front end vit. Compile from the AUR.
 I run into problems: vit freezes while I want to make any task done, or delete etc. Magically, it disappeared when I did this:
 I had a user-defined custom report which was not created carefully. I don't know which one was missing, but I recreated one from the "next" report, (only deleted some fields) and now it works fine. I think, the description.count was converted to description only. But I have to verify.
 
 Syncing your tasks through a remote server and have it on android:
 
 The website freecinc website provides a service to host your tasks so that you do not need to set up your own server (although, one day, I will set it up, when I have my own website). To use this, simply log in to the website and follow their instruction. After you are done, in order to sync manually, run "task sync" in your client and done. To automate it, add this to your crontab -e:

# Syncing task warrior
 3 */2 * * * task sync && notify-send "Syncing Tasks"
 and send a littel notification every time.
 
 In android, the app Mirakel gives you a way to upload a specially created config file so that you can sync with your server (freecinc, in this case). Format of this config file:
 
 
 username: foo
 org: bar
 user key: aa0f8f67-c20c-4476-b1c4-ed72f293006c
 server: localhost:6544
 client.cert:
 -----BEGIN CERTIFICATE-----
 …
 -----END CERTIFICATE-----
 Client.key:
 -----BEGIN RSA PRIVATE KEY-----
 …
 -----END RSA PRIVATE KEY-----
 ca.cert:
 -----BEGIN CERTIFICATE-----
 …
 -----END CERTIFICATE-----
 
 Get your username, org and server from the line starting with "taskd.credentials=" in the file ~/.taskrc. The format of that line is 
 	taskd.credentials=org\/username\/user_key (note that the org comes before the username)
 Get your server from the line staring with "taskd.server="
 Finally, insert the contents of the file `*.cert.pem`, `*.key.pem`, `*.ca.key`.
 Save it with any name and send it to the mobile phone so that you cam import it into mirakel.


 Tips:
  Use arithmetic operations in attributes:
  	task add newtask due:2days scheduled:due-1day

 
 My new favourite is inthe.AM. This one has a web frontend as well as a nice server. Works similarly. You have to login with your email.

 To use Mirakel effectively, I use these UDAs which are defined in my taskrc:
  

 
# Very nice image viewer with nice features (better than feh, except for the zooming part)
 
 pacman -S sxiv
 
 See then manage to see all the controls, most are very useful, similar to the vim keybindings, useful ones are:
 
 Enter to see the thumbnail mode
 w,W to best fit
 e,E to  fit image to height, width
 = to show 100%
 3j to scroll 3 times j
 85= to show it 85%
 b to toggle bars
 
 Question: how to delete the thumbnails generated? Where is the cache file?
 Answer: ~/.cache/sxiv
 
 Tips: Support opening .gifs: use `sxiv -a *.gif`
 Open all images recursively(means including subdirectories) in the current directory: sxiv -a -r .
 
 
# Making whole linux dark
 
 (I) Firefox:
 
 Change the firefox default page colors to dark background and white/yellow text
 
 Install plugin: Dark Backgrounds Switcher
 
 Change the menu bar and other components of firefox, without any plugin (developer option, from firefox 35 onwards, lucky me)
 Open about:config and look for the string: browser.devedition.theme.enabled
 Make it true by double clicking on that value.
 Press F12 to open developer mode, click on the wheel button on upper right corner, which is the Options button, scroll down to find "Dark Theme".
 
 
 (II) Xterm:
 
 Change the terminal color: Edit the file .Xdefaults and add the following lines if do not exist:
 ## color scheme for xterm
 #xterm*background: grey11
 #xterm*foreground: cornsilk1
 
 (III) Vim:
 
 Edit vim's spell check highlight color:
 Changing the colors scheme altogether is the key. Add this line to .vimrc:
 
 colorscheme slate
 
 This scheme seems nice for now, shift to better one when possible.
 
 (IV) task warrior
 
 In .taskrc, uncomment dark-green-256 theme.
 
 (V) Vimperator statusbar
 
 You have to set the colorscheme, can be downloaded other people's or use my own. Coming soon, or will be uploaded to github.
 
 (VI) Zathura
 
 In .config/zathura/zathurarc, add the lines:
 
 set recolor-darkcolor "#93A1A1"
 set recolor-lightcolor "#002B36"
 Now either add the line to the file
 set recolor true
 or issue it inside the programme to activate it.
 
 
# Remove mouse module and insert again to disable/enable mouse:
 
 rmmos psmouse
 removes the mouse
 
 modprobe psmouse
 inserts it back, have to wait for 5-6 seconds.
 
 
# Play video as background through mplayer
 
 mplayer video.ogv -rootwin -vf scale=1280:800 -noconsolecontrols
 
 
# Copying between terminals:
 
 Theory: Shift+Insert:
 
 Whatever is selected, be it by mouse or visual mode in vim, goes to the buffer. That means, copying to the buffer is done. No need to copy separately. That means, no need to press y to yank after selecting in vim, no need to press Ctrl+C in Firefox.
 Shift+Insert pastes. 
 Tips: avoid selecting anything else in the meantime at all costs.
 
 Theory: Ctrl+C:
 
 So, you are selecting a string before pressing Ctrl+C. Selecting it makes it available for Shift+Insert. Also, it makes it available for Ctrl+V also. So, both will give you same results.
 
 However, do the following, you'll end up with two different buffers to use whenever possible:
 1. Select text_a in firefox (text_a goes to Shift+Insert Buffer)
 2. Press Ctrl+C (text_a goes into Ctrl+V buffer)
 3. Select text_b (text_b goes into Shift+Insert buffer)
 
 Now, in firefox text field, you get the following:
 
 Shift+Insert -> text_b
 Ctrl+V 	     -> text_a
 
 But in xterm, you have only Shift+Insert available, so only text_b is available to you for terminal.
 
 Both of them are X commands.
 
 So, copying from firefox to terminal or vim is easy.
 What about the other way round?
 The only thing everybody talks about is the using screen. It gives you the functionality to copy-paste between different instances terminals within screen through some really weird key strokes.
 
 
# The solarized color palate has some nice symmetry. You just invert it and start from the top, removing the base color and stop wherever needed. The only benefit is that you can interchange between the dark-light schemes very fast.
 
 You can set the colors in the .Xresources file and done. The vim colorscheme will do the rest of the work. Beware though: xterm does not support many boldface colors for many colorcodes. So, you will have to change either the termianl, or the colors.
 
 In .Xresources file, replace all the colors in #define section with the TERM hex-codes, which you will find in the comment section. The result is not blues, though. But you will be able to use all the shades of grey, which is nice. Currently I am trying to look for replacements for the colors that are not supported
 
# GTK+ bookmarks:
 While locating file through GTK+ dialog box (e.g. "Save as" in Firefox or GIMP), you might want to create a "bookmark" of a directory that you want to access with one click. So generally you can drag and drop those directories to the left pane and they stay there. These locations can be saved/modified/added through the file ~/.gtk-bookmarks
 
# Loading the new .Xresources
 
 xrdb ~/.Xresources
 
 
# Using wicd
 Install wicd, wicd-gtk
 
 Run wicd
 Run dhcpcd on the wlan card: dhcpcd wlp6s0b1
 Finally, run wicd-gtk
 
 Then connect.
 
# Youtube viewer and downloader for terminal
 
 pacman -S youtube-viewer youtube-dl
 
 To launch, youtube-viewer
 or,
 youtube-dl URL
 
 See the manpage for more details.
 
# Simple client-server using netcat
 
 Important: Must install openbsd-netcat. I accidentally installed the gnu-netcat and it did not support many of the commands and the standard examples given in the internet failed.
 
 After installation, use it using nc.
 
 Open a listening port in the server: ( -l for lsten, -v for verbose)
 
 nc -l -v 1432
 
 Connect to the server
 
 nc server_name_or_ip 1432
 
 If it succeeds, cursors in both the computers will wait. Now type text in one to send it to the other.
 
# Pacman stuff:
 
 Instead of keeping track of every package you are installing using pacman, issue this to show all explicitly installed packages:
 
 pacman -Qei
 
 Note: -Q is the query mode, -e for explicitly installed, -i for detailed info about the packages.
 Now you can use grep, awk, sort etc to do whatever you want with them.
 
 To find all the orphan packages, issue
 
 pacman -Qdt
 
 Here, -d shows all the packages which were installed as a dependency of another packages. -t shows that are not required anymore.
 
# DNS server using ngrok and tcp tunelling (for sshing into the local machine):
 
 Download the ngrok software (Note; Do NOT install it through AUR as it is old)
 Extract it.
 At this point, you will be able to use http server using
  ./ngrok http 80
 In order to use ssh, you need to create an account. I logged in using github account  and did not have to create a account.
 Next step is authenticating the key that they provide you. It will be written in that login page only. Do that.
 Run the tcp tunnel using
  ./ngrok tcp 22
 Now you can log in to you local server using the global hostname:port that thy show in the forwarding tab.
 To get hold on this port number (so that you can dump it and git commit it), you need to do the following:
  wget http://localhost:4040/
  (Here, we are collecting the source code of the client API that ngrok creates for monitoring purposes)
  We get the index.html page in this process. Now we extract the address from it like this:
```
   cat index.html | grep "tcp://" | awk -F"/" '{print $3}' | awk -F"\\" '{print $1}'
```
  Now, we can easily update (git commit) this info so that we can access from anywhere. I mean, create a script to run ngrok and git commit together to dump this port information along with uploading it (to the git repo to use somewhere else)
 
# Cleaning up your Arch system
 
 1. Delete the log files.
 One big file is /var/log/journal
 You can delete its content but NOT the directory itself to temporarily make the boot process fast. 

 To set a global limit of maximum size of journal files, edit the file
 /etc/systemd/journald.conf
 and set

 SystemMaxUse=50M

 Delete /var/log/wtmp and wtmp.1 files for last login etc. Note: the command 'last' does not work. Will it work after reboot?

 2. Pacman old packages in cache
 There are nice commands for that which can be found in another topic.

 
# MTS Mblaze activation using usb_modeswitch
 
 Install the package usb_modeswitch. Reboot. It should work. If it doesn't:
 Do lsusb and look at the device and vendor number. I got 
  Bus 002 Device 005: ID 12d1:1f01 Huawei Technologies Co., Ltd. E353/E3131
 Here, we need the number 12d1:1f01. Which is our DefaultVendor:DefaultProduct.
 If we are lucky, we can find what command to pass by looking at
  /etc/usb_modeswitch.setup
 Here, search for this number and copy the whole section. I got:
 
 ########################################################
 # Huawei E353 (3.se)
 #
 # Contributor: Ulf Eklund
 
 DefaultVendor= 0x12d1
 DefaultProduct=0x1f01
 
 TargetVendor=  0x12d1
 TargetProduct= 0x14db
 
 MessageContent="55534243123456780000000000000a11062000000000000100000000000000"
 
 # Driver is cdc_ether
 NoDriverLoading=1
 
 ########################################################
 
 Now, we just put this whole thing inside /etc/usb_modeswitch.conf. (Note: pasting these line after the content of the file did not work. I Deleted everything and then pasted it.)
 
 Now launch the programme using 
 usb_modeswitch -c /etc/usb_modeswitch.conf
 And it worked. Now you can lsusb and see that the numbers have changed.

 Note: this the manual process and for some reason it doesn't work automatically. The method that worked for me is this:
  uninstall usb_modeswitch: pacman -R usb_modeswitch
  Reboot: reboot
  Install: pacman -S usb_modeswitch
  Reboot: reboot
 The rebooting are important because /lib/udev/rules.d/40-usb_modeswitch.rules get modified and the effects are applied on reboots.
 
# Applying particular config file to a particular file in vim
 
 Create a somefile.vim containing settings for the file. (Only the ones OTHER THAN the main ~/.vimrc)
 Run it with -S param.
 vim -S somefile.vim filename
 
# Calculating with bc
 
 Run bc and calculate away, but it is very important to remember these things:
 Issue "scale=5" to let bc use 5 digits after the decimal point. Otherwise it will show you ridiculous things like 10/3=3 etc. By default, scale is set to 0 so floats are treated as int.
 Use "last" to refer to "Ans", which is the last number is buffer.
 You can declare variable and do their calculations like this:
  a=50
  b=30
  c=a+b
  c
  80
 etc.
# Conky with ring-shaped clock
 
 Install conky-lua-nv (with lua and nvidia support) from AUR.
 Install xcompmgr for transparency. (Have to run while conky runs)
 Install the font Santana. Download and extract, then move the folder to /usr/share/fonts/ then fun fc-cache -vf.
 Running conky with a config file settings.conf: conky settings.conf
# Reverting a file or directory to its previous state in git (Or, restoring deleted files :P)
 
 First, stop any automated git commits by commenting out the necessary lines in crontab -e, or something else.
 Next, find out the right commit you want the file to be reverted to using
  git log filename
 Here, you should note down the commit number. Let's say it is abcdef
 Now, get it back using
  git checkout abcdef filename
 
 Done. Now git commit to make this change permanent. Resume your crontab based auto-commit.
 
# Vim plugin Pathogen
 Follow instructor  from git.
# Using Ledger, the money management program
 Install ledger from AUR, pretty long compilation time.
 Install the plugin vim-ledger (preferably using Pathogen. See prev entry)
 
     Entering data in a .ledger file:
	 Enter today's date using <F6> (added a line in .vimrc to use strftime())
	 Auto-completion of the account names: Ass:Ch<C-X><C-O> gives Assets:Checking.
	 zM and zR  to fold and show all folds as usual.
	 There is aligning feature that I am yet to get used to.
	 And automated currency insertion is there too.
     
     Useful things to include:
     	Include directives, so I can keep my business data in its own file, while pulling it into my main one.
	Simple refactorings, like putting "Y 2012" at the top, so I don't have to write the year in each transaction.
	Account aliases, so I can just type "rent", rather than "income:rental" and "repairs:contractor" rather than "expenses:home repair:contractor"

     Reports:
     	Shows balance of all accounts starting with expenses since last October, sorted by total:
		ledger -b "last oct" -S T bal ^expenses
	Shows the register of expenses with multiple entries combined (totalled):
		ledger  register expenses --collapse
	See weekly postings: -W (for register mode)


	
# Replacing entries in file with another one
 
 # sed -i 's/\/sbin\/resolvconf/\/usr\/bin\/resolvconf/g' vpnc-script
 
 Note: Can be used for config files containing Solarized color palette.
 
# Connect to a VPN to have their external ip to use MathSciNet and stuff
 
 openconnect go.vpn.gwu.edu
 
# Dumping or redirecting your microphone feed through ssh
 arecord record the sound in CD quality in raw format

 arecord -f cd -t raw

 oggenc (need vorbis-tools for this) encodes the raw stream into ogg format (compression for low datarate)

 oggenc - -r 

 (note the extra - for some reason, check manpage)

 Finally log in to a remote ssh host and use their mplayer to play this encoded stream

 ssh user@host mplayer -


 Everything together:

 arecord -f cd -t raw | oggenc - -r| ssh user@host mplayer -

# Display the webcam feed with mplayer (play the webcam):
 
  mplayer tv:// -tv device=/dev/video0

 where /dev/video0 is the device.
 
98. Connecting another host though lan cable and  give it an ip address though dhcpd
 Install dhcpd ( note: it is not dhcpcd and is not installed by default)
 If the host (laptop) is going to have the ip 139.96.30.100, do the following.

  ip link set up dev enp7s0
  ip addr add 139.96.30.100/24 dev enp7s0

 Here, enp7s0 is your (laptop/server's) ethernet card. 
 ifconfig to check that the card really got the ip.

 Now we are going to follow what the archwiki page of dhcpd says.
 
 The config file should have the following:

	option domain-name-servers 139.96.30.100;
	option subnet-mask 255.255.255.0;
	option routers 139.96.30.100;
	subnet 139.96.30.0 netmask 255.255.255.0 {
	  range 139.96.30.150 139.96.30.250;
	}
 
 In this case, the dns is the server. The subnet mask has to be consistent with the ip range, whatever that means.
 You can also attach a static ip to a particular device if you like, by modifying the subnet "block" like this:

	 subnet 139.96.30.0 netmask 255.255.255.0 {
	  range 139.96.30.150 139.96.30.250;

	  host macbookpro{
	   hardware ethernet 70:56:81:22:33:44;
	   fixed-address 139.96.30.199;
	  }
	}	
 
 Finally, create the service file to run dhcpd though systemctl.
 /etc/systemd/system/dhcpd4@.service

	[Unit]
	Description=IPv4 DHCP server on %I
	Wants=network.target
	After=network.target

	[Service]
	Type=forking
	PIDFile=/run/dhcpd4.pid
	ExecStart=/usr/bin/dhcpd -4 -q -pf /run/dhcpd4.pid %I
	KillSignal=SIGINT

	[Install]
	WantedBy=multi-user.target

 To run this dhcpd on the network interface, run
	systemctl start dhcp4@enp7s0.service

 Now attach the other device to the server/laptop with a typical lan cable and see the lights flash. After some time, issue:
	ip neigh show
 You can see the other device's ip listed there. Most probably it will have the first ip possible, which is 139.96.30.150.
 Edit: ip neigh show does not show all the ips. cat /var/lib/dhcp/dhcpd.leases  might show some useful information.

* When ssh-ing to an user does not give you access to .bashrc
Do the following: 
Edit .bash_profile and add 
```
 	 	if [ -f ~/.bashrc ]; then
		  . ~/.bashrc
		fi
```

# How to connect to hdmi
 xrandr 
   to find the HDMI connection. In this case, it is called HDMI-0
 xrandr --output LVDS --off --output HDMI-0 --auto
 Click on the checkbox " Mathe this the default X-Server screen" while selecting the external display.
 
 See the list of connected displays with 
  xrandr --current
 Set the HDMI0 to be the biggest screen and current laptop screen to be a small part of it by
  xrandr --output HDMI-0 --auto
 
 Turn off the hdmi temporarily with 
  xrandr --output HDMI-0 --off
 
 HDMI -Audio
 
 Use aplay -l to get the discover the card and device number. For example:
 
 $ aplay -l
 
 Now try different number to see which one actually works by
 
 $ aplay -D plughw:1,3 /usr/share/sounds/alsa/Front_Center.wav
 
 In my case, 1,3 works. Now Edit the .asoundrc to 
 
 pcm.!default {
     type hw
     card 1
     device 7
 }
 
 If Kodi cannot play audio with all the hdmi devices, try
 alsactl restore
 or alsactl kill quit and alsactl init

# Speeding up the internet using the fastest DNS server
 Install namebench. 
 There is a AUR repo for namebench. But it needs python2-graphy, which has to be installed from AUR first.
 After installing, run using: namebench.py
 After the test is finished, it will generate some results. You can visualize the data by opening the .html file that is generated in /tmp.

 In the router, go to My Network > Network Connection > Broadband Connection > Settings > DNS Server: Use the following DNS server (from dropdown) and set it.

 If using pi-hole to block ads, use the fastest DNS as the second DNS server. The first one should be the ip address of the Pi running a pi-hole.

# Google drive client for linux:
 A git-like command line tool called drive (https://github.com/odeke-em/drive) has implemented all the features though auth2 secret key.
 Follow the instructions in its readme file, run
 	drive init ~/gdrive
 to start the service. In the command line, it will give you alink to vist to get a secret_key which you enter in the command line.
 After that pull, push etc covers everything, Look at the Readme in the github for all information.

 After drive init, go to the directory you initiated drive and then
 	drive pull 'directory name'
 pulls all the files, directories etc of 'directory' name.

 Similar to git, to push files to drive, you can create subdirectory inside the local gdrive structure. For example,
 	cd ~/grive
	mkdir new-folder
	cd new-folder
	cp ~/newfile ./
	drive push
 Be aware, if you do not have a copy of the remote files in the local location, drive push will delete the ones that are not present in the local path or in its children.
 
 Issue: the authentication token expires occasionally, forcing you to follow some link, clicking on "Accept" and generate token, copy-paste it to the terminal window.
 
 Deleting files from drive:
 
 Either 
 	drive trash 'file to be trashed'
 
 Or, remember the name (with path) of the directory you want to delete. rm -r in local path. Then
  drive push 'path to the deleted file'
 to delete it remotely.
 
 To empty trash 
 	drive emptytrash
 
 To permanently delete files without trashing it first (no need because I have infinite space in my institution-given drive) use
 	drive delete 'file to be deleted forever'
 
 To list files upto 1 depth inside some directory
 	drive list
 
 To list files upto 3 directory depth
 	drive list -depth 3
 
 You can use strings to look for while listing
 	drive list --matches mp4 pdf mp3
 
 To first sort by modTime, then largest-to-smallest and finally most number of saves inside the directory Photos
 	 drive list --sort modtime,size_r,version_r Photos
 
 To see stats of a directory recursively
 	drive stat -r 'directory name'
    or until depth 3
    	drive stat -depth 3 'directory'
 
 drive allows you to create an empty file or folder remotely Sample usage:
 
 $ drive new --folder flux
 $ drive new --mime-key doc bofx
 $ drive new --mime-key folder content
 $ drive new --mime-key presentation ProjectsPresentation
 $ drive new --mime-key sheet Hours2015Sept
 $ drive new --mime-key form taxForm2016 taxFormCounty
 $ drive new flux.txt oxen.pdf # Allow auto type resolution from the extension
 
 Show all information about your drive account
 	drive quota
  in more detail
 	drive about
 
 drive allows you to copy content remotely without having to explicitly download and then reupload.
 
 $ drive copy -r blobStore.py mnt flagging
 
 $ drive copy blobStore.py blobStoreDuplicated.py
 
 To perform a rename:
 
 $ drive rename url_test url_test_results
 $ drive rename openSrc/2015 2015-Contributions
 
 drive allows you to move content remotely between folders. To do so:
 
 $ drive move photos/2015 angles library archives/storage
 
 Command Aliases
 
 drive supports a few aliases to make usage familiar to the utilities in your shell e.g:
 
     cp : copy
     ls : list
     mv : move
     rm : delete
 
 The url command prints out the url of a file. It allows you to specify multiple paths relative to root or even by id
 
 $ drive url Photos/2015/07/Releases intros/flux

### Fixing clashes
* List the clashes with
```
drive clashes list <path>
```
* Resolve the clashes with
```
drive clashes -fix <path>
```
 
 101. OpenFOAM
 
 http://openfoam.com/download/install-binary.php
 
 Follow this tutorial and after running openMesh, you get an error. 'pwd' to see you path, 'cd cavity' and run again to resolve.
 
  While running, systemctl start docker in the beginning and do everything else.

# Moving /root to another partition
 Create new ext4 partition, say /dev/sda7. Mount it in a directory, say /otherlin
 Copy all data from /root to /otherlin using the following commands
  cp -urp /root/. /otherlin/
 Note that -r for recursive copy and -p is to preserve permission, date etc.
 Here, -u means update, i.e. doesn't overwrite already copied files. 
  Note that, cp -rp ~/* /otherlin
  	is not enough since it does not copy the dot files.
 Alternative tools suggested: rsync, and curl (nice use!) to have a progress bar etc.
 Find the UUID for the new partition using
  bkid
 Edit /etc/fstab and add the line
  UUID=daef66f2-4c7a-4daa-9d7d-f217a3a3994f	/root         	ext4      	rw,relatime,data=ordered	0 2
 Here, the UUIS should be replaced by the appropriate one.
 0 means it doesn't have to be backed up. 2 means the system checks the partition after the first one (1 is / so / gets checked first; 0 means no checking).

 Back up the current /root by 
  mv /root /root.old
 It failed the first time and had to uncomment the new line in fstab and reboot and try again to succeed.
 Remount all the drives by
 mount -a
# Fixing boot after erasing grub
 Install another linux, for example, Manjaro from USB livecd. It will come with its own grub. While booting through this new grub, if you get an error saying the UUID does not exist etc, edit the /boot/grub/grub.cfg file. Fix the UUID in the menuenry for the target linux. Usually, the the correct UUID appears in the first line, but in the lines containing the intiramfs, the UUID is messed up. Fix them in all the places. The config file should use the UUID of the old install, not the new one.
 
# Writing a manpage
 It uses something called troff markdown language.
 Create a file starting with the following lines and open with
 	man -l filename.

 Body of the manpage:
 .Dd date-of-modification
 .Dt name-of-the-article 7 (7 for miscellaneous manual. see man man for explanation)
 .Sh NAME
 .Nm name of the article
 .Nd description of the article
 
 Caution
     ·   Keep codes in within a .Bd -literal ... .Ed block.
     ·   Do NOT write Em anywhere in your text, it will vanish. Write \&Em
         instead.
   Frequently used macros
     .Sh           New Section
     .Ss           New subsection
     .Bl           begin list. It can take the following parameters: -bullet,
                   -item, -enum, -tag, -hang etc.
     .It           items inside .Bl and .El
     .El           end list
     .Pa           path for a filename
     .Bd           begin a display block, It takes a few parameters, most importantly -literal which is useful for source codes, spaced and tabbed text.
     .Dl           literal text of one line
     .Ed           end display block one line of literal text.
     \fB           begins bold
     \fI           begins Italian
     \fR           ends bold and/or Italian
     .Em           emphasize (a line of bold, similar to \fB ... \fR). If using
                   inside an item of list, use without the dot, e.g.  .It Em tagname

  escape chars  \e generates a \, \& replaces at the beginning of a sentence,
                   but doesn't generate a .

                   Type        Output
                   \e            \
                   \efB          \fB
                   \&.           .
                   \&Em          Em

     See the BSD manpage for mdoc online. (Note: mdoc for Arch is something else)
     http://man7.org/linux/man-pages/man7/mdoc.7.html

     Some examples:
     http://manpages.ubuntu.com/manpages/trusty/pt/man7/mdoc.samples.7.html

     There is a way include a custom file to man database.

# Unity 3D
 Install linpng12 from AUR.
 
 Install unity 3d from AUR. Note: The package build is 11GB  after makepkg -s and creates a .sh file and a directory. Instead of pacman -U, use the generated install script as there will be no .xi file to install. This is also an advantage since these files can be moved to another partition and launched. These are 3GB long.
 
 Watched tutorial on game rolling the ball on their official site.
 Lessons:
 A "is Trigger" object with a "Rigid body" component is a "Dynamic collider" and uses more resources.
 A "is Trigger" object without"Rigid body" component is a "Static  collider" is ideal. Setting "kinemetic" field will give you desired result.
 
# Progress bar for cp, firefox download, dd, tar, cat
 Use 'progress'.  https://github.com/Xfennec/progress
 See man page for details.
 
# wpa_supplicant
 Find the network by scanning
  iwlist wlp6s0b1 scan | grep ESSID
 The list is NOT ordered according to signal strength.
 or, use wifi-menu but cancel it after it finds the ssids.
 
 To create a config file, see manpage of wpa_supplicant.conf
 
 Works only for home wifi (have to check for work wifi): If you do not want to store the password and create a config file, use wpa_passphrase
 wpa_passphrase ssid_name
 you shall enter the passphrase from stdin and will be encrypted.
 Now copy the code from the file and create a config file. Delete the commented line containing the actual password.

 Alternatively, you can do the following:

 For home wifi, this works:
 network={
               ssid="home"
               psk="passphrase"
          }

 For GWireless, this works:
 network={
        ssid="GWireless"
	key_mgmt=WPA-EAP
	eap=PEAP
	identity="netID"
        password="password"
 }
 
 For eduroam, this works:
 network={
         ssid="eduroam"
 	key_mgmt=WPA-EAP
 	eap=PEAP
 	identity="email id"
 	password="password"
 }
 
 To run the config file with debugging:
 
 wpa_supplicant -i wlp6s0b1 -c /path/of/config/file.conf -d
 
 To run it in the background, replace -d by -B
 
 Finally, run dhcpcd if not running  already by dhcpcd or systemctl restart/start/enable dhcpcd.service
 
# Find out name of the linux distribution
 cat /etc/*-release
 typically, os-release has all the info, including the pretty name.
 For the linux kernel version, cat /proc/version
* Determine which physical disk partition mounted on a directory
 For example, the / filesystem is installed on
  df /
 The directory /root is located in
  df /root
 Conversely, to see a list of all block devices and their mountpoints,
  lsblk
 
# Fix pacman -Syu error with wrong pgp keys
 pacman-key --refresh-keys
 
# Killing processes
 To find the pid of the process, do
  pidof processname
 or,
  ps aux | grep processname
 To kill process with pid
  kill pid
 To kill stubborn unresponsive process
  kill -9 pid
 To kill all processes with name
  killall processname
  killall -9 processname
  
 Unmounting partitions in use: Find out which process is using it by
  lsof | grep /mountpoint
  killall/kill [-9] processname/pid 
# [Abandoned: couldn't see any improvement] Speeding up firefox by moving the profile to ram
 https://fixmynix.com/speed-up-firefox-with-ram-cache-and-tmpfs-linux/
 Note: Setting  browser.cache.disk.enable to false and setting browser.cache.memory.enable to true accelerates reloading recently loaded page elements. It comes with the variable browser.cache.memory.capacity which has to be created and specified as well. Eg: 409600. Reference: http://kb.mozillazine.org/Browser.cache.memory.enable
 Note: This specified size is OUTSIDE the profile directory of firefox. The precess so far has not used any ramfs yet.

 N: Didn't follow the first few http, ssl variable modifications. Starts from editing memory_cache variable.
 Main problem: the profile directory gets bigger and bigger and soon the tmpfs is full.
 Q: Can I sync while closing firefox instead of cronjob every 5 mins? Well, to save accidental crash, 5 mins seems better, still.
 Q: How to preserve the installed addons and login to pushbullet?
 Q: Why allocate capacity 2M and create tmpfs for 128mb?
 Q: Moving .vimrc to ram.
 Q: Wat else can I move to ram?

# Compress and uncompress (zip/unzip) files using aunpack
 To extract all files from archive `foobar.tar.gz` to  a  subdirectory  (or the current directory if it only contains one file):
  aunpack foobar.tar.gz
 
 To create a zip archive of two files `foo' and `bar':
  apack myarchive.zip foo bar
 To compress the content of current directory into a zip file called comp.zip
  apack comp.zip *
 
 To list contents of the rar archive `stuff.rar`:
  als stuff.rar

# calendar.vim
 Since  I have pathogen to install vim plugins, cloning the repo to .vim/bundle/ installs it.
 Setting the google options in .vimrc, when I do :Ca inside vim, I cannot copy the link got google authentication. So I opened it in gvim and copied it. But in gvim, I cannot paste the code that I received from google. So I hand-typed it. Very annoying.

 Here is a quick possible solution:
 1. Open gvim
 2. Type :Ca
 3. Copy the link
 4. Paste in browser, proceed, get a code
 5. Edit the file .vim/bundle/calendar.vim/google/client.vim and navigate to the line: 
 let code = input(printf(calendar#message#get('access_url_input_code'),
 (This line is inside a function called access_token_async. The input code here is not able to access the bufferes "+, "* etc. So we manually supply the value of variable 'code'. Make sure this modification does not stay for long)
 6. Modify the line to
 let code = 'xxxx_your_code_goes_here_xxxx'
 7. Save the file.
 8. Open usual vim and run :Ca and it should work directly.
 9. Undo the changes in client.vim and save it back. This step is necessary because you don't want to leave the code in a config file that is possibly uploaded to github. Make sure there are no git commits in the time interval between the two saves otherwise someone can look at the history of the file and retrieve it.
 
 See the calendar.vim/doc/calendar.txt for a complete help which I followed mostly.
 As a shortcut in awesomerc, add `xterm -e vim +:Ca` to open vim in a terminal with command :Ca and mapped it to Modkey+C
 
  
# Installing packages in R
  install.packages("ggplot2") 

# R tutorial
 Add "day of the week" column to your data with date:
 Let the data be tran and `tran$Date` is is date format (possibilities)
```
 tran$day <- weekdays(as.Date(tran$Date))
```

 Order your data by day of the week like this: (data is daily, day is DoW)
```
 daily$DoW <- factor(daily$DoW, levels= c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
 daily[order(daily$DoW), ]
```

 Plot frequency distribution of days of the week 
```
 barplot(table(tran$day))
```

 Create a sequence of weekdays, starting from today's day like this:
 Get today's date
 t <- Sys.Date()
 Create a sequence of 7 days by: adjust t+const to fix the starting day
 dayseq <- weekdays(seq.Date(t,t+6,by=1))
 Get the corresponding weekday value by
 weekdays(dayseq)
 or,
 daynames <- weekdays(dayseq, abbreviate=TRUE)

 Lesson Learned: IF you have a data with a variable name Category, and Catergoy can be either Grocery, Shopping or Travel, then first convert the variable into a factor using: data$Category <- factor(data$Category)
 Then you can use levels(data$Category) to see a vector with only 3 vars. You can change the factor data$Category the way you change a vector.

 The problem is to edit an entry in the data frame which is a category type. For example, if you want to change data[4,"Category"] to "hello", you cannot change it using data[4,"Category"] <- "hello" !!!
 Here is what to do:
 Change the type of Category varaible to character using:
 data$Category <- as.character(data$Category)
 Edit the value:
 data[4,"Category"] <- "hello"
 Change the variable type back to factor:
 data$Category <- factor(data$Category)

 So annoying!
 
 qqplot2 help:
 A line plot :
 qplot(x=Date, y=Amount, data=tran, geom=c('point','line'), color=Category, alpha = I(0.7))

 The following prints number of times we did grocery, shopping etc w.r.t. date
 qplot(factor(timeS), data=tran, geom="bar", fill=factor(Category))

 The following prints two side by side maps for each user. Each picture contains the count of grocer, Shopping and travel represented by different colors. The x-axis is time span.
 ggplot(tran, aes(timeS, fill=Category)) + geom_bar() + facet_wrap(~ User) 

 A slight invariant:
 ggplot(tran, aes(timeS, fill=User)) + geom_bar() + facet_wrap(~ Category)

 stat='identity' is the option that lets you plot y vs x instead of the defualt statistics count.

 Plot amount vs date/timeS, stacked with category
 ggplot(tran) + geom_bar(aes(timeS, Amount, fill=Category), stat='identity')

 Withe separate user:
 ggplot(tran) + geom_bar(aes(timeS, Amount, fill=Category), stat='identity') + facet_wrap(~ User)
 
 Seperate picture by category, both users in the same picture, 2rows of pictures
 ggplot(tran) + geom_bar(aes(x=timeS, y=Amount, fill=User), stat='identity') + facet_wrap(~ Category, nrow = 2)
 
 Facet_wrat w.r.t User of all categories with a greyscale of total amount of both users in the background
 ggplot(tran) + geom_bar(aes(timeS, Amount, fill=Category), stat='identity') + geom_bar(data=transform(tran, User=NULL), aes(x=timeS, y=Amount), stat='identity', alpha=I(0.2)) + facet_wrap(~User)

 To have a picture in the background of every facet, we need to create a facet without the facet variable. For example, in the previous case, transform(tran, User=NULL) gives you a data without the facet variable ~User. We plot a bar geometry of this data.
 
 Alternate representation with Category and User interchanged
  ggplot(tran) + geom_bar(aes(timeS, Amount, fill=User), stat='identity') + geom_bar(data=transform(tran, Category=NULL), aes(x=timeS, y=Amount), stat='identity', alpha=I(0.2)) + facet_wrap(~Category)
  
 In this context, manysum is nothing but
 ggplot(tran) + geom_bar(aes(timeS, Amount, fill=User), stat='identity')


# Installing xournal from source and adding useful patches:

So, apt-get install doesn't give you the latest version (e.g. now it is the 2.8.2016 version) or the patches the community developed.

To install the development dependencies, do
sudo apt-get build-dep xournal

Download the latest tar, extract it with
tar -xf xournal.**.tar.gz
cd xournal.**

Details of patching can be found here: https://sourceforge.net/p/xournal/discussion/554377/thread/5d03da22/
Here is the summary:
Patch the source code with the download patch file
patch -p1 < patchfile.patch

Note: if the patchfile is a tar file, extract and then -p1 should be change to -p2 or the required number of depth  of path.

Compile and install this modified source file, follow http://xournal.sourceforge.net/manual.html#installation

Summmary: 

To install in the user directory (~/bin/), do:
```
./autogen.sh; ./configure --prefix=$HOME; make; make install; make home-desktop-install
```
The last step is to set mime-type etc.

To install it in the system, do with sudo:
./autogen.sh
make
(as root) make install
(as root) make desktop-install

So, far used the following patches: various improvements, linewidth-patch, vi-style scrolling

Caution: If you use the linewidth-patch, older versions of xournal will not be able to open the files saved by the patched version. Chances are, this patch will not end up in the official version in future, making all the files created with the patched version useless.

# Drawing with touchscreen in xournal
 1. Select 'Designate as touch screen' and select the touch screen
 2. Turn OFF 'Pen disables touch'. Then draw.

To log the input events, add the following line at the top of the file src/xo-callbacks.c:
#define INPUT_DEBUG 1
Then, compile and run from terminal to see all the input events popping up at the terminal.


# Setting up raspberry pi zero w

Ethernet over usb:
Follow the popular guide to add two lines related to modules in the first (boot) partition:
1: open up the boot partition on the micro sd with finder and in the file config.txt add dtoverlay=dwc2 to a line on the bottom and save it.
2: Create a new file called ssh using textedit and save it onto the boot partition. Use 'get info' to remove the extension on the file, and it should appear as an EXEC file. You can now eject the card and boot it on your RPi
3: Finally, open up the cmdline.txt. replace all text with this:

dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait modules-load=dwc2,g_ether quiet init=/usr/lib/raspi-config/init_resize.sh 

Edit /etc/network/interfaces to add usb0 related info:
allow-hotplug usb0
iface usb0 inet dhcp 

Plug in a *good* usb cable to the usb port, not the power in and then set up the retrying nm-applet attempt to connect to the wired network and fail repeatedly. At this point, you can connect to the pi using ssh pi@raspberrypi.local
If the repeated attemp to connect and fail message from nm-applet is bothersome, run dhcpcd enp7e0u1i7 (or whatever is the hardware name from ifconfig) on your laptop. Note: dhcpcd in not installed by default so install it using sudo apt-get install dhcpcd5

For wifi:
Use wpa_passphrase <ssid_name>  to get the config file. Add it to /etc/wpa_supplicant/wpa_supplicant.conf
Next, add the following to /etc/network/interfaces
auto wlan0
allow-hotplug wlan0
iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

You can set up multiple networks in the wpa_supplicant.conf file and the first available one will be used (I think. Or, maybe wrt signal strength? However, it is working according to order of appearance)

# Install Cocalc notebook locally

No need to install sage or sagemath.

Follow the instruction to install the cocalc-docker. It is just one
line long code. It will download,
extract and install. I had to use sudo to get it to work since I
installed docker using sudo (`sudo apt-get install docker.io`. 
To open it in browser, make sure to use `https://localhost` instead of
`http://localhost`.

I had create account (fake email id are ok, since they are local)

To start and stop cocalc, use 
`sudo docker start cocalc`
`sudo docker stop cocalc`

To view equations in latex rendering, use the function `view()`. To
print out the latex code of it, use the function `latex()`.

To define variables in a latex-friendly way so that the view command
prints it right, use

u_th_x = var('u_th_x', latex_name = 'u_{\\theta}(x)'}

Later, do `view(u_th_x)` to see it rendered correctly.


# Experiments on lock screen on suspend and lid close

Facts (for Xubuntu):
* xflock4 runs the default lock-screen program, which is slock if light-locker is not running.
  Otherwise, light-locker will run (xfce's own lock screen window)
* xfce4-power-manager and /etc/systemd/logind.conf interferes with the lid response


We follow this link:
https://wiki.archlinux.org/index.php/Slock#Lock_on_suspend

First, we set up lock screen service using slock  when sleep target is triggered.

'/etc/systemd/system/slock@.service'
------------------------------------------

[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target

Next, Enable the slock@user.service systemd unit for it to take effect for the username user:
`sudo systemctl  enable slock@debdeep.service`
do start to see if the script works (without closing the lid) 
`sudo systemctl  start slock@debdeep.service`
(expected behavior: slock will run)

Then, we follow this link to set up the lid response:
https://askubuntu.com/questions/1009387/laptop-doesnt-suspend-properly-on-closing-lid

/etc/acpi/lid.sh
----------------

#!/bin/sh

grep -q closed /proc/acpi/button/lid/LID0/state
if [ $? = 0 ]
then
  nmcli radio wifi off
	# note the change
  systemctl suspend
else
  nmcli radio wifi on
fi

Then, add this script to 

/etc/acpi/events/lm_lid
---------------------
event=button/lid.*
action=/etc/acpi/lid.sh

Finally, set the permissions and restart the services

sudo chmod 755 /etc/acpi/lid.sh
sudo /etc/init.d/acpid restart

Make sure to set HandleLidSwitch=ignore in /etc/systemd/logind.conf 
Actually, I have only HandlePowerKey=suspend option uncommented. I guess HandleLidSwitch=ignore is not really necessary. Then restart the logind service using:
sudo service systemd-logind restart


# Fixing the bug of disappearing clients on suspend
Update to version 4.3 where one of the changes was to stop awesome from removing all the screens, which is what I think was happening.

First, enable the `source code` repository in `software-properties-gtk`.
Then, install the latest version of awesome from github using
```
sudo apt build-dep awesome
git clone https://github.com/awesomewm/awesome
cd awesome
make package -j5
sudo dpkg -i build/*.deb
```
After the restart, the session awesome might vanish from the login window. Add the following to /usr/share/xsessions/awesome.desktop
```
[Desktop Entry]
Encoding=UTF-8
Name=awesome
Comment=Highly configurable framework window manager
TryExec=awesome
Exec=awesome
Type=Application
```

121: Vimtex experience
Install via pathogen using:
```
cd .vim/bundle
git clone https://github.com/.../vimtex
```

Install `latexmk` using `sudo apt-get install`


Setting zathura as the default viewer
let g:vimtex_view_method = 'zathura'

Check the info using <leader>li (<leader> = \)
Start the continuous compile mode using \ll. At this point, automatically compiles when the file is saved. 
\lv to display the pdf file and do a forward search 

:VimtexLabelsOpen|:VimtexLabelsToggle: open table of labels
\lt  or :VimtexTocOpen|:VimtexTocToggle: open a clickable toc in the left pane (q will close the window) 
:VimtexCompileOutput: show the output form the compilation command (i.e. from latexmk)
:VimtexErrors: open quickfix window if there are errors or warnings.
:VimtexClean: clean auxilliary files like *.aux, *.out, and so on files. Use :VimtexClean! to remove everything, including the generated pfd file.

delete surround environment (dse) and cse works. So do dsc and csc for commands.
tse (toggle star environment) and tsc toggles star in envs and commands
tsd (toggle star delimiter) changes the surrounding delimiter to appropriate latex version, eg. () becomes \left( \right)

To traverse through the autocomplete dropdown list, use C-P and C-N instead of the arrows.
Eg. type \cite{Bour<C-X> <C-O>
Then use C-P and C-N to choose the right one. It supports regex as well

Now % can jump through \left( and \right)

Close matching delimiters (brackets or other pairing symbols like $, $$ etc) using ]] in insert mode.
In insert mode, ]] also closes the current unclosed environment.

In normal mode, [[ and ]] jump through sections and subsections. Moreover ]m jumps through the start of the next environment (faster navigation, also use \lt)


\lm to see all the macros, like \alpha = `\`a` etc

To be able to access the help file (:h vimtex), you might get errors that it does not exit. In that case run :Helptags by which pathogen creates a list of all help files from doc directories. Use Ctrl-w + O to make the help window fullscreen. Ctrl-w + C closes a window.

Syntax folding and expanding: zi and za to fold and unfold all

Q: Is it convenient or worth it to make all the greek letters with (a<Tab> = \alpha)?
 Maybe not, since we already have `\`a` (typed quickly). See \lm for a complete list.
Q: How to add align* environment quickly?
 Using Ultisnip, so use al*<Tab>
Q: How to add templates quickly?
 Using Ultisnip, decided to use `_pde` etc. (leading underscore for template completion)
Q: Good to know: shutting down continuous compile.
 Added the line 
	let g:vimtex_view_forward_search_on_start = 0
 to .vimrc to stop launching the pdf reader twice.
Q: vim-easymotion leader key bug is not here anymore, but is very slow
 Turned off most of it, kept \w for word jump. However, it interferes with vim-sandwitch command m( to select \left( \right) pair.
Q: In-file timestamp for current save time.
 Not sure yet, need to use autocommand.
Q*: Jump to locations of the file for application process.
 \lt to open a table of contents. Also \lv jumps to compiled part.
Q: Need shortcut for sac<align*> etc (<F7> works for command)
 Still need to unify the behavior of <Tab> and <F7>.
Q: Intuitive conflict between vim-sandwich (sree = surround replace env by env) and default (cse = change surround e)

Features from vim-latex-suit:
frac needs to be two-key

Selected text enclosed by command or environment: 
Using vim-sandwich instead of vim-surround. The default keybindings are intuitive
sa, sd, sr (surrounding add/delete/replace), followed by the delimiters.
Works in visual mode as well. 
Works with vimtex environments and commands with sac and sae (surround add command/environment) both in normal and visual mode.
<F7> still works in normal and visual mode to create commands. However, the brace does not close automatically, which is a problem.

Idea: maybe map S-<F7> to cse and S-<F5> to csc

Using Ultisnip:
I am using Tab for both TriggerExpand and TriggerJumpNext. (Instead of Tab and C-j respectively, to preserve placeholder jump <++>)

If you hit Esc or do undo while filling up one of the fields in a snippet, Tab does not take the cursor to the next place anymore. 
In that case, to jump to the next place in the incomplete (actually, untraversed) snippet, enter Insert mode, and then hit Tab.
Be careful to not expand the current word.
Therefore:
	Shortcut to resume incomplete snippet traversal: i <tab>
Note: As long as the cursor does not reach $0 (or at the end of the snippet if $0 is absent), the snippet does not end

While writing snippets, the backslashes need escaping (for new line, etc)

Converting selections to environments using $VISUAL snippets: select
text in visual mode, press <tab>. This deletes the selected text and
you enter the insert mode. Now, type the trigger word for the snippet
which has `$VISUAL` in it. Now pressing <tab> again will expand the
snippet with copies visual mode text pasted in the right location.



# How to locate the path of a executable file: use `which`
```
which zathura
which vim
```

# Setting up neovim

Install with `sudo apt-get install neovim`

Launch with `nvim`

To make neovim use the config and plugins of vim, create the file `~/.config/nvim/init.vim` and insert
```
" Using the path and plugings of vim 
set runtimepath^=~/.vim runtimepath+=~/.vim/bundle
let &packpath=&runtimepath
source ~/.vimrc
```

For vimtex, we need to use servermode, which is not directly available. Install it using
`sudo pip3 install neovim-remote`
(Note that the sudo is added to make sure the installation path is found by the shell. Otherwise, we need to add the path of local installation to `$PATH`)

vimtex now advises (link:https://github.com/lervag/vimtex/wiki/introduction#neovim) to add the following to init.vim
```
" Do this after installing neovim-remote using pip3
let g:vimtex_compiler_progname = 'nvr'
```
Apparently, nvim _always_ launches itself in server mode by default, so no need to launch it in servermode (with `--listen` parameter) unlike vim.

The behavior of nvim seems to be a bit faster than vim, although I am yet to be sure. coc.nvim still hangs as soon as more than the main option is uncommented in .vimrc.

# coc.nvim  

## Installation: 
[deprecated] `git clone` the plugin to `.vim/bundle/` directory (if using Pathogen for managing plugins. Inside the downloaded path, run `install.sh` which downloads node.js and installs it.
[New, didn't work properly] 
Modification to the official instruction to get nodejs: use sudo to install nodejs
Install nodejs as root using
```
curl -sL install-node.now.sh/lts | sudo bash
```

Copy-paste the suggested config into .vimrc, then TURN OFF mapping with `<cr>` since it causes infinite loops and makes nvim (and vim) freeze!!

Caution: vim (and nvim) hangs when this part of the .vimrc (suggested by coc.nvim documenttion) is turned on.
```
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"" position. Coc only does snippet and additional edit on confirm.
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif
```
So, make sure to turn it off. One bugreport says upon hitting <cr>, vim goes into an infinite loop of <cr>s.

Moreover, turn off do the following change to .vimrc to avoid slow load of ranger upon pressing <leader>r.

```
"nmap <leader>rn <Plug>(coc-rename)
nmap <leader><f2> <Plug>(coc-rename)
```

To use ultisnip snippets, install the coc-extension `coc-snippet` using `:CocInstall coc-snippets` (and other extensions if needed). The snippets show up with a tilde at the end.

Note: snippets defined using regex do not show up :(

To use intelliSense code expansion and jumping etc, we need to install language server specific to that language, either using `:CocInstall` or manually and then configure using `:CocConfigure`.

If you want the definitions, implementations etc to open in a new tab (jump to existing tab if it is already open, `drop`), add the following to `~/.vim/coc-settings.json` or via `:CocConfig`:
(**Caution:** Does not work when the file is not already open. Use the next `nmap` command and replace the existing `gd`)
```
{
    "coc.preferences.jumpCommand": "drop"
}
```
Alternatively, to open _only_ the definitions in a new tab, edit the line with shortcut `gd` in `vimrc` to
```
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
```

For example, to use C++ code completion, jumping to definition etc, we use `clang`. Install it using `sudo apt-get install clang`. Then install the extension using `:CocInstall coc-clang`. Now, we have more information on the auto-completion, including argument names for functions etc. 
It does not work well since it cannot find many paths of header files, for example.

To use coc code-completion with vimtex, install `:CocInstall coc-vimtex`
(I tried coc-texlab, which is a language server for tex, could not see and linting hapending, so abandoned. Maybe look into it in details?)

Could not find one with matlab yet.

## features
* `:CocList services` to open services list, you will have id state and filetypes for each service.


## How to
* Get suggestions from predefined snippets (from `Ultisnips`) with `:CocInstall coc-snippets`
* Pressing tab should automatically fill up the cursor position with the first suggestion, instead of having to press ctrl-n. How to do that? Notice: <S-Tab> actually does what is expected.
* How to resolve behavior of pressing tab twice when the first result is a snippet?
* what is the purpose of Ctrl-space to coc#refresh()??


## coc-pyright for python 
[link](https://github.com/fannheyward/coc-pyright)
* Install 
```
:CocInstall coc-pyright
```
* Organize the lines with `import` with
```
:CocCommand pyright.organizeimports
```
* Format the code with `:Format` 
to make it work, first `pip3 install autopep8`
then run `:CocConfig` and add within the fist (outermost) curly braces:

```
{
"python.formatting.autopep8Path": "~/.local/bin/autopep8",

}
```
Otherwise, the plugin cannot find the installation location!

* [Doesn't work] For packages like `numpy`, a type stub needs to be created to avoid error messages
```
:CocCommand pyright.createtypestub numpy
```
This creats a directory called `typings` where stubs are kept.


## Code completion and definition for C/C++ files #

* Install the C/C++ language server `clangd` with `sudo apt-get install clangd`
* Install the clangd extension to coc using `:CocInstall  coc-clangd`. Alternatively, provide the configuration using `:CocConfig` and pasting the following:

``` 
{
"languageserver": {
    "clangd": {
      "command": "clangd",
      "rootPatterns": ["compile_flags.txt", "compile_commands.json", ".git/"],
      "filetypes": ["c", "cpp", "objc", "objcpp"]
    }
  }
}
```

Alternatively, use the `ccls` (`sudo snap install ccls --classic`) and include in `:CocConfig`
```
{
    "languageserver": {
        "ccls": {
            "command": "ccls",
            "filetypes": [
                "c",
                "cpp",
                "objc",
                "objcpp"
            ],
            "rootPatterns": [
                ".ccls",
                "compile_commands.json",
                ".vim/",
                ".git/",
                ".hg/"
            ],
            "initializationOptions": {
                "cache": {
                    "directory": "/tmp/ccls"
                }
            }
        }
    }
}
```

* In your C/C++ project, generate a file called `compile_commands.json` using `CMake` (if the project is CMake-based) or `bear` (if the project is `make`-based) in the following way. [link](https://releases.llvm.org/8.0.0/tools/clang/tools/extra/docs/clangd/Installation.html)

* If your project builds with CMake, it can generate `compile_commands.json`. You should enable it with:
```
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
```
`compile_commands.json` will be written to your build directory. You should symlink it (or copy it) to the root of your source tree, if they are different.
```
ln -s ~/myproject/compile_commands.json ~/myproject-build/
```
* Other build systems, using `Bear`: Bear (`sudo apt-get install bear`) is a tool that generates a `compile_commands.json` file by recording a complete build.

For a make-based build, you can run 
```
make clean; bear make
```

 to generate the file (and run a clean build!)

* Edit a file with `vim`. At this point coc should recognize the file. Verify that with `:CocList services`. Now, place the cursor over a call of a function and press `gd` (`<Plug>(coc-definition)` in `.vimrc`) to jump to the definition of the function.


# C/C++ compilation troubleshooting

* `error: No rule to make target: .../libname.so`
Multiple occurrence of the .so file. Find multiple installs of the library using
`apt search libname` and remove more than one instances.

Another way to find the packages responsible for the required files is using `apt-file search`:

`apt-search file /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi.so`

The method still did not work, so I had to manually create symbolic links pointing to them with:

cd /usr/lib/x86_64-linux-gnu/openmpi/lib/
ln -s libmpi.so.* libmpi.so
ln -s libmpi_cxx.so.* libmpi_cxx.so

* The DSO missing from command line message:

Easiest fix: use `-lpthread` when `${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU"`. I.e., in the CMakeLists.txt, modify the appropriate lines to

Common ways to inject this into a build are to export LDFLAGS before running configure or similar like this: 
```
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    #set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -lpthread")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
```

Another fix: export a environment variable like this:
```
export LDFLAGS="-Wl,--copy-dt-needed-entries"
```

As a workaround it's possible to switch back to the more permissive view of what symbols are available by using the option `-Wl,--copy-dt-needed-entries`.

Sometimes passing `LDFLAGS="-Wl,--copy-dt-needed-entries"` directly to make might also work.

details: [link](https://stackoverflow.com/questions/19901934/libpthread-so-0-error-adding-symbols-dso-missing-from-command-line)
This error is displayed when the linker does not find the required symbol with it's normal search but the symbol is available in one of the dependencies of a directly specified dynamic library.
In the past the linker considered symbols in dependencies of specified languages to be available. But that changed in some later version and now the linker enforces a more strict view of what is available. The message thus is intended to help with that transition.

# Running script for motion

To call scripts from motion via `on_picture_save` or `on_event_end`, we need to make sure that the script is accessible by the user _motion_. The software motion creates a user called motion.

To make files and directories owned by (and hence accessible by) the user motion and the group motion, we need to issue
```
chown -R motion:motion dir_within_anoter_user
```

Note that, motion cannot even write to a location that is owned by another user even when we run motion as super user (via `sudo systemctl motion start`).

# Update Gemfile.lock of github website repository to the latest version
Instead of updating the version numbers by hand in `Gemfile.lock`, automatically generate the `Gemfile.lock` with the latest versions available (which is hopefully equal or even higher than the version number suggested by Github security vulnerability message), using
```
bundle lock --update
```
(You need `ruby-bundler` installed for this to work.)
Now check the generated `Gemfile.lock` to see if version number stated in security vulnerabilities section of your github repository matches the version number in `Gemfile.lock`. It should match or show even a higher (more latest) version number.

Another way to manually specify the version number is to add it to `Gemfile` file (not `.lock`) like this:
```
gem "kramdown", ">= 2.3.0"
```
and then update the lockfile using `bundle lock --update`.

# vim-matlab modifications

Git clone vim-matlab and make the following changes.

* `mlint` as code checker (linter): First locate `mlint`. The location of the binary `matlab` can be found using
```
whereis matlab
```
My output is `matlab: /usr/local/bin/matlab`. A quick `ls -l` shows that it is actually a soft link to `/usr/local/MATLAB/R2020a/bin/matlab`. The binary `mlint` must be nearby. Turns out, mlint is in the location `/usr/local/MATLAB/R2020a/bin/glnxa64/mlint`.
Create a soft link in `/usr/local/bin/` of `mlint` using
```
ln -s /usr/local/MATLAB/R2020a/bin/glnxa64/mlint mlint
```
Now, mlint can be invoked from other terminals like this: `mlint filename.m`.

Therefore, `$HOME/.vim/bundle/vim-matlab/compiler/mlint.m` can access it. Now, we need to set mlint as a compiler for the .m files. Filetype-specific options can be set in the `ftplugin` directory. So, in the file `$HOME/.vim/bundle/vim-matlab/ftplugin/matlab.vim`, we add
```
compiler mlint
```
Now, after opening a .m file, we can issue `:make` and then `:copen` to see error messages. We can combine these options together and another line to the file `ftplugin/matlab.vim`
```
map <silent> <Leader>ll :make<CR>:copen<CR>
```
This launches the errors when we press `\ll`, to be consistent with latex shortcut.

* Enable matlab jump of cursor between `for` and associated `end` using %
Matchit has been added to the main vim version since v6. To enable it add to .vimrc

```
runtime macros/matchit.vim
```
See more help with `:h matchit`.


# Vim search for string in a case-sensitive manner temporarily
Use \C in the beginning, i.e. search for string 'ThisThat' using `/\CThisThat`. To search in a case-insensitive manner, use `\c`. 
Moreover, searching backward can be done with `?` instead of `/`.

# Setting up linux password management system with pass and gnupg

* Install using `sudo apt-get install pass`
* Password stores are associated with GPG keys stored in the system. 
* Initiate a password store using 
```
pass init KEY_ID
```

Here, `KEY_ID` is the 8-digit GPG key, or name, or email address associated with a GPG entry.

Now, an empty `~/.password-store` is generated.

* You need to create a gpg key (along with a passphrase) beforehand using 
```
gpg --gen-key
```
 - In this process, you need to supply a name and an email address. You will then be asked to specify a secret password or passphrase to protect the private key generated in this process. See [Diceware](Dicewarehttps://theworld.com/~reinhold/diceware.html) method as an example of a memorable passphrase generation method.

All generated files are saved in `~/.gnupg` directory.

 - You can see all keys in your system using 
all public keys using `gpg --list-keys` and all private keys using `gpg --list-secret-keys`. Note that private keys have public keys in them.
The hexadecimal code associated `pub` is the identifier `KEY_ID` that can be provided to `pass`. Alternatively, you can specify the `name` or the email address as the `KEY_ID` while using `pass init`

The privatekey-passphrase pair is secret and needs to be protected. Losing the private key means you won't be able to decrypt anything, including the stored passwords. The private key (which already contained the public part) can be exported to a file using
```
gpg --export-secret-keys KEY_ID > secret_keyfile
```
This produces a binary (unreadble) file. To export into human-readable ascii file, include `-a`:
```
gpg --export-secret-keys -a KEY_ID > secret_keyfile
```

The output file `secret_keyfile` should be stored safely and can be imported to a new computer using
```
gpg --import secret_keyfile
```
Both importing and exporting methods will involve you recalling the _secret_ passphrase, which was used to generate the gpg key.

Note that with the `secret_keyfile` alone (i.e. without passphrase), the private key cannot be installed into a new computer and hence encrypted files cannot be decrypted.

As long as you have access to `secret_keyfile` and the passphrase is memorized, the existing private key can be deleted. This can be done for example using `gpg --delete-secret-key KEY_ID` (which deletes the private key only, to delete the public part as well, do `--delete-key` again)  or by simply deleting the directory `~/.gnupg`. 

* After importing a secret key from another source, you need to `trust` the key to use it in your `pass` like this:

```
gpg --edit-key KEY_ID
gpg> trust
```
Select `5 = I trust ultimately`. Exit with Ctrl+D or `gpg> save` to exit.

After that, commands like `pass insert` should work.

* `pass` requires the gpg key (private key) to encrypt the passwords.
* If you want to re-encrypt the passwords with another gpg key, you can run
```
pass init NEW_KEY_ID
```
CAUTION: You need to have BOTH  the old key `KEY_ID` and  the new key `NEW_KEY_ID` present in your `~/.gnupg`.


Back to `pass`:
* See your list of passwords using `pass`
* Insert a new password to you store using `pass insert Category_C/Site_A`
* See the stored password using `pass Category_C/Site_A`
* Copy the password to the clipboard for 45 seconds using `pass -c Category_C/Site_A`

* Make your password store a git repository using
```
pass git init
pass git remote add origin github.com:a-pass-store
```
After this step, every call to `pass` also initiates a `git commit` for the changes made to the password files. 

Note: all usual git commands can follow after `pass`. For example, `pass git push -u --all`
* For firefox extension:
Install the 'host app' using
```
curl -sSL github.com/passff/passff-host/releases/latest/download/install_host_app.sh | bash -s -- firefox
```
Install the plugin from 
https://addons.mozilla.org/en-US/firefox/addon/passff/

* For Android, use the `Password Store` app by Harsh Shandilya

* [Read](https://michael.kjorling.se/computers/passwords#need-remember)

More:
* The expiry date on the gpg key does not affect the ability to decrypt. The expiry date can be extended by editing the key using
```
gpg --edit-key KEY_ID
gpg> passwd
```
and then Ctrl+D or `gpg> save`.
* The passphrase can be updated using `gpg> passwd` and then `gpg> save`. Changing passphrase does not affect the decryption process of already-encrypted files.

Storing:
- `pass`-encrypted passwords can be stored in **private** github repositories
- Storing private key: writing down (printing out) a modified version on paper
- No storing passphrases, but remembering them. A good output is
```
diceware -d - -n 5 -w en
```
to use smaller words from source `en`. 
Better alternative: `xkcdpass`
Pictures based on the words are easy to remember. Update every 6 months or so.


# Mutt with OAUTH2

## Installation

**Caution:** I keep getting errors
```
imap_oauth_refresh_command: unknown variable
smtp_oauth_refresh_command: unknown variable
```
where I run mutt installed via `apt-get install`. Turns out `SASL` was not available in the ubuntu release version. So I had to build from source.

* Build `mutt` from source with `sasl` support
Get the dependencies with
```
sudo apt-get build-dep mutt
```
Get the latest source (check latest version)
```
https://bitbucket.org/mutt/mutt/downloads/mutt-1.14.6.tar.gz
tar -xvf mutt-1.14.6.tar.gz
cd mutt-1.14.6
```
Configure with imap, smtp, sasl etc (run `./configure --help` for more options)
```
make clean
./configure --with-ssl                               \
            --enable-external-dotlock                \
            --enable-pop                             \
            --enable-imap                            \
            --enable-smtp                       \
	    --with-sasl				\
            --enable-hcache                          \
            --enable-sidebar                         &&
make -j4
sudo make install
```

Instead of `make install`, we can issue `sudo checkinstall` to create a `.deb` package that
can be uninstalled with `apt-get remove`.

Make sure the installed version has `sasl` support etc by using
```
mutt -v | grep IMAP
mutt -v | grep SASL
```
etc.

[This](https://gitlab.com/muttmua/mutt/-/issues/179) website tells you to install with following flags
```
./configure \
    --prefix=/usr/local         \
    --with-mailpath=/var/mail   \
    --enable-debug              \
    --enable-hcache             \
    --enable-imap               \
    --enable-smtp               \
    --enable-pop                \
    --enable-sidebar            \
    --enable-compressed           \
    --with-curses               \
    --with-sasl                 \
    --with-gss                  \
    --with-gnutls               \
    --with-idn
```

## OAUTH2 credentials

* Get the refresh token etc using Oath2: 
Download  the [file](https://github.com/google/gmail-oauth2-tools/blob/master/python/oauth2.py) and make it executable using `chmod +x oauth2.py`.
Get `<your_client_id>` and `<your_client_secret>` from [google](https://console.cloud.google.com/apis/credentials)

Run `oath2.py` like this:
```
./oauth2.py --user=<user>@gmail.com \
--client_id=<your_client_id> \
--client_secret=<your_client_secret> --generate_oauth2_token
```
Follow the link, login, and paste back in the script, the script spits out a `refresh code`, save that.

Now, add to `muttrc` (`~/.mutt/muttrc`) the following (later, move them to another file)
```
set imap_user='<username>'
set imap_authenticators='oauthbearer'
set imap_oauth_refresh_command='~/.mutt/oauth2.py --quiet --user=<username> --client_id=<your_client_id> --client_secret=<your_client_secret> --refresh_token=<your_refresh_token>'

set smtp_authenticators="oauthbearer"
set smtp_oauth_refresh_command='~/.mutt/oauth2.py --quiet --user=<username> --client_id=<your_client_id> --client_secret=<your_client_secret> --refresh_token=<your_refresh_token>'
set smtp_url = "smtp://<username>@gmail.com@smtp.gmail.com:587/"

# Remote Gmail folders
set folder = "imaps://imap.gmail.com"
set spoolfile = "+INBOX"
set postponed = "+[Gmail]/Draft"
set record = "+[Gmail]/Sent Mail"
set trash = "+[Gmail]/Trash"
```
where `<user>`, `<your_client_id>`, `<your_client_secret>`, `<your_refresh_token>` are replaced appropriately.


## Modifications

* `mutt` loads _all_ emails on each launch, which is time-consuming and useless. I could not find a way to specify the limit the number of headers that it fetches, but setting the command
```
set header=~/.mutt/cache/headers
```
and creating the directory (`mkdir -p ~/.mutt/cache/headers`), which is very important, the loading time reduces significantly.



## Questions

* Move all the secret credentials to another file, or keep them encrypted
* New unread messages are not highlighted by default
* How to separate spam and promotional ones from important ones?

# Zotero

### Installation
* Install Zotero from source (the snap version does not follow system theme) by following the instruction.
[link](https://www.zotero.org/support/installation)

Alternatively, use [this guy's script](https://github.com/retorquere/zotero-deb) for latest version via `apt-get`:
```
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
sudo apt update
sudo apt install zotero
```
* Install the firefox plugin.
- Download plugins: (right click and `save link as` to get the `.xpi` file instead of attempting to install on Firefox as a plugin)
    * Download the  `Zotfile` plugin from [link](http://zotfile.com/)
    * Download `Better Bibtex` plugin from [link](https://github.com/retorquere/zotero-better-bibtex)
    * Download `scihub` plugin from [link](https://github.com/ethanwillis/zotero-scihub)

- To install plugins, goto `Tools > Addon > Gear Icon > Install from file`. Restart Zotero.

- After installing the scihub plugin, follow this [link](https://medium.com/@gagarine/use-sci-hub-with-zotero-as-a-fall-back-pdf-resolver-cf139eb2cea7)
and set your browser in `.bashrc` by adding
```
export BROWSER=/usr/bin/firefox
```
and `source ~/.bashrc`.


### Zotfile Settings

In `Tools > Zotfile preference`, set the following
* `Advanced Settings`: _uncheck_ Only work with the following filetypes. Therefore, renaming and moving attachments work for tex, xoj etc, including new unexpected filetypes as well.
* `Advanced Settings`: check remove special characters from filenames
* `General Settings`: Set `Location of Files` as `Custom Location` and select a new directory which will be backed up using gdrive. Possibly add `Subfolder defined by` as `%c/` to add the `collection` name as the subdirectory.


### Setup syncing (Edit > Preferences > Sync)
* Set up syncing and turn off attachment syncing (uncheck `Sync attachment files in My Library using` and  `Sync attachment files in group libraries using Zotero Storage`. This way, the database is synced by Zotero and the pdf files (attachments) are backed up by drive.

- Click on the green sync button on top right to sync

### In Better Bibtex settings:
* Add vim support by adding the following to `.vimrc`

```
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'cite' : 'pandoc'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>
```

* In `Edit > Preferences` > `Better Bibtex` > `Citation Keys`, set an easy format like (see Documentation for more formats):
```
[authEtAl][veryshorttitle1:capitalize][shortyear]
```
   - Upto two authors - Lastnames, capitalized
   - More than 3 authors - first author last name, capitalized, followed by `EtAl`
   - First significant word of the title (ignore `a`, `the` etc), capitalize
   - Last two digits of the year



## **Caution:** 
* Items without a parent do not get moved or renamed, so make sure to create one for un-recognized files
* Items do not get automatically copied to the new location until you select them and click _rename attachments_
* Moving items to another collection can be done by holding the shift key while dragging with the mouse
* Auto syncing is done within a few seconds of change to the database.
* Files in the _Unfiled items_ category are placed in the base directory, instead of in the collection directories. Edit or move them.

## Scenario:

* Move files to `~/Zotero` directory while renaming them
 1. Add files using Linked directory
 1. Zotfile preference: Location of files is `Attached Stored copy of file(s)`
 1. Select all files, and Rename

* You want to keep the directory structure of your pdf file, just batch rename them
 1. Add files using Linked directory
 1. Zotfile preference: `Location of Files` is `Custom Location`, possibly add `Subfolder defined by` as `%c/` to add the `collection` name as the subdirectory
 1. Select all files, and Rename
Now, you can keep backing up the custom location using gdrive etc.
Caution: original files are deleted (i.e. moved, not copied)

* You want to add citations to you tex file as you type and generate the .bib file automatically afterwards
 1. While typing in the tex file in vim, press `<leader>z` in normal mode or `Ctrl-Z` in insert mode to launch the Zotero search window
 1. Type search terms, select the citation, hit enter to insert strings like `\cite{AuthorEtAlTitle05}`
 1. After the tex file is generated with incomplete citations, go to Zotero, `Tools` > `Scan bibtex Aux file`
 1. Supply the `.aux` file that is generated from the `.tex` file. Set a tag name when asked.
 1. On the bottom-left part of Zotero, type and select the tag name you set, select all, right click, export as `Better Bibtex`. 
 1. This will create a `.bib` file with all citations extracted from the `.aux` file. Add it to `.tex` file in `\bibliography{}` with appropriate `\bibliographystyle{}`.
 Hint: Right click on the tag to rename, delete, or assign a color to it.

* Move all files to a new location, with a new directory structure, renaming them
 1. Select the location you want the files to go in `Zotfile Preferences > Location of Files`. For new installation of Zotero, you need to supply `Linked Attachment Base Directory` as the directory used by Zotfiles.



# CPU frequency scaling

* Use the utilty `s-tui` (`pip3 install s-tui --user`) along with `stress` (`sudo apt-get install stress`) to load your system and observe how temperature works with frequency.
* See the current `scaling_governor` using
```
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```
Note: the asterisk implies that we are printing out the rule for _all_ the cpu's.
If it is `powersave` (which is the default), the frequency stays at the lowest possible frequencies.

* You can manually change the current `scaling_governor` by directly editing the file with the one of the profiles 
[see](https://wiki.archlinux.org/index.php/CPU_frequency_scaling)
[see](https://www.kernel.org/doc/Documentation/cpu-freq/governors.txt)

`performance` 	Run the CPU at the maximum frequency.
`powersave` 	Run the CPU at the minimum frequency.
`userspace` 	Run the CPU at user specified frequencies.
`ondemand` 	Scales the frequency dynamically according to current load. Jumps to the highest frequency and then possibly back off as the idle time increases.
`conservative` 	Scales the frequency dynamically according to current load. Scales the frequency more gradually than ondemand.
`schedutil` 	Scheduler-driven CPU frequency selection [2], [3]. 

For examplie, issue
```
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

**Caution:** raising the frequency increases the CPU temperature significantly and affects the remaining time on battery.

* Alternatively, you can edit the `scaling_governor` variable using the tool `cpupower`. On Ubuntu, this package can be installed using
```
sudo apt-get install linux-tools-<kernel_version>-generic
```
where `<kernel_version>` is the version of the current linux kernel (see `uname -a`).
Then, you can change the profile using
```
cpupower frequency-set -g ondemand
````

# Papis

## Install
* Install the dependency
```
sudo apt-get install python3-setuptools
```
* As user
```
pip3 install --user papis
```
Add `~/.local/bin` to your `$PATH`.

# MARP for presentation slides using markdown

## Installation
* ~~Using npm~~ (didn't work)
* ~~Install from ubuntu snap repo~~ (the executable filename is weird)
```
sudo snap install marp-cli-carroarmato0
```
* Download the binary from the release page on github, extract the tar to get a _single_ binary file `marp`. Launch it with `./marp`.

## Workflow
* Create `slides.md` file with proper headers.
* Convert to html using `./marp slide.md`. This creates `slides.html`
* Open html in browser `firefox slides.html`
* Keep editing and see changes in real time using
```
./marp slide.md --watch
```
* Alternatively, use the native previewer using
```
./marp --watch --preview
```

## Usage
* Itemized lists are defined using `-`, whereas `*` produces next slide as we go (i.e. requires you to go to the next slide before showing the next item)
* Sublists need two preceding spaces
* Highlight text with ticks `text`, which can also be used to embed code

## Tex support

Marp uses KaTeX for rendering latex. Here are the supported functions.
https://katex.org/docs/supported.html

## Changing settings for the current slide only
* Use underscored directives at the top of the current slide. For example, to temporarily change the background to a gradient color, do
```
<!-- _backgroundImage: "linear-gradient(to bottom, #67b8e3, #0288d1)" -->
```
* Skipping the underscore will cause the setting to apply all the subsequent slides. That is how you set global settings.

## Changing font size

To change the font size of the current slide, paste the following within the current slide:

```
<style scoped>
section {
  font-size: 30px;
}
</style>
```


## Embedding videos

* Embed video with html tag as usual

* Use `--html` option to parse html tags written in the `.md` file. For example, embed a video using the following html tag with size, autoplay and on loop like this:
```
 <video width="320" height="240" controls autoplay loop>
  <source src="data/pacman_fracture.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video> 
```
and do
```
./marp slide.md --html --watch --preview
```
* Finally, to align the videos to the left, enclose them in a `<div> </div>` tag with left orientation like this:
```
<div style="float:left;margin-right:20px;">

 <video width="320" height="240" controls autoplay loop>
  <source src="data/pacman_fracture.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video> 

</div>
### Slide title
```

*  To get a long column, set a large `margin-bottom` to the `div` tag like this:
```
<div style="float:left;margin-right:30px;margin-bottom:300px;">
...
</div>
### Slide title
```
* To push the video to the right-edge of the screen (with no extra margin on the right), use negative margin value like this:
```
<div style="float:right;margin-right:-70px;margin-top:100px;margin-left:40px;margin-bottom:300px;">
...
</div>
### Slide title
```

* A good example that works on the default settings:
```
<div style="float:right;margin-right:-70px;margin-top:-70px;margin-left:10px;margin-bottom:300px;">
 <video height="720" controls autoplay loop>
  <source src="data/damping_w_friction.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video> 
</div>

### Simulation: damping with friction
Text goes here
```

## Adding vertical space
Use html tag with line break `<br>`. Use as many as needed.

## Adding horizontal space
Use html characters:
```
Regular space: &nbsp;
Two spaces gap: &ensp;
Four spaces gap: &emsp;
```

## Multiple images next to each other
List them in the same line, i.e, without any line break like this:
```
![h:300](data/nonconvex-demo.png) ![h:300](data/nonconvex-demo-ring.png) ![h:300](data/nonconvex-demo-rplus.png)
```
Specify height and width to fit things in the page.

## Align contents using tables
```
Solarized dark             |  Solarized Ocean
:-------------------------:|:-------------------------:
![](https://...Dark.png)  |  ![](https://...Ocean.png)
```

# Tridactyl for firefox

## Installation
* Download the `.xpi` file from git and install it from `Addon > 'gear menu' > Install from file`
* Then, install natively using `:nativeinstall`, which involve pasting the clipboard into a terminal to install something via curl, and then `:native` in firefox.

## Settings
In `~/.tridactylrc`, add
```
" find
bind ? fillcmdline find -?
bind n findnext 1
bind N findnext -1
bind ,<Space> nohlsearch

" Usual search for firefox
" You lose scroll down using ctrl-f
unbind <Ctrl>f
unbind d

bind qq tabclose

" Apparently slow implementation of smoothscroll by devs
" Does not perform as good as pressing Down or Up botton
"set smoothscroll true
" Smaller stepsize of scrolling, default is 10
bind j scrollline 5
bind k scrollline -5
```

## Reasons I disliked
* Hint mode is ugly (box and color)
* New tab opens the tridactyl help page by default, setting to blank page opens two tabs, weird behavior
* Hint mode on that default page produces hints for nonexistent links, and takes you to `issues` pages on github.
* Default searching keys do not follow vim, redefining search to behave like vim causes to lose incsearch 
* No `ma`, `mb` etc to mark locations in page. `'a` opens some search menu instead of jumping to mark.
* Sourcing `.tridactylrc` does not apply changes, requires restart. Options specified from withing Firefox persists over restarts. Where are those settings stored?
* Could not use vim as default editor sadly
* Smoothscroll is jumpy, and not by default. Holding `j` after turning on smoothscroll makes the scroll look very ugly.
* Unable to remap keys to another keys (e.g. `j` to `Down`)

## Features I enjoyed
* `;k` to kill elements of the page
* `g?` to encrypt page with cypher
* `C-i` to edit in vim directly (although could not make it work with vim+xfce4-term)
* Open or save images from the hint mode
* Bookmark add/delete directly with `A`
* `C-o` and `C-i` to jump to previously scrolled position within a page

# Vimium features

## Settings
In vimium preference, go to `Advanced` and then paste in `Custom key mapping` the following

```
# Insert your preferred key mappings here.
map <c-d> scrollPageDown
map <c-u> scrollPageUp

unmap x
unmap X
unmap u
unmap d

map qq removeTab
map u restoreTab
```

## Copy and google text found within a page
* (optional) Use Find `/` to place the cursor near a desired location
* Go to visual mode with `v`
* Press `c` to enter Caret mode, where the cursor can be moved around to select the starting point of the visual mode
* Press `v` to start selecting
* Press `j/e/w` etc to select region
* Press `p/P` to search the selected string directly, or `y` to yank it.

## Useful keystrokes
* To visit last visited tab:
 Press `Shift-6` or `<Shift-t><Enter>`. For second last tab, `<Shift-t><Tab><Enter>` etc.
* To detach current tab into  a new window: `W`
* Move tab left or right using `<<` or `>>`
* Copy current address using `yy`
* Possibly turn on `Use the link's name and characters for link-hint filtering` so that you can start typing the string of the link right away instead of waiting for the link text to be generated.

# Imagemagic `not authorized` to convert pdf

Edit `/etc/ImageMagick-6/policy.xml` to change the line
```
  <policy domain="coder" rights="read|write" pattern="PDF" />
```
# Extract png from pdf files
Converting pdf to png using `imagemagick` using
```
convert input.pdf -density 300 -quality 100 output.png
```
produces blurry and low quality images.

use `pdfimages` to extract png from pdfs.

# C++ tutorial comparison with C
[See](http://www.ericbrasseur.org/cppcen.html?i=1)

## Strings

Define strings as `std::string` datatype with `#include<string>` (or just `string` if `using namespace std;` is present). No need to do `strcpy()`, we can equate strings.
```
#include <string>
using namespace std;
int main(){
	string astring = "hello";
	// copy to another string
	string another_string;
	another_string = astring;
	cout << another_string << endl;
	return 0;
}
```

	

## Changing value by reference
The new datatype `double &` (caution: not `double *`) is introduced. `double &()` has datatype `double` and `&()` is implicitly applied and converted back based on the context.

In C, to set `r=100` via reference, we can do
```
void main(){
	double hundred = 100;
	double *mem = &hundred; // mem is of datatype double *, &hundred is the reference
	double r = *mem;	//the value of reference mem	

	cout << r << endl;
}
```

In C++,  `double &`, can create a symbolic link.
```
void main(){
	double hundred = 100;
	double &r = hundred; // r is double, &(r) is set to &(hundred)

	// changing the value of symlink changes the value of the target
	r = 200;
	cout << hundred << endl;	// outputs 200 instead of 100
}
}
```
This is equivalent to considering `r` as a symbolic link to `hundred`. The symlink to `r` cannot be changed at a later state.

## Passing by reference

Changing the value of a variable via a function is done in C like this:
```
void main(){
	double r = 50;
	s = change(&r); // &r is the address of r
}
void change(double * v){ 	// double * is the datatype (address type) of the input
	*v = 100;		// *v = *(&r) = r
}
```
In C++, it can be done using symlink `double &`:
```
void main(){
	double r = 50;
	s = change(r); // &r is the address of r
}
void change(double &v){ 	// v is a symlink of r via reference	
	v = 100;		
}
```

		
## Default values

This allows the number of inputs to be variable as well.

```
double test (double a, double b = 7) {
   return a - b;
}

void main () {
   cout << test (14, 5) << endl;    // Displays 14 - 5
   cout << test (14) << endl;       // Displays 14 - 7
}
```


## See the datatype of a variable
See the datatype of the variable `r` using
```
#include<typeinfo>
cout << typeid(r).name() << endl;
```


## C++ class 

Recall, a C `struct` can be defined by
```
using namespace std;
#include <iostream>

struct vector {
   double x;
   double y;

   double area () {
      double s;
      s = x * y;
      if (s < 0) s = -s;
      return s;
   }
};

int main () {
   vector a;

   a.x = 3;
   a.y = 4;

   cout << "The surface of a: " << a.area() << endl;

   return 0;
}
```

A __class__ is a `struct` with _hidden_ variables that cannot be accessed from outside. To allow access to specific members, use `public:`. i.e.
```
class vector {
public:
   double x;
   double y;

   double area () {
      double s;
      s = x * y;
      if (s < 0) s = -s;
      return s;
   }
}
```
Everything else remains the same.


#### Constructor

We define a class called `vector`. The constructor `vector(a,b)` is defined within the class.


```
class vector {
public:

   double x;
   double y;

   vector (double a = 0, double b = 0) {
      x = a;
      y = b;
   }
};

int main () {

	// define a instance k of class vector
   vector k;
   cout << "vector k: " << k.x << ", " << k.y << endl << endl;

   vector m (45, 2);
   cout << "vector m: " << m.x << ", " << m.y << endl << endl;

   vector p (3);
   cout << "vector p: " << p.x << ", " << p.y << endl << endl;

   return 0;
}
```

A __shorter__ way to define constructors and set default values to the public variables (initialize the public variables) is by _direct initialization_:
```
class Point3 {
public:
  double d_x;
  double d_y;
  double d_z;

  Point3() : d_x(0.), d_y(0.), d_z(0.){};
}
```

or, alternatively
```
class Point3 {
public:
  Point3(double d_x, double d_y, double d_z) : d_x(0.), d_y(0.){
      d_z = 0;
  };
}
```

Here, the constructor assigns a zero double value to the all public variables.


Better define a _destructor_ (using `~<class_name>`) to free memory if `new` has been used to allocate memory within the constructor.

[ ] Does not work
```
#include<sting>
#include<iostream>
using namespace std;

class vector {
public:

   double x;
   double y;
   double *asso_matrix;

   vector (double a = 0, double b = 0) {
      x = a;
      y = b;
      asso_matrix = new double [10];	// allocate memory
   }

   ~vector(){
	delete [] asso_matrix;
   }
};
```

* If another class B is a member variable of class A, how do I initialize B from A's constructor?
Use shortcut assignment like this:
```
class B{
public:
	int size;
	B(int N){
		size = N;
	}
};

Class A{
public:
	int length;
	B instB;

	// constructor
	A(int M): instB(M){
		length = M;
	}
```


##### Templated constructor
If your constructor depends on a template, you _cannot_ move the implementation of the constructor outside the header file, where the constructor is defined.
For example, the following code will throw error `undefined reference to`...:

In `file.h`
```
template <typename ttype>
class cl{
	public:
		int N;
		cl(ttype R);
};
```
In `file.cpp`
```
template <typename ttype>
cl<ttype>::cl(ttype R){
	// do something with R
}
```

To avoid this error, either move the implementation to the header file, **or** list down examples of possible `ttype` at the end of the implementation file using the keyword `template` (e.g. `template class<ttype_1>;` etc).
I prefer the second version since header-implementation separation is maintained (you can hide the implementation after `.o` files are generated).

 1. Implement where it is defined
In `file.h`	
```
template <typename ttype>
class cl{
	public:
		int N;
		cl(ttype R){
			// do something with R
		};
};
```
 or implement later in the same header file
In `file.h`
```
template <typename ttype>
class cl{
	public:
		int N;
		cl(ttype R);
};

template <typename ttype>
cl<ttype>::cl(ttype R){
	// do something with R
}
```
 
 2. List down examples of _all_ possible `ttype`s that you will be using through that template:
In file `file.cpp`
```
template <typename ttype>
cl<ttype>::cl(ttype R){
	// do something with R
}

template cl<double>;
template cl<int>;
template cl<RowVector2d>;
```


Such a terrible failure by C++ people to resolve the inconsistency between separation of definition vs implementation and templating.
	
##### Templated function
Similar to templated constructors, if you want to separate the header file from its implementation, we need instantiate the templated functions. For example,
In `code.h`
```
template <typename ttype>
int myfunc(ttype a, ttype b, double c);
```
In `code.cpp`
```
template <typename ttype>
int myfunc(ttype a, ttype b, double c){
	//implementation goes here
}

template int mufunc(string a, string b, double c);
template int mufunc(Vector2d a, Vector2d b, double c);
```



##### Initialize a class via its constructor _after_ it is defined without any constructor
Not really initialization, but assignment:
```
class Particle{
	public:
	size N;
	Particle(int a){
		N = a;
	}
};

void main(){
	Particle P;
	P = Particle(10);
}
```
		

#### Accessing class variables and methods
* The variables and functions (_methods_) within `public:` can be accessed (or set) by using the dot operator.
Let the class `vector` be defined as

```
class vector {
public:
   double x;
   double y;
}
```

Now, within `int main()`, we can do

```
vector v; 
v.x = 5;
```
* The arrow operator `->` can be used to access variables and methods of a class instance if the instance name is a reference. i.e.
```
vector * v = new vector ;
v->x = 5;
delete v;
```
or
```
vector u;
u.x = 5;
u.y = 4;

vector * v;
v = &u
v->x = 10;
```

__Caution:__ Note that 
```
vector *v;
v->x = 5;
```
results in segmentation fault since `v` is never initialized and hence `v->x` points to a non-existing location in memory. In the fist example `new` allocates memory (which is a form of initialization), and in the second example `v = &u` copies the already-initialized `u` into `v`, thus providing `v` with well-defined memory location. An alternative would be to redefine the class to add a constructor `vector()` within it and make sure the variables `x` and `y` are initialized there, possible via default variables.

Similar statements hold for methods of the classes, e.g. `v->area()` can be used where `vector * v` is initialized with `vector * v = new vector;`, for example.

__Tip:__ Delete the allocated class with `~` if `new` has been used.

#### Helper function for a class: needs to be defied _before_ the call
If you call a function that was defined outside the class, you _may_ get the error that the function `was not declared in this scope`. For example, the following code will throw error:
```
class CC{
	public:
		CC(){
			call_func();
		}
};

void call_func(){
	//code here
};
```
The solution is simply to move the function _before_ the class definition (in particular, before the function was called). This situation may not arise if the function definition was written in a header file like this `void call_func();` and this file contained the implementation of it, and that header file was included in this file.


#### Static variables
Static variables defined within a class are shared by _all_ instances of the class and are defined _outside_ the class. Their values are the same across _all instances_ of a class. For example,
```
class vector(){
	static int count;

	vector(){
		count ++;
	}
}
// Set outside the class description
int vector::count = 0;

int main(){
	vector a;
	// cout = 1
	vector b;
	// cout = 2
	vector c;
	// cout = 3
}
```

A variable that is to be the same across all instances of a class and is _not_ meant to be changed anywhere in the code can be defined using `const static` _inside_ the class.

## Overloading
Using the same name to mean different things, based on indicative properties such as datatype, number of arguments, etc.

#### Using namespaces
Same variable names can be defined in different namespaces
```
namespace first {
   int a;
   int b;
}

namespace second {
   double a;
   double b;
}

int main () {
   first::a = 2;
   first::b = 5;

   second::a = 6.453;
   second::b = 4.1e4;
}
```

To avoid writing the namespace along with the variable, declare the variable along with namespace like this
```
#include<iostream>
using namespace std::cout;
using namespace std::endl;
```
Later, we can just write `cout << 'Hi' << endl` instead of the long `std::cout << 'Hi' << std::endl`.

#### Function name overloading
Depending on the datatype of the function, we can define different implementations of the same function name

```
double test (double a, double b) {
   return a + b;
}

int test (int a, int b) {
   return a - b;
}

int main () {
   double   m = 7,  n = 4;
   int	    m = 7,  n = 4;
}
```

#### Overloading within a class
__Special case:__ constructor is a typical function and can be overloaded.
The implementation on the constructor can change based on the number and type of input variables to the constructor.
```
class testc {
	public:
		double a;
		double b;
		
		// no input
		testc(){
			a = 5;
			b = 5;
		}

		// two double inputs, second one optional
		testc(double p, double q=3){
			a = p;
			b = q;
		}
		
		// one int and one double input, second one optional
		testc(int p, double q=4){
			a = p;
			b = q;
		}
};
int main(){
	testvec t1;		//t1.b = 5
	testvec t2(5.0); 	//t2.b = 3
	testvec t3(5);		//t3.b = 4
	testvec t4(2,1);	//t4.b = 1	
}
```

__Good practice:__ to _not_ use multiple constructors. Instead, use single constructor and specify default values.

#### Operator overloading

Operators can be overloaded, for example, to define `+` between two classes.

## C++ project structure
[See appropriate section of link](http://www.ericbrasseur.org/cppcen.html?i=1)
The idea is to keep the following separate: 
  - The header files with definitions only (e.g. `vector.hpp`)
  * Functions have to be defined _before_ they are called. This is especially important when the header and implementation files are not separate.
  - The implementations of methods defined in the header files (e.g. `vector_implementations.cpp`)
  - The test code that uses rest of the code base, but does not contain main implementations (e.g. `testing_code.cpp`)

This way, we can generate an object file called `vector_implementations.o` from the header and the implementation using
```
g++ -c vector_implementations.cpp
```

At this point, the file `vector_implementations.cpp` is unnecessary. However, we still need `vector.h`.

Later, link the object file while compiling the test code using
```
g++ testing_code.cpp vector_implementations.o -o output_exec
```
and run the output executable using
```
./output_exec
```

* Keep the namespace, class definition, public variables, and public method definition with `.hpp` files.
For example the following header file `allvectors.hpp` contains
```
class vector {
public:
   double x;
   double y;

   double surface();
};

class morevector {
public:
   double x;
   double y;

   double surface();
};
```
* Keep the implementations of the methods defined within the classes in `.cpp` files. In those file, import the corresponding header files. The full name of the methods need to be used (e.g. `double <class_name>::method_name()` etc).

For example, the following `working_with_vectors.cpp` contains
```
using namespace std;
#include "allvectors.hpp"

double vector::surface() {
   double s = 0;

   for (double i = 0; i < x; i++)
   {
      s = s + y;
   }

   return s;
}
```

* Keep the executable code (the one with `int main()`) in another `.cpp` file.
For example, the file `testing_the_code.cpp` contains
```
using namespace std;
#include <iostream>
#include "allvectors.h"
int main () {
   vector k;

   k.x = 4;
   k.y = 5;

   cout << "Surface: " << k.surface() << endl;

   return 0;
}
```

#### More 
* Functions have to be defined _before_ they are called. This is especially important when the header and implementation files are not separate.
* Floating point arithmetic error: subtraction of the floating point number that are very close to each other produces a large roundoff error. For example, the following code
```
double u =  5.7;
double p_x = 0.1;
double a = (p_x + u) - u;
std::cout << "diff: " << p_x - a << std::endl;
```
produces an error of about `2e-16`, which is pretty large compared to the machine-epsilon of `double`.
To avoid such incidents, 
 1. Reformulate the algorithm to avoid risky subtraction and division
 1. Increase the precision temporarily while adding and subtracting:
```
double a = ((long double) p_x + (long double) u) - (long double) u;
```
 1. Finally, reduce the number of operations to mitigate the effect of round-off errors.

**Solution:** Use `long double`. The datatype `double` is accurate up to `16` significant digits. So, numbers larger than 16 digits are read incorrectly.
[Here](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html) is an interesting explanation where the provide example of something like this happening.

A [post](https://scicomp.stackexchange.com/questions/26370/improve-numeric-stability-of-subtraction-in-c) explains it very well in comparison to Matlab's trick to avoid such error.
* Inheritance, polymorphism etc
* `std::vector<double>`
* `this` is used to denote the pointer to the instance of the class, eg. for `delte this;`. However, it is rarely used. Another usage is to get information from the base class while calling from within a derived class.
* 

## Arrays
* Single array can be defined directly as
```
double arr[] = {1, 3, 4, 5};
double 2dArr[] = {{1,2},{2,3},{5,6}};
```
* Allocate memory using
```
double * arr = new double[5];
```
and can be freed using 
```
delete[] arr;
```

__Caution:__ 2D array cannot be allocated if the second index is a variable, i.e.
```
int i, j;
double * arr = new double[i][j];
```
is invalid!!!
* The name of the array is the pointer to the array, i.e. 
```
int a2[] = {1, 2, 3};
int * arr;
arr = a2;	// arr is now a2
```
So, we can pass the array name to a function that takes pointers, like this
```
void afunc(double * arr){
...}
void main(){
    double a2[] = {1, 2, 3};
    afunc(a2);
}
```


### Vector-related help

* For Matlab-like operations, the most useful datatype is `Array` by the `Eigen` library. You can do point-wise multiplication that you cannot do with datatypes like `Vector`.
* For 2D row vectors, we will use `Array<double, 1, 2>`.

* C++ datatype `std::vector<ttype>` can contain an array of datatypes of any kind, but it cannot do element-wise operation like vectors do.

For example, the following assignment won't work
```
vector<int> v={2, 3, 7};
vector<int> u;
u = v;
```
You need to `push_back()` each entry into `u`:
```
vector<int> u;
for (int i; i<v.size(); ++i){
    u.push_back(v[i]);
}
```

However, the datatypes like `Eigen::Vector2d` etc from the library `Eigen` can do assignment easily. 
```
Vector2d v = {1, 4};
Vector2d u = v;
```
Unfortunately, with `Eigen`, we cannot construct `Vector2d` of non-numeric objects, which `std::vector` allows, e.g. `vector<myClass> v`.

* The `std:vector` must have a well-defined size before we assign values to them directly. 
The following code will throw `Segmentation fault` error:
```
vector<int> w;
w[0] = 1;
```

Instead, specify the size while defining using `vector<int> w(2);` or using a `resize()` function after defining like `w.resize(2);` After that, the assignment `w[0] = 1` will be valid.


#### Removing elements from the vector: `.erase()` **done using pointers**

Create a vector using
```
vector<double> v;
v.push_back(1.5);
v.push_back(3.4);
v.push_back(4);
v.push_back(6);
v.push_back(5);
v.push_back(4);
v.push_back(2.4);
std::cout << v << std::endl;
std::cout << v.size() << std::endl;
```

To remove the value `3.5` (`v[1]`) from  the vector, do
```
v.erase(v.begin()+1);
```
Here, `b.begin()` is the pointer to `v[0]` and `+1` takes to pointer to the next value in the vector.

* Remove a consecutive list of values using
```
v.erase(v.begin()+2, v.end()+5);
```

* Remove multiple elements (use `remove()` followed by `erase()` instead, see below):
To remove all elements bigger than `3`, do:
```
for (auto i = v.begin(); i != v.end(); ++i) {
    if (*i > 3) {
	v.erase(i);
	--i;
    }
}
```
The `i--` is essential to go with `.erase()` since `v` changes size during the loop and  `v.end()` means nothing. Therefore `i` can run over the current `v.end()` and output garbage.

* Note that  you can do pointer algebra with `int`. For example,
```
int steps = i - v.begin();
```
is valid in the code above.

* Use `remove()` to remove multiple elements faster and ignoring the for loop:
[The *erase-remove idiom*](https://en.wikipedia.org/wiki/Erase%E2%80%93remove_idiom)
The `remove()` function from `#include<algorithm>` does _not_ create a final reduced vector, but simply shifts the values forward after removing elements, resulting in an unspecified size of vector, which actually contains the final (reduced) vector in its first few places.
We need to `erase(begin_ptr, end_ptr)` those last few garbage values using the output of `remove()`, which is the _beginning_ (`begin_ptr`) of these garbage values and `v.end()`, the original _ending_  `end_ptr` of  the garbage values.

The output of the `remove()` function is the starting points of the first item _after_ the final reduced array.

#### Eigen with OPENMP
It seems that there is some error (why?) if I use Eigen with `-fopemmp`. So, turn of Ei-gen's own parallelism using
```
#define EIGEN_DONT_PARALLELIZE
```
in the beginning of the file containing `int main()`.

# Matlab parfor tutorial

* In the gui mode, increase set the default number of workers to 20 (from 12)
* Start the local pool with `parpool('local', 16)` to start 16 workers
* Run your code next 
* Close the pool with `delete(gcp('nocreate'))`

* To load `.mat` files in parallel, call `load()` in an external function (file), e.g. `load_ext.m`
```
function str = load_ext(filename)
	str = load(filename);
end
```
Later, call the file from within parfor:
```
parfor i=1:10
	str = load_ext(strcat('data/file_'), num2str(i), '.mat');
	% extract the varibles from the struct
	matrix_1 = str.matrix_1;
	do_something_with(matrix_1);
end
```



# Makefile help

## Rule to write a makefile

```
output_filename: dependency_filename_1 dependency_filename_2
	full_shell_command_here
```

* There has to be a Tab character before the `full_shell_command_here`.
* When `make` is run without any argument, the first rule is executed. So, it is convenient to add the rule `all:` that combines all the steps.
* The `output_filename` can also be replaced by a `rule_name` which is not a filename, but a random string. e.g.
```
dir:
	mkdir build obj
clean:
	rm -r build/* obj/*
```
* When `make output_filename` is executed, `make` checks if `dependency_filename_1` and `dependency_filename_2` are up to date. If they are not, the rule associated with those files are executed first, provided they exist, viz
```
dependency_filename_1:
	shell_command_that_outputs dependency_filename_1
dependency_filename_2:
	shell_command_that_outputs dependency_filename_2
```

Here is an example where we have a client file `main.cpp`, headerfile `includes/header.h` and implementation `includes/header.cpp` of the header. We would like the following:
* If header file and implementations are unchanged and only `main.cpp` is modified, compile only `main.cpp`
* If header file or the implementation is modified, compile all 3 files.
Example makefile to accomplish that:
```
main.out: header.o
	gcc main.cpp header.o -o main.out
header.o: header.cpp header.h
	gcc -c header.cpp -o header.o
```

Comment: It is probably safe to assume that if you edit the header file `header.h`, you would edit the implementation file `header.cpp` as well. Moreover, it is hard to list down all the header files which the file `header.o` depends on. So either be extremely cautious while running `make` to avoid missing out on compiling edited files, or meticulously list down all the dependency files of `header.o`.

* We can use `$@` to denote the target `output_filename` and `$?` to denote _all_ the dependencies (i.e. `dependency_filename_1 dependency_filename_2`). Another macro is using `%.` to denote _any_. e.g. the code
```
file1.o: file1.cpp file1.h
	gcc -c file1.cpp -o file1.o
file2.o: file2.cpp file2.h
	gcc -c file2.cpp -o file2.o
file3.o: file3.cpp file3.h
	gcc -c file3.cpp -o file3.o
```
can be replaced by

```
%.o: %.cpp %.h
	gcc -c $? -o $@
```
**Caution:** Compiling the cpp file along with the header file into an object file (`gcc -c file.cpp file.h`) and linking it to other files causes a syntax error `.o: file format not recognized; treating as linker script`. (Why?)
Two alternatives:
 1. Use `$<` (instead of `$?`) to denote the _first_ argument in the dependency list.
 2. Remove the `%.h` from the dependency list

* To forcefully mark all the files as up-to-date, run `make -t`. This is useful when you do not want to recompile the header and implementation _even after_ you have edited them, but you only want to compile the client runfile.

* Specify the location of the header files using `-I` flags, e.g.
```
INCLUDES_DIR_1 = includes
INCLUDES_DIR_2 = headers

CPPFLAGS += -I$(INCLUDES_DIR_1)
CPPFLAGS += -I$(INCLUDES_DIR_2)
```
later, supply that to the `g++` parameters in the makefile using `g++ -c input.cpp $(CPPFLAGS)`

* C++ `undefined reference to` error after the definition of the function is clearly defined:
Linking issue: Make sure the object (`.o`) file created from the implementation of the file is linked to the client file, something like
```
gcc main.cpp obj1.o obj2.o -o outfile
```

### String replacement

```
# Get all cpp files in the subdir structure
T_cpp = $(wildcard  $(INCLUDE_DIR)/**/*.cpp)
# .cpp replaced by .o
T_o = $(T_cpp:%.cpp=%.o)
# Replace the include path structure by object path structure: pattern-substitute
T_o_Build = $(patsubst $(INCLUDE_DIR)/%, $(OBJ_DIR)/%, $(T_o))
```

* Generating the object files in a separate directory (from the source code) while maintaining the directory structure: 
If your `.h` and `.cpp` files reside in `$(INCLUDE_DIR)` directory (within subdirectories of if, possibly) and you want move the object files to `$(OBJ_DIR)`, do
```
$(OBJ_DIR)/%.o: $(INCLUDE_DIR)/%.cpp
	@echo "Building:"
	$(CC) $(CCFLAGS) -c $? -o $@ $(CPPFLAGS)
```

This assumes that _all_ the subdirectories of `$(INCLUDE_DIR)` are to be compiled.

Later, supply all the object files to the main target using a wildcard like `ALL_O = $(wildcard  $(OBJ_DIR)/**/*.o)`
```
ALL_O = $(wildcard  $(OBJ_DIR)/**/*.o)
mainTarget: ALL_O
	$(CC) $(CCFLAGS) main/mainTarget.cpp $? -o $@ $(CPPFLAGS)
```

### Timestamp in C++
* To print the current time in C++ do the following:
```
#include <time.h>

time_t my_time;
char timestring[80];
strftime(timestring, 80, "%F-%T", localtime(&my_time));

std::cout << timestring << std::endl;
```


# ABD (Android development bridge) help
Short list from [some guy](https://github.com/sncvikas/ADB_Commands)
Long list from [android manual](https://developer.android.com/studio/command-line/adb)

* Run a shell command with `abd shell`, followed by the shell commands.
```
adb shell ls
adb shell stop
adb shell reboot
```
Alternatively, enter the shell with `abd shell` and run usual shell commands.

* Transfer file using `adb pull` and `adb push`
```
adb pull /sdcard/test.png
adb push ~/Downloads/test.apk
```

* Take screenshot using `screencap`
```
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```
Use `screenrecord` to record screen video.

* Package manager related tasks
All packages:
```
adb shell pm list packages
```

| Fileter packages   | parameter   |
| :----------------- | :---------- |
| System apps only   | `-s`        |
| Third party apps   | `-3`        |


* Install external apk using
```
adb install filename.apk
```

* Uninstall apps, from a user
```
adb shell uninstall com.example.MYapp
adb shell pm uninstall -k --user 0 com.MYApp
```
Reinstall them using 
```
adb shell cmd package install-existing com.onyx.latinime
```

* Disable an app (without installing)
```
adb shell pm disable <package_name>
```
The `<package_name>` can be found by searching with a string like this:
```
adb shell pm list packages -e | grep 'calculator'
```

* See the list of active internet connections
```
netstat -lantp
```

* Press a key
```
adb shell input keyevent <KEYCODE>
```
Example:
```
adb shell input keyevent  KEYCODE_MENU
adb shell input keyevent  KEYCODE_HOME
adb shell input keyevent  KEYCODE_BACK
```

* Enter text into a open text box
```
adb shell input text <text goes here>
```

* Reboot into the recovery mode
```
adb shell reboot recovery
```
* See system info
```
adb shell getprop
```

* Extract all apk files:
```
for i in $(adb shell pm list packages | awk -F':' '{print $2}'); do adb pull "$(adb shell pm path $i | awk -F':' '{print $2}')"; mv base.apk $i.apk 2&> /dev/null ;done
```

* Onyx uninstalled apps:
com.onyx.mail
com.onyx.appmarket
com.onyx.latinime
com.onyx.android.onyxotaservice
com.onyx.android.production.test
com.onyx.pinyinime
com.onyx.floatingbutton
com.android.browser
com.android.email
com.android.providers.calendar
com.android.calendar
com.google.android.syncadapters.calendar
com.quicinc.cne.CNEService

* Onyx installed apks:
```
gboard
fluid navigation bar
fx file browser
```

# matplotlib help

* Import using 
```
import matplotlib.pyplot as plt
```

* Equal axis
```
plt.axis('scaled')
```
* Axis limit
```
plt.xlim(-2e-3, 2e-3)
```
* Save to file
```
t = 5;
ind = ('%05d' % t)
output_filename = 'data/'+ind+'.png'

plt.savefig(output_filename, dpi=150)
```

* To open the plot in the background (and not show), add the following (in addition to `import matplotlib.pyplot as plt`)
```
import matplotlib
matplotlib.use('Agg')
```

# Openmp help

## Requirements
* Add `#include<mpi.h>` 
* Compile with `-fopenmp`
* Compute the time taken by the executable by running it with `time -p` prefix in shell

## Information
[Guide](https://bisqwit.iki.fi/story/howto/openmp/) 
[Thirty minute guide](https://www.linuxtoday.com/blog/mpi-in-thirty-minutes.html)

```
omp_get_num_threads()
omp_get_max_threads()
omp_get_thread_num()
omp_get_num_procs()
```

* Check if you are using the right number of processors:
```
grep 'processor.*:' /proc/cpuinfo | wc -l
```
* The number of threads are optimized (usually) when it is the number of processors.
With  2 cpus and 2 threads per cpu, the optimum value is 4, the total number of (virtual) cpus.


* Set environment variables different from the default value for maximum possible threads using
```
export OMP_NUM_THREADS=4
```
This will be reflected in `omp_get_max_threads()`.

This can also be set within the code with
```
#pragma omp parallel num_threads(4)
```

* Setting the value outside the code is recommended for flexibility and transparency.

* Setting `num_threads()` is usually unnecessary as the default value (=#cpus) is usually the best.

* Setting `num_threads()` manually to a fixed number is _not_ flexible. If necessary, can be expressed in terms of `omp_get_max_threads()`.


### Repetition of a block of code
```
#pragma omp parallel
{
	code_1();
}
```
Here, `code_1()` will be executed `omp_get_max_threads()` number of times.

* You can specify how to many threads will be used for that particular parallelism by
```
#pragma omp parallel num_threads(7)
```

* If you want a part of the code block to execute only once, use `single`
```
#pragma omp parallel
{
	// this will run multiple times
	code_1();

	// this will run only once
	code_2();
}
```

### For loop:

* Simply:
```
#pragma omp for
for(int n=0; n<10; ++n){
	printf(" %d", n);
}
```
Note that there is no order in which the code inside the omp directive runs.

* The `ordered` part of the code is executed in the same order of the `for` loop: (note the two occurrences of `#pragma` to specify which part of the code is ordered):
```
#pragma omp for ordered schedule(dynamic)
for(int n=0; n<10; ++n){
	// do other unordered things
	code_1();

	// now the ordered part
	#pragma omp ordered
	code_2();
}
```

Here, `code_1()` will be executed in an arbitrary order, but will stop and wait if the *previous* chunks of `code_2()` are unfinished.

* If the for loop is a sum type, we can do
```
int sum=0;
#pragma omp parallel for reduction(+:sum)
for(int n=0; n<1000; ++n) {
	sum += table[n];
}
```
This avoids the sharing of the variable `sum` by multiple threads. Instead, different threads place their partial sums while running and in the end communicates and adds those partial sums up.



*  Running parts of the code in parallel
```
 #pragma omp sections
 {
   { Work1(); }
   #pragma omp section
   { Work2();
     Work3(); }
   #pragma omp section
   { Work4(); }
 }
```
This code indicates that any of the tasks Work1, (Work2 + Work3), and Work4 should run in parallel, but that Work2 and Work3 must be run in sequence. Each work is done exactly once, *as opposed to* the following
```
 #pragma omp parallel
 {
	Work();
 }
```
which runs `Work()` multiple times.


* `critical` sections prevent multiple threads from accessing the critical section's code at the same time, thus only one active thread can update the data referenced by the code.
```
#pragma omp parallel 
{
 	code_1();

    #pragma omp critical
	code_2();
}
```

Compare this with `ordered`: 
```
#pragma omp parallel for ordered schedule(dynamic)
for(int i =0; i<10; ++i)
{
	// runs in arbitrary order 
 	code_1();

	// runs in arbitrary order, but _NOT_ concurrently by various threads
	// i.e. waits until another random thread is finished running
    #pragma omp critical
	code_2();

	// runs in the same order as the for loop
    #pragma omp ordered
	code_3();
}
```

### Nested for loop
[source](http://ppc.cs.aalto.fi/ch3/nested/).
Parallelizing of nested for loops is generally discouraged. The only case when it is advised is when the outer loop has too few elements compared to the number of threads available.

* Defining parallel twice does nothing, and increase the runtime due to overhead:
```
// bad code example
#pragma omp parallel for
for (int i = 0; i < 3; ++i) {
    #pragma omp parallel for
    for (int j = 0; j < 6; ++j) {
        c(i, j);
    }
}
```
This code does not do anything meaningful. “Nested parallelism” is disabled in OpenMP by default, and the second pragma is ignored at runtime: a thread enters the inner parallel region, a team of only one thread is created, and each inner loop is processed by a team of one thread. The end result will look, in essence, identical to what we would get without the second pragma — but there is just more overhead in the inner loop:

* For perfectly nested (one `for` after another) **rectangular** loops (i.e., the second index does not depend on the first index), we can use `collapse(level)`:

```
 #pragma omp parallel for collapse(2)
 for(int y=0; y<25; ++y)
   for(int x=0; x<80; ++x)
   {
     tick(x,y);
   }
```
Here, `2` represents the level of nesting.

In this case, two loops are converted into a single one and total iterations are distributed among the threads, *as if* the code reads

```
 #pragma omp parallel for
 for(int z=0; z<25*80; ++z)
     tick(z/80, z%80);
```

* Force enable nested parallelism using `num_threads(level);` in the beginning where `level` is the nested levels you want to enable parallelism in.
```
omp_set_nested(1);
#pragma omp parallel for num_threads(2)
    for(int n=0; n<size; ++n){
	//std::cout << "Current thread level: " << omp_get_level() << std::endl;
	//std::cout << "Started " << omp_get_num_threads() << std::endl;
	sinTable[n] = n * n + 5;

#pragma omp parallel for num_threads(2)
	for (unsigned i = 0; i < 200; i++) {
	    //std::cout << "Current thread level: " << omp_get_level() << std::endl;
	    //std::cout << "Started " << omp_get_num_threads() << std::endl;
	    sinTable[i + n] = 5 * i * n;
	}
}
```

* Check the current nested thread level using `omp_get_level()`. 
* Specify `num_threads()` so that more than available threads do not pop up, since the default number of level-1 nested parallelism produces `omp_get_num_threads()`^2 threads, which are much bigger than available threads, leading to showdown.

* Did not find any advantage in enabling nested parallelism (even after setting the `num_threads()` to be `sqrt(omp_get_num_threads())` to avoid going over total available threads) since the overheads for the inner loop adds to a delay.

### Static vs dynamic schedule for `for` loop

[explanation](http://jakascorner.com/blog/2016/06/omp-for-scheduling.html)

* `schedule(static)` divides the work between thread at *compile-time*, so it is pre-determined which thread will get which iterations of the `for` loop
* `schedule(dynamic)` divides the work between thread at *runtime*, so assignment of iterations to threads is random at runtime

* The static scheduling type is appropriate when all iterations have the same computational cost.
* `schedule(dynamic)` is more appropriate when the loop iterations are expected to take variable amount of time. The expectation is that runtime of all threads will average out and will result in smaller total runtime, whereas in the `static` case, some threads might finish their work and wait around for other threads.

* Increasing the chunk size makes the scheduling more static, and decreasing it makes it more dynamic. [source](http://www.inf.ufsc.br/~bosco.sobral/ensino/ine5645/OpenMP_Dynamic_Scheduling.pdf)

* `schedule(static)` is faster compared to `dynamic` for equal-length jobs due to less overhead when the computation costs are equally distributed.

* OpenMP guarantees that if you have two separate loops with the same number of iterations and execute them with the same number of threads using static scheduling, then each thread will receive exactly the same iteration range(s) in both parallel regions. 

* `guided` schedule reduces the chunk length over time, providing a balance between the two. You can set the minimum chunk length possible.

# Python Numpy array

* Convert numpy array to python list using `.tolist()`

* Creating zero arrays (or `ones`) need to be specified with double parenthesis
```
a = np.zeros((5,7))
```

* Matrix-matrix multiplication of numpy arrays are done using `@` operator or using `a.dot(b)`
```
a = np.array([ [1, 3], [4, 5] ])
b = np.array([ [2],[5])
c = a @ b # output: [ [17], [33] ]
```

* Matrix-vector row-wise multiplication is not automatic. We need to convert the rank-1 array (size `(3,)`) into a rank-2 array (size `(3,1)`) using `[:,None]` like this:
```
A = np.array([
    [1,2,3], 
    [4,5,6], 
    [7,8,9]
    ]) 

v = np.array([0, 1, 2])

row_A_v = A * v[:, None]
```

Note that `v` is of size `(3,)` whereas `v[:, None]` is of size `(3,1)`.

* max-min: use `np.amax()` with `axis=` 0 or 1 or _without_ for the flattened array

* Find where an element `i` appears: use `np.where(Array == i)`, which is a 2d object. Use index `[0]` to get the rows, and `[1]` to get the columns.
Caution: the output is a numpy array (`array([3, 2, 5])` etc). Covert it to usual python list (i.e. `[3, 2, 5]`)using `.tolist()`

* Appending (concatenation):
  - Numpy array: `original_array = np.append(original_array, appendage, axis = 0)` appends `appendage` as a set of rows (`axis = 0`) at the end of original_array. **Caution:** This is _not_ in-place, so we need to over write the `original_array`.
  - Python list: `list_1.append(row)` is an in-place operation.
  * We can append as columns or  rows using `np.c_[]` or `np.r_[]`, e.g.
    ```
    np.c_[
	    np.linspace(-1., 1., 1000),
	    np.random.uniform(-0.5, 0.5, 1000)
	    ]
    ```
   creates a (1000,2) matrix.


* Copying a variable into another creates only a memory reference
```
u = [ 3, 4, 5]
v = u
v[0] = 0
print(u[0]) # Output: 0 !!!
```

Same goes for classes
```
Class Cl(object):
	__init__(self, a):
		self.a = a

## Later
cl_list = []
cl_list.append(Cl(5))
cl_list.append(Cl(5))

cl_list[0].a = 7
print(cl_list[1].a) # output: 7 !!!
```

The solution is to use `deepcopy()`

* Deleting array elements is _not_ in-place. This is to avoid resizing the array while deleting.
A good idea is to delete multiple items at once and copy it to a new array.
```
index = [2, 3, 6]
new_a = np.delete(a, index)
```

# Python class
* See the list of attributes of a class using `.__dict__.keys()`

# Python plotting

## 3d scatter plot

* Note that we use `ax.scatter` instead of `plt.scatter` (for 2d plots with `import matplotlib.pyplot as plt`)
```
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure()
ax = Axes3D(fig)
ax.scatter(X, Y, Z, s = 10,  linewidth = 1 )
ax.text(X, Y, Z, str(99))
```

* **Aspect ratio:** the 3d plot messes up the aspect ratio. We _cannot_ set the aspect ratio to be equal using `ax.set_aspect('equal')`  (even though we should).
This feature is not implemented yet (what??!!) as so we add the following snippet to make it happen:
```
extents = np.array([getattr(ax, 'get_{}lim'.format(dim))() for dim in 'xyz'])
sz = extents[:,1] - extents[:,0]
centers = np.mean(extents, axis=1)
maxsize = max(abs(sz))
r = maxsize/2
for ctr, dim in zip(centers, 'xyz'):
    getattr(ax, 'set_{}lim'.format(dim))(ctr - r, ctr + r)

ax.set_box_aspect((1, 1, 1))
```
Alternatively, set x, y, and z ranges manually so that the length of the ranges are the same and do  `ax.set_box_aspect((1, 1, 1))`:
```
 XYZlim = [-3e-3, 3e-3]
 ax.set_xlim3d(XYZlim+1e-3)
 ax.set_ylim3d(XYZlim - 0.2e-3)
 ax.set_zlim3d(XYZlim + 3e-3)
 ax.set_aspect('equal')
ax.set_box_aspect((1, 1, 1))
```


[Source](https://stackoverflow.com/questions/8130823/set-matplotlib-3d-plot-aspect-ratio/19933125)
This snippet applies to `ax`, so we can convert it into a function `def fix_aspect(ax):` and call it.

* In 2D, the aspect ration can be set using
```
plt.axis('scaled')
```
and specify the axes limits using 
```
plt.xlim(a, b)
plt.ylim(c, d)
```

**Caution:** `plt.axis('scaled')` goes _before_ setting `plt.xlim()` and `plt.ylim()` for the boundaries to remain faithful.


## Plotting a bunch of lines
Plotting each line using a `for` loop is too slow. Use `LineCollection` and `Line3DCollection` instead.
The format of the data has to be in the following format:
```
[
 [ [start_x_1, start_y_1, start_z_1], [end_x_1, end_y_1, end_z_1] ], 
 [ [start_x_2, start_y_2, start_z_2], [end_x_2, end_y_2, end_z_2] ], 
 [ [start_x_3, start_y_3, start_z_3], [end_x_3, end_y_3, end_z_3] ], 
...
 [ [start_x_N, start_y_N, start_z_N], [end_x_N, end_y_N, end_z_N] ]
]
```
where there are `N` lines that start with `start` and ends at `end`. 
Note that The array has rank 3.

Example of such construction:
Given two `(N,3)` arrays `P_start` and `P_end`, to draw `N` lines between `P_start[i]` and `P_end[i]` in 3D, construct
```
ls = [ [p_start, p_end] for p_start, p_end in zip(P_start, P_end) ]
```


* Plot using
```
import matplotlib.pyplot as plt
from matplotlib.collections import Line3DCollection

lc = LineCollection3D(ls, linewidths=0.5, colors='b')

ax = plt.gca()
ax.add_collection(lc)

plt.show()
```

** Caution: ** For 2D plotting with `LineCollection`, you **must** add a scaling command like
```
ax.autoscale()
```
for the plots to show. Otherwise, no line will be printed. (weird bug?)

**Note:** that the collection added to `ax` (and not to `plt`).

# Python import module

* See the current directory from where the script runs
```
import sys
print(sys.path[0])
```

* Add a path from where to import `.py` files later
```
sys.path.append(full_dir_path)
```

* Go back one directory from the current path
```
prev_dir = os.path.dirname(sys.path[0])
```

* To add a path that is in a subdirectory `bar` within a directory that in one level up:
```
import sys, os
# previous directory of the current script
prev_dir = os.path.dirname(sys.path[0])
# print(prev_dir)
sys.path.append(prev_dir)
# sys.path.append(os.path.join(prev_dir,'bar'))
```




# Python parallel processing with multiprocessing:

Say we have a function called `write_img(t)` that takes integer values. 
The for loop
```
for t in range(starting, ending):
	write_img(t)
```
can be replaced by
```
from multiprocessing import Pool
a_pool = Pool()
a_pool.map(write_img, range(staring, ending))
```

* If the argument of the function is not a number, we can feed an iterator (array, tuple, list, etc) of the input parameters
```
def myfunc(obj):
	x = obj.x
	y = obj.y
	# some stuff with x and y
	return obj2

from multiprocessing import Pool
input_list = []
for i in range(10):
	obj_i = # some code here ...
	input_list.append(obj_i)

a_pool = Pool()
output_obj2_list = a_pool.map(myfunc, input_list)
```

* If the function takes more than one input, we can use `zip()` to combine input variables or create a partial function to convert it into a one-input function on the fly using `partial` from `functools` (which is included in the default python installation)
```
def fun2(x, y):
	return z = x * y

from functools import partial
fun1 = fun2(x, 5)

from multiprocessing import Pool
a_pool = Pool()
output_list = a_pool.map(fun1, range(10))
```

* If you get the error 
```
AttributeError: 'NoneType' object has no attribute 'pack'
```
then use
```
pool.close()
```
after the multiprocessing is over to delete the pool.

* Use `pathos.multiprocessing` (`pip3 install pathos`) instead of usual multiprocessing to use parallel processing on partial functions (to use on functions with multiple inputs)
```
from pathos.multiprocessing import ProcessingPool as Pool
```

# HDF5 dataset

* `rank` is the number of dimension of a data array
* Read any `.h5` file using `h5dump` (part of `hdf5-tools` package on Ubuntu). e.g.
```
h5dump filename.h5
```
* To see the headers `-H`:
```
h5dump -H filename.h5
```
* To see all the header of the group `mygroup` with `-g`
```
h5dump -g 'mygroup' -H filename.h5
```

* To print the dataset `mygroup/mydata` with `-d`
```
h5dump -d 'mygroup/mydata' filename.h5
```


### HDF5 dataset in C++
* In `C++` on Ubuntu, install
```
sudo apt-get install libhdf5-serial-dev hdf5-tools
```

* To compile files with `#include<H5Cpp.h>`, compile with _both_ `-lhdf5_cpp` and `-lhdf5_serial` parameters and supply the location of the header file (`locate H5Cpp.h`) with `-I`. e.g. in `makefile`, add
```
CPPFLAGS += -I /usr/include/hdf5/serial/ -lhdf5_serial -lhdf5_cpp
```

### HDF5 dataset in Matlab

* In Matlab, the pathname for a dataset within a file _has_ to start with `/`, but not in C++.

* Create group within a file before adding a dataset within the group. 
```
H5::H5File fp("output/filename.h5", H5F_ACC_TRUNC);
fp.createGroup("/FirstLevel");
// now you can add datasets like "/Firstlevel/D1" etc
```

### HDF5 dataset in python

* Install the package `h5py`
* **Caution:** Always convert the dataset to `np.array()` before reading from or writing to a `h5py` file.

* Example reading:
```
import h5py
f = h5py.file(filename, "r")

PosArr = []
for name in f:
	pos = np.array(f['P00001/Pos'])
	PosArr.append(pos)
```

# Rsync
* Sync two directories
```
rsync -rv  <user>@<server>:~/graph-cpp/output/img/ img_graph/
```

# CUDA NVIDIA

* Install `CUDA Toolkit`: 
Follow instruction on [sit](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=deblocal) to download the `.deb` and install for ubuntu version.

* Install `nvidia-profiler` to use `nvprof` with code

## OPENMP in C++
[slides](https://ukopenmpusers.co.uk/wp-content/uploads/uk-openmp-users-2018-OpenMP45Tutorial_new.pdf)
* Get the number of devices in the host using `omp_get_num_devices()` function.
Use `#pragma omp target` to run code on target devices.

# Python vispy


[Basic tutorial] (https://github.com/ipython-books/cookbook-code/blob/master/featured/06_vispy.ipynb)

[A github collection of tutorials] (https://github.com/liubenyuan/vispy-tutorial)

* Install `vispy`
```
pip3 install vispy
```

* Install a backend:
```
pip3 install pyqt5
```
or
```
pip3 install pyglet
```
For jupyter notebook use `ipynb_webgl`.
Note: for whatever reason, backend `egl` hangs the system and produces nothing.

* See the available backend using
```
import vispy
print(vispy.sys_info())
```

* Plot a test plot
```
import numpy as np
import vispy.app
# vispy.app.use_app('ipynb_webgl')
# vispy.app.use_app('pyglet')
vispy.app.use_app('pyqt5')
from vispy import plot as vp
fig = vp.Fig(show=False)
fig1 = fig[0, 0]
fig1.plot(np.random.uniform(-0.5, 0.5, 1000) ,marker_size=0)
# fig1.plot(range(10000),marker_size=0)
fig.show(run=True)
```

# MIDI keyboard for linux

Add yourself to the `audio` group and then `reboot` or (log out and log in)
```
sudo usermod -a -G audio <username>
```

## On raspberry pi, to reduce the latency, add following to the file `/etc/security/limits.conf`
```
@audio   -  rtprio      90
@audio   -  memlock     unlimited
```

## Previous command shortcut in terminal
* `!!` is the last command from `history`
* `!^` is the first argument (i.e. the second word) of the last command, and `!$` is the last argument (i.e. last word of the command)
```
cp file1.txt file2.txt
mv !^ file3.txt
```
implies
```
mv file1.txt file3.txt
```
* `!-2` is the second last command from the history
* `!cp:1` is the fist variable of the last command starting with `cp` (verify)

# py3status bar with i3 async_script

We can redirect the output of any script to the py3status bar using the module `async_script`. To achieve this

- First we create a pipe called `statuspipe` in `~` using
```
mkfifo statuspipe
```
-  Then, we create a script `~/.myscr/readstatuspipe` that perpetually reads from the pipe
```
!/bin/bash
cat < ~/statuspipe
```
**Note:** The first line is essential, otherwise, we will get the error `invalid exec format`.

- Create a module in `$HOME/i3status/config`

```
async_script {
    format = "Out:{output}"
    script_path = "/home/debdeep/testpipe"
}
```
and add it to the list
```
order += "async_script"
```
and reload the status bar.

- To use the pipe, redirect the output of any script to it like this:
```
ping 127.0.0.1 > ~/statuspipe
```

# i3 Window manager with xfce4-panel

* Right click on `xfce4-terminal` and go to `Preferences > Appearance > Display border around the new window` to disply the container title of the termial window.

* Taking window out of its parent container: move the window outward once more after it reaches the boundary of the container
* Moving a window into its sibling container:
	0. Move the window next to the container
	1. [necessary] prepare the container by pressing `Mod+e` (verticle or horizontal split toggle)
	2. Select the window that will move into the container
	3. Move in the direction of the container

# Disable the  use of swap space

* To temporary turn off swap space and move all data to ram, turn off and turn on swapping:
```
sudo swapoff -a; sudo swapon -a
```

* Check the current swappiness using
```
cat /proc/sys/vm/swappiness
```
A value of 10 is recommended, which means the system will move ram to swap space (located in disk) if the available ram falls below 10%.

* To permanently set swappiness to 10:
```
sudoedit /etc/sysctl.conf
```
Add this line 
```
vm.swappiness = 10
```
Finally, restart system
```
    sudo shutdown -r now 
```

* With kernel version 3.5+ setting swappiness to 0 does turn it off entirely and a setting of 1 is recommended if you want the lowest swappiness algorithm. source: https://www.percona.com/blog/2014/04/28/oom-relation-vm-swappiness0-new-kernel/

# Another C++ tutorial

## Compilation process
* __preprocessing__: replacing all occurrence of `.h` files in the `.c` files by their code
* __compiling__: convert all `.CXX` files into machine-readable _object_ files with extension `.o`
* __linking__: link libraries to object files and generate the combined _executable_ files
* __building__: a general term for the complete process of preprocessing, compiling, and linking 
* __header file__: with `.h` extension
* __source file__: with `.CXX` extension

## C++ directory structure
```
.
 |-- CMakeLists.txt
 |-- build
 |-- include
 |   \-- includefile.h
 \-- src
     |-- includefile.cpp
     \-- mainapp.cpp
```

The built files will be stored in the `build` directory.

## Compilers
When building programs in C++, use `g++`, which is a counterpart of `gcc` that compiler C files. `gcc` (or `g++`) does preprocessing, compilation, assembly, and linking in that order.

###`gcc` (and therefore `g++`) options:

* `gcc` does _not_ allow grouping of single-letter options. (i.e `-dv` is different from `-d -v`)
* It matters where (in which order) the `-l` option is specified.
* To stop the building process before linking, use `-c` option. It does only compilation and assembly, but _not_ linking. It produces `.o` files.
* Use `-S` to stop after compilation. Does not assemble. It produces `.s` files that are to be used in assembly.
* Use `-E` to stop after preprocessing. Does not compile. The preprocessed source code is sent to stdout.
* `-###` to print the commands executed to perform the building process, but does not run the steps. `-v` actually run the steps in addition to printing them.

## CMake tutorial

`cmake` generates a `MakeFile` automatically so that you don't have create it yourself. 
Howeve, we need to write a `CMakeLists.txt` file with all the information.

[link](http://derekmolloy.ie/hello-world-introductions-to-cmake/)

* `set(VARNAME value)` sets a variables. For example, `set(CMAKE_BUILD_TYPE Release)`. To call the variable, use `${VARNAME}`.

* Add compiler of linker flags:

 1. Define the flags first, using
```
SET(GCC_COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
SET(GCC_COVERAGE_LINK_FLAGS    "-lgcov")
```
 1. Later, set the flags by appending them to the existing flags, like this:
```
SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
SET(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")
```

* Set the location of header files (`.h`) using `include_directories(include)`.

* The output executable file name, and the source file(s) that are used to generate the executable are set using `add_executable()`. 

For example, `add_executable(testapp mainapp.cpp)` generates the executable `testapp` from the file `mainapp.cpp` (when there is no header file involved).

When header files are involved, we have different ways to incorporate them in building the executable file.
 1. Add `include_directories(include)` beforehand
 1. Specify all source files individually like this
```
set(SOURCES src/mainapp.cpp src/Student.cpp)
add_executable(testapp ${SOURCES})
```
 1. Specify all source files using wildcard
```
file( GLOB SOURCES "src/*.cpp")
add_executable(testapp ${SOURCES})
```

#### Typical `CMakeLists.txt` file:

```
cmake_minimum_required(VERSION 2.8.9)
project(Project_Name)

#Bring the headers, such as includefile.h into the project
include_directories(include)

#Can manually add the sources using the set command as follows:
#set(SOURCES src/mainapp.cpp src/Student.cpp)

#However, the file(GLOB...) allows for wildcard additions:
file(GLOB SOURCES "src/*.cpp")

add_executable(testStudent ${SOURCES})
```



# Video recording from command line

* Using command line `vlc`

```
cvlc v4l:///dev/video0 --sout file/avi:movie.avi
```
* Using ffmpeg
ffmpeg -f video4linux2 -s 320x240 -i /dev/video0 out.mpg

* To take picture,
```
sleep 1s;gst-launch-0.10 v4l2src num-buffers=1 ! jpegenc ! filesink \
location=$HOME/Pictures/failedlogin.jpg
```
[Source](http://ubuntuforums.org/showthread.php?t=1418586)

```
gst-launch-extra v4l2src ! videorate ! video/x-raw-yuv,width=640,height=480,framerate=15/2 ! ffmpegcolorspace ! theoraenc quality=20 ! oggmux name=mux alsasrc ! audio/x-raw-int ! audioconvert ! queue ! vorbisenc ! mux. mux. ! shout2send ip=172.19.3.113 port=8000 password=password mount=webcam.ogg
```


## Network streaming

* Stream video using RTP and network elements.

On the server, issue
```
gst-launch  v4l2src  !  video/x-raw-yuv,width=128,height=96,format='(fourcc)'UYVY ! ffmpegcolorspace  !  ffenc_h263  !  video/x-h263  !  rtph263ppay pt=96 ! udpsink host=127.0.0.1 port=5000 sync=false
```

Use this command on the receiver:
```

gst-launch   udpsrc   port=5000   !   application/x-rtp,  clockrate=90000,payload=96 ! rtph263pdepay queue-delay=0 ! ffdec_h263 ! xvimagesink
```

* Following script will start the http server. It will start listing for requests for http streaming on your linux machine (IP-192.168.91.77) on 8080 port. It will not stream start sending packets on network until it gets a request from a client. Now to test this, open vlc player on any other machine and try capturing the network stream by typing http://192.168.91.77:8080. You should see webcam frames.

```
#!/bin/bash
/etc/init.d/httpd restart
vlc -vvv v4l:/dev/video0:norm=secam:frequency=543250:size=640x480:channel=0:adev=/dev/dsp:audio=0 --sout '#transcode{vcodec=mp4v,acodec=mpga,vb=3000,ab=256,vt=800000,keyint=80,deinterlace}:std{access=http,mux=ts,dst=192.168.91.77:8080}' --ttl 12
```
you can play around with the codecs and other options.

* After removing audio, the modified script:

```
#!/bin/bash
/etc/init.d/httpd restart
vlc -vvv v4l:/dev/video0:norm=secam:frequency=543250:size=640x480:channel=0 --sout '#transcode{vcodec=mp4v,vb=3000,vt=800000,keyint=80,deinterlace}:std{access=http,mux=ts,dst=192.168.91.77:8080}' --ttl 12
```
