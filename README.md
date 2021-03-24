# dotfiles

1. Clone to home directory: `cd ~ && git clone git@github.com:f0t0n/dotfiles.git`

2. Execute setup bash script:`~/dotfiles/setup`

You're done.


# SSH keys ED25519

```
ssh-keygen -o -a 64 -t ed25519 -f ~/.ssh/id_ed25519 -C "user@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
