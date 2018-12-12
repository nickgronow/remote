# What this is for

These simple scripts make it easy to setup some basic commands on remote linux servers.

## Setup

Simply run:

```
curl -o ~/.bash_profile -L https://github.com/nickgronow/remote/blob/master/scripts/remote/bash-profile.sh
. ~/.bash_profile
lp
rp
```

## Commands

* `lp` - Load profile - Pull the latest changes of this repo into the server
* `rp` - Reload profile
* `ep` - Edit profile
*
## Editor and mode

These scripts have bias towards the vim editor and vi mode.
