# Initial Setup

  * Get required programs from your package manager of choice
    * `zsh`
    * `git-crypt`
    * `stow`
    * `gnupg`
  * Set up SSH keys and ssh client config manually
    * .ssh mode `0600`
    * .ssh/config mode `0644`, contents:
      ```
      Host github.com
        IdentityFile ~/.ssh/warden_personal_ed25519
        IdentityFile ~/.ssh/warden_personal_rsa
      ```
  * `gpg --import` public, then private keys
  * `git clone` this repo
  * Run `scripts/install.sh`

