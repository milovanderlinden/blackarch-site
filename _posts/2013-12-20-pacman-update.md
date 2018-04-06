---
layout: post
title: Updates to Pacman.conf!
---

We changed the directory structure of the repository. Please modify your pacman.conf files like so:

```
[blackarch]
Server = http://blackarch.org/blackarch/$repo/os/$arch
```

The repository directory structure now resembles that of the official Arch Linux repositories. The new structure will make it easier for mirrors to sync with our repository.