#!/usr/bin/bash
set -o nounset -o errexit

FQDN=$(hostname -f)
REALM_NAME=$1
DIRMAN_PASSWORD=`cat ~/.dmcredentials`
KEY_LOCATION=/etc/ssl/$FQDN/letsencrypt/privkey.pem
CERT_LOCATION=/etc/ssl/$FQDN/letsencrypt/cert.perm

if true | openssl s_client -connect $FQDN:443 2>/dev/null | \
  openssl x509 -noout -checkend 172800; then
  echo "Certificate will be valid for more than 2 days!"
else
  echo "Certificate will expire within 2 days!"
  echo "Starting certinstall script..."

  # Try to install actual certificates
  ipa-server-certinstall -p $DIRMAN_PASSWORD -w -d $KEY_LOCATION $CERT_LOCATION --pin=''

  # Restart services to load new certificates
  systemctl restart httpd.service
  systemctl restart dirsrv@$REALM_NAME.service
fi
