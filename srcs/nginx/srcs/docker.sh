[ -z "$SSH_USER" ] && SSH_USER=alesanto
[ -z "$SSH_PASSWORD" ] && SSH_PASSWORD=admin

adduser -D "$SSH_USER"
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd
echo "user:password = $SSH_USER:$SSH_PASSWORD"


nginx
/usr/bin/ssh-keygen -A
/usr/sbin/sshd
