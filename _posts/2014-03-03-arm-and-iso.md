---
layout: post
title: ARM Support and New ISOs!
---

BlackArch now has ARM support. Currently, there are 570 packages in the armv6h repo and 580 packages in the armv7h repo. We are working to close the gap between the ARM repos and the x86_64 and i686 repos. Expect to see over 600 packages in each ARM repo within a week or two.



Soon, we will release ARM images for various devices including the Raspberry Pi and Pandaboard.


We also released new ISOs today. The new ISOs make the following changes :

* package: added zathura
* package: added lsof
* package: added pkgfile
* disabled pc speaker beep
* added initial /etc/motd with notes
* vim: removed alias of vi="vim"
* vim: disabled remap of ':'
* vim: set ttimeoutlen=100