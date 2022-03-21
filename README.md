*Modified script for personal use!*

# Description

This script tries to automatically obtain and install Let's Encrypt certs to FreeIPA web interface.

# Installation

Run once:

```bash
git clone https://github.com/jnk22/freeipa-letsencrypt
cd freeipa-letsencrypt
./setup-le.sh
```

After successfully installing Let's Encrypt root certificates, update variable `REALM_NAME` in `renew-le.sh` and create a daily cronjob for it.
