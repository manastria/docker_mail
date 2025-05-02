#!/usr/bin/env bash
set -euo pipefail

# Recopie les fichiers postfix depuis le volume monté dans un dossier sécurisé
echo "[init] Copie de /tmp/etc/postfix -> /etc/postfix"
rm -rf /etc/postfix/*
cp -r /tmp/etc/postfix/* /etc/postfix/

# Assure que tous les fichiers appartiennent à root et ne sont pas modifiables par d'autres
chown -R root:root /etc/postfix
chmod -R go-w /etc/postfix

# Vérifie dynamicmaps.cf
chmod 0644 /etc/postfix/dynamicmaps.cf

# Génère les maps
for map in vmailbox transport; do
  src="/etc/postfix/$map"
  [ -f "$src" ] && postmap "$src"
done

# Lancement des services (debug interactif possible)
postfix start-fg &
exec dovecot -F
