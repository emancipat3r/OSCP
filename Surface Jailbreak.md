---
created: 2022-06-06T11:26:06-04:00
modified: 2022-06-06T11:26:25-04:00
---

# Surface Jailbreak

Here is the Open Surface RT home, this is where I found their guides:

- https://openrt.gitbook.io/open-surfacert/

If you have Windows 8.1 and secureboot on, you have to find a way to turn that off, I used an all in one tool for installing Golden Keys + Yahallo w/o keyboard, I had to flash the tablet with a Windows 8.1 recovery from microsoft before it worked though.

Here's a link to that guide:

- https://jwa4.gitbook.io/windows/tools/surface-rt-and-surface-2-jailbreak-usb

Once I took down secure boot I ended up giving Raspbian a try thanks to their guide:

- https://openrt.gitbook.io/open-surfacert/surface-rt/linux/root-filesystem/distros/raspberry-pi-os

Then I decided to try Void and used pretty much the same instructions as Raspbian that I linked above but in Void you'd be left in the TTY without a GUI.

---

The quick and dirty version is download everything linked in step 1.

You need:

- prebuilt kernel
- device tree file (be sure you have the right one)
- the efi folder
- the nsh script (this has to be modified in order to specify the kernel filename and the right block device to boot from btw)

Assuming you have an USB with the Void rpi2/armv7 image flashed, you do the following:

Copy those 4 things into the /boot partition, it's the smaller partition, you will boot using that prebuilt kernel assuming you named the kernel zImage.

Download the kernel modules, extract them and go into the lib folder, copy the contents into the /usr/lib directory of the rootfs partition, you may need root for this.

Once you copied those 4 things into the boot partition and edited the nsh script appropriately, and put the kernel modules in the right place, you're ready to boot from the USB.

This is how I did it on the Surface RT, I don't know about other Surface tablets, haven't tried the musl variant.

I also copied a resolv.conf and wpa_supplicant.conf that I prepared in advance over to the rootfs, at some point I'll commit to a full install to the internal eMMC so I don't need a USB stick and can use that slot for the keyboard.

Best of luck! o7
