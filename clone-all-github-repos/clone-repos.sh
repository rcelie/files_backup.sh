# Based on @erdinc-ay's stackoverflow answer - all thanks to him.
#
# Works for bash or Git Bash (on windows)
#
# Replace YOURUSERNAME with github username
#
# The maximum page-size is 100, so you have to call this several times with the right page number to get all your repositories (set # PAGE to the desired page number you want to download).


USER=YOURUSERNAME; PAGE=1

curl "https://api.github.com/users/$USER/repos?page=$PAGE&per_page=100" |
  grep -e 'git_url*' |
    cut -d \" -f 4 |
      xargs -L1 git clone
