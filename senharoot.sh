#!/bin/bash
# Seu esforço um dia vai lhe trazer resultados e vão até pensar que foi sorte.
# Oi seus lindos ta olhando oque aqui em?
# Fica avontade não tem segredo aqui não! beijos 😘 
# @FelpRJ21
clear
[[ "$(whoami)" != "root" ]] && {
	clear
	echo -e "\033[1;31me lá vamos nós, usuário root, \033[1;32m(\033[1;33msudo -i\033[1;32m)\033[0m"
	exit
}
[[ $(grep -c "prohibit-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "without-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PermitRootLogin" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication" /etc/ssh/sshd_config) = '0' ]] && {
	echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
service ssh restart > /dev/null
iptables -F
iptables -A INPUT -p tcp --dport 81 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8799 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT
clear && echo -ne "\033[1;32mDigite sua nova senha root bem difícil\033[1;37m: "; read senha
[[ -z "$senha" ]] && {
echo -e "\n\033[1;31mJá ta fazendo merda né burro, Tenta novamente..\033[0m"
exit 0
}
echo "root:$senha" | chpasswd
echo -e "\n\033[1;31m[ \033[1;33m@FelpRJ21 O FAVORITO DELAS!\033[1;31m]\033[1;37m - \033[1;32mParabéns já joga o script ssh \033[0m"
