#!/bin/bash

mkdir -p ~/.ssh

echo "[*] Create '~/.ssh/config' SSH config file"

echo $(cat <<-EOF
Host github.com\n
  HostName github.com
  IdentityFile ~/.ssh/id_rsa_kiran
  IdentitiesOnly yes
EOF
) > ~/.ssh/config

echo "[*] Create '~/.ssh/id_rsa_kiran' RSA file"

echo "-----BEGIN OPENSSH PRIVATE KEY-----" > ~/.ssh/id_rsa_kiran
echo ${RSA_KIRAN}  | sed 's/ /\n/g' >> ~/.ssh/id_rsa_kiran
echo "-----END OPENSSH PRIVATE KEY-----" >> ~/.ssh/id_rsa_kiran

chmod 400 ~/.ssh/id_rsa_kiran

echo ${RSA_KIRAN}
echo "[*] Enable SSH Agent"
eval "$(ssh-agent -s)"  > /dev/null

echo "[*] Add RSA File to SSH"
ssh-add /home/circleci/.ssh/id_rsa_kiran