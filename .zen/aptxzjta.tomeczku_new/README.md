# INSTRUCTION

`ln -sf` this chrome directory to the profile directory of zen browser in use. Contains theme autoreload code. Contains glue code to load local JS into runtime from:

[FX-AUTOCONFIG](https://github.com/MrOtherGuy/fx-autoconfig)

#### NOTE:

For protection throw in immutable bit on any JS so nothing can get modified:

```bash
sudo chattr +i -R ~/.zen/myprofile/chrome/utils/ &&
sudo chattr +i -R ~/.zen/myprofile/chrome/resources/ &&
sudo chattr +i -R ~/.zen/myprofile/chrome/JS/
```

Also contains a local copy of any css for a handful of installed zen mods. Just a couple dozens kb so no big deal.
