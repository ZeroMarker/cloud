sudo systemctl restart ssh

sshd -T | grep passwordauthentication

sudo nano /etc/ssh/sshd_config.d/99-password.conf

grep -r "PasswordAuthentication" /etc/ssh/
