# dotfiles

## requirements
* arch-linux (preferable)
* yadm (availiable on AUR)
* git
* x11
* ssh
* kde and stuff (optional)

## usage

### backup
* Look at [this page](https://yadm.io/docs/encryption) for info. Only need to add filenames to `$HOME/.config/yadm/encrypt`.
* Run `sh ~/backup_dotfiles.sh` or `backup_dotfiles` if on working zsh build.

### restore
    yadm clone git@github.com:tusharpandey13/dotfiles.git
    yadm decrypt #(optional, requires password)

## Notes
While the files added are safe to my knowledge and don't contain any compromising information that is not encrypted, the user of this repo is advised to ignore and immediately report any secrets/vulnerabilities/compromising information found as an act of humanity and as their ethical responsibility.

Thank You.
