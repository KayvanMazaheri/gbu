# GBU (Git Backup)
Backup Git Repositories on Local Machine

## Install

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/KayvanMazaheri/gbu/master/install.sh)"
```

## Why?
> Your data is valuable. It will cost you time and effort re-create it, and that costs money or at least personal grief and tears.
>
> -- <cite>Linux System Administrators Guide, Chapter 12. [Backups][1]</cite>



## How does it work?
_GBU_ uses `git bundle` under the hood to backup a git repository into a single file.  
It finds all git respositories in the current directory, creates backups and saves them into new directory prefixed with `gbu` (e.g. `gbu.2017-08-29T10:38:34`).

## Usage

Backup all git repositories in the current directory with a single command

```bash
gbu
```


[1]:http://www.tldp.org/LDP/sag/html/backups.html
