---
layout: default
title: Faq
subtitle: Frequently Asked Questions
id: faq
icon: fa-question-circle
nav: true
position: 3
permalink: faq.html
description: Before consulting our community you can check what others have asked before.
---

## Is BlackArch the right pentesting distribution for me?

BlackArch is a Linux pentesting distribution based on Arch Linux. If you're not familiar with Arch Linux, or Linux in general, we strongly suggest you avoid BlackArch due to the learning curve for new users.

## Where do I start with BlackArch?

You must first get an ISO on the [downloads](download.html) page and install it by following the instructions of the installation script. You can find a tutorial to show the process step by step at this URL [Blackarch installation](blackarch-install.html). If you encounter any problems and need help, the best place to ask is in our FREENODE IRC channel (#blackarch).

## Is BlackArch up to date?

BlackArch is constantly being updated and offers the lastest packages available on Github. We release a new ISO four times a year (quarterly). These new images contain packages that are up to date, and usually include bug fixes. If you find any package that is outdated and wish to see it up to date, please report it as an issue on our [Github repository](https://github.com/BlackArch/blackarch).

## How can I fetch/install the lastest update available?

By simply running `pacman -Syyu --needed --force blackarch`. This command requires root privileges.
                            
## Why do I get invalid keyring signature?

It could happen for a wide range of reasons. Below you will find a __few suggestions__


* You don't have an internet connection (as you can imagine, a rare problem and can be verified quickly).
* You may have a DNS problem, that can't resolve pgp.mit.edu accordingly. Please check your DNS settings.
* You may have a network issue, different from the above one, which is hard for us to help since it can be a myriad of things. For example: DNS caching.
* You may have a clock/time issue.
* You may have something blocking your communication with mit.edu server, for instance: a firewall.
* If you're connected through a VPN, try to temporarily disable it and run `strap.sh` again.
* __pgp.mit.edu__ could be down for some reason (yes, that can happen). See options number 2 and 3 below for more information.

After testing all the items described above if you still have problems using <`strap.sh`, try the options below:
                            
### 1<sup>st</sup> option

```
rm -rf /etc/pacman.d/gnupg
pacman-key --populate
pacman-key --update
```

### 2<sup>nd</sup> option

You could try to change to pgp.mit.edu's IP address using the following command:

```
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sha1sum strap.sh 
# it should match with the information on https://blackarch.org/downloads.html
sed -i "s|pgp.mit.edu|18.9.60.141|g" strap.sh
sh strap.sh
```

Just keep in mind that the IP address above is the current IP address of pgp.mit.edu but it can change at any time. Make sure to check before running the command.


### 3<sup>rd</sup> option

If the option number 2 didn't solve your issue, try the following on a __new downloaded__ `strap.sh` file:

```
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh</span><br>
sha1sum strap.sh
# it should match with the information on https://blackarch.org/downloads.html
sed -i "s|pgp.mit.edu|hkp://pool.sks-keyservers.net|g" strap.sh
sh strap.sh
```

It's very important to follow the suggestions above as well as checking the Arch Linux Wiki pages to assist you as needed. If you still encounter any problems, pay us a visit at [#blackarch](irc://irc.freenode.net/blackarch) (freenode).
                            
## Where can I get help for a problem that I'm facing?

Depending on the problem you're facing, you can visit our Github and submit an issue on our Issue page, such as:

* [Site repository](https://github.com/BlackArch/blackarch-site/issues): related to our website. For example: If a link is broken or an image isn't loading.
* [Main repository](https://github.com/BlackArch/blackarch/issues): related to our packages. For example: a package hasn't been updated for a while or failed to run.
* [Installer repository](https://github.com/BlackArch/blackarch-installer): related to our installer. For example: the installation failed or you can not boot after a successful installation.

You can also take some time to browse our [other repositories](https://github.com/BlackArch).If you still cannot find a solution to your problem, visit our [IRC channel](irc://irc.freenode.net/blackarch) and ask for help. But please be advised, BlackArch users are in different parts of the globe (different time zones). Therefore, be patient. Ask your question and wait for a reply.
                            
                            
## I would like to help. What can I do?

BlackArch is a huge project, we are adding new applications and features everyday.
If you would like to help us with anything, visit our [IRC channel](irc://irc.freenode.net/blackarch). Just remember to wait for a reply, we are in different time zones.

