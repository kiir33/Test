#!/bin/bash

mkdir -p ~/.ssh

echo "[*] Create '~/.ssh/config' SSH config file"

echo $(
  cat <<-EOF
Host github.com\n
  HostName github.com\n
  IdentityFile ~/.ssh/id_rsa_kiran\n
  IdentitiesOnly yes\n
EOF
) >~/.ssh/config

echo "[*] Create '~/.ssh/id_rsa_kiran' RSA file"

echo "-----BEGIN OPENSSH PRIVATE KEY-----" >~/.ssh/id_rsa_kiran
echo ${RSA_KIRAN} | sed 's/ /\n/g' >>~/.ssh/id_rsa_kiran
echo "-----END OPENSSH PRIVATE KEY-----" >>~/.ssh/id_rsa_kiran

chmod 400 ~/.ssh/id_rsa_kiran

echo "[*] Enable SSH Agent"
eval "$(ssh-agent -s)" >/dev/null

echo "[*] Add RSA File to SSH"
ssh-add ~/.ssh/id_rsa_kiran

git config user.name 'GitHub CI'
git config user.email 'kiranbanmala3@gmail.com'
git remote set-url origin git@github.com:kiir33/Test.git
