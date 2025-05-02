docker compose exec mail /usr/local/bin/add-mailuser.sh bob password123

docker compose down -v && docker compose up -d --build

docker compose exec mail tail -f /var/log/dovecot.log



docker compose exec mail sh


echo "Subject: test mail" | sendmail bob@labo.tld
tail /var/log/mail.log

