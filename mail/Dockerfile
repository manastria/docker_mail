# mail/Dockerfile
FROM alpine:3.19

# -------------------------------------------------------------------
# 1. Paquets (tini = init léger, bash pour le confort en debug)
# -------------------------------------------------------------------
RUN apk add --no-cache \
        postfix dovecot dovecot-lmtpd \
        tini bash tzdata ca-certificates

# -------------------------------------------------------------------
# 2. Utilisateur et arborescence des boîtes
# -------------------------------------------------------------------
# Vérifie ou crée le dossier pour les mails et donne les droits à vmail
RUN mkdir -p /var/mail && chown -R vmail:postdrop /var/mail


# -------------------------------------------------------------------
# 3. Postfix : log → stdout, service au premier plan
# -------------------------------------------------------------------
# RUN postconf -e "maillog_file=/dev/stdout" && \
#     postconf -e "smtpd_banner=Test-Postfix \$myhostname"

# -------------------------------------------------------------------
# 4. Configuration “par défaut”
#    ► elle sera écrasée si tu montes un volume
# -------------------------------------------------------------------
COPY postfix/postfix  /etc/postfix/
COPY dovecot/dovecot  /etc/dovecot/

# -------------------------------------------------------------------
# 5. Script d’entrée
# -------------------------------------------------------------------
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/sbin/tini","--","docker-entrypoint.sh"]
EXPOSE 25 143
