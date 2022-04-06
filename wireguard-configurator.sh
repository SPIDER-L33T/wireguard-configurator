#!/bin/bash
# =============================
# Name: WireGuard configurator
# Creator: SPIDER-L33T
# Created: 06.04.2022
# Lat update: 06.04.2022
# =============================

TLANG='ENG'
COLORRED='\033[0;31m'
COLORORANGE='\033[0;33m'
COLOREND='\033[0m'

SERVER_PUB_NIC=""
SERVER_WG_NIC=""
SERVER_WG_IPV4=""
SERVER_WG_IPV6=""
SERVER_PORT=""
CLIENT_DNS_1=""
CLIENT_DNS_2=""


ROOTNEED_ENG="You need to run this script as root"
ROOTNEED_RUS='Нужно запустить под пользователем root'

VIRTVZ_ENG="OpenVZ is not supported"
VIRTVZ_RUS="OpenVZ не поддерживается"
VIRTLX_ENG="LXC is not supported"
VIRTLX_RUS="LXC не поддерживается"

INSTOS_ENG="---=== This installer working only on a: Debian, Ubuntu, Fedora, CentOS, Oracle or Arch Linux ===---"
INSTOS_RUS="---=== Этот установщик работает только в операционках: Debian, Ubuntu, Fedora, CentOS, Oracle или Arch Linux ===---"

DEBVER_ENG="Current Debian version is not supported. Please use Debian 9 or later"
DEBVER_RUS="Текущая версия Debian не поддерживается. Используйте Debian 9 или старше"

MAINMENUTEXT_ENG="Welcome to WireGuard-configurator!\nThe git repository is available at: https://github.com/SPIDER-L33T/wireguard-configurator\n\n `echo ${COLORORANGE}` WireGuard is already installed! `echo ${COLOREND}` \n\nWhat do you want to do?\n   1) Add a new user\n   2) Delete existing user\n   3) View QR existing user\n   4) Rename existing user\n   5) Uninstall WireGuard\n   6) Exit\n"
MAINMENUTEXT_RUS="Вас приветствует WireGuard-configurator!\nРепозитарий git тут: https://github.com/SPIDER-L33T/wireguard-configurator\n\n `echo ${COLORORANGE}` WireGuard Уже установлен! `echo ${COLOREND}` \n\nЧего теперь хотите сделать?\n   1) Добавить пользователя\n   2) Удалить пользователя\n   3) Показать QR пользователя\n   4) Переименовать пользователя\n   5) Удалить WireGuard\n   6) Выйти\n"

MAINMENUSELTEXT_ENG="Select an option"
MAINMENUSELTEXT_RUS="Выберите одно из"

SURVEYMAINTEXT_ENG="Welcome to WireGuard-configurator!\nThe git repository is available at: https://github.com/SPIDER-L33T/wireguard-configurator\n\n I need to ask you a few questions before starting the setup.\n\nYou can leave the default options and just press `echo ${COLORORANGE}` ENTER `echo ${COLOREND}` if you are ok with them.\n\n"
SURVEYMAINTEXT_RUS="Вас приветствует WireGuard-configurator!\nРепозитарий git тут: https://github.com/SPIDER-L33T/wireguard-configurator\n\n Перед тем как начать установку мне нужно задать несколько уточняющих вопросов.\n\nЕсли Вы не знаете как ответить или предлагаемые мной настройки подходят - просто нажимайте `echo ${COLORORANGE}` ENTER `echo ${COLOREND}`.\n\n"

SURVPUBIP_ENG="IPv4 or IPv6 public address"
SURVPUBIP_RUS="Публичный IPv4 или IPv6 адрес"

SURVPUBINT_ENG="Public interface"
SURVPUBINT_RUS="Публичный интерфейс"

SURVWGINT_ENG="WireGuard interface name"
SURVWGINT_RUS="Имя интерфейса WireGuard"

SURVWGIP4_ENG="Inside server's WireGuard IPv4 address"
SURVWGIP4_RUS="Внутренний IPv4 адрес сервера WireGuard"

SURVWGIP6_ENG="Inside server's WireGuard IPv6 address"
SURVWGIP6_RUS="Внутренний IPv6 адрес сервера WireGuard"

SURVWGPORT_ENG="Server's WireGuard port"
SURVWGPORT_RUS="Порт для сервера WireGuard"

SURVDNS1_ENG="First DNS resolver to use for the clients (With blocker for ads, counters and phishing sites)"
SURVDNS1_RUS="Первый DNS сервер для клиентов (с блокировщиком рекламы, счетчиков и фишинговых сайтов)"

SURVDNS2_ENG="Second DNS resolver to use for the clients (With blocker for ads, counters and phishing sites) (optional)"
SURVDNS2_RUS="Второй DNS сервер для клиентов (с блокировщиком рекламы, счетчиков и фишинговых сайтов) (не обязательно)"

SURVENDTEXT_ENG="\nOkay, that was all I needed. We are ready to setup your WireGuard server now.\nYou will be able to generate a client at the end of the installation.\n\n"
SURVENDTEXT_RUS="\nОтлично! Все что надо получено. Мы готовы начать установку WireGuard на сервер прямо сейчас.\nВ конце установки Вы сможете создать клиента.\n\n"

PRESSANYKEY_ENG="Press any key to continue..."
PRESSANYKEY_RUS="Для продолжения нажмите любую клавишу..."

IFNEEDMORECL_ENG="If you want to add more clients, you simply need to run this script another time!"
IFNEEDMORECL_RUS="Если Вам нужно добавить еще клиентов, то просто запустите этот скрипт еще раз!"

WGRUNNINGTEXT_ENG="\n`echo ${COLORRED}`WARNING: WireGuard does not seem to be running.`echo ${COLOREND}` \n `echo ${COLORORANGE}`You can check if WireGuard is running with: systemctl status wg-quick@`echo ${SERVER_WG_NIC}${COLOREND}` \n`echo ${COLORORANGE}`If you get something like \"Cannot find device `echo ${SERVER_WG_NIC}`\", please reboot!`echo ${COLOREND}`"
WGRUNNINGTEXT_RUS="\n`echo ${COLORRED}`WARNING: WireGuard does not seem to be running.`echo ${COLOREND}` \n `echo ${COLORORANGE}`You can check if WireGuard is running with: systemctl status wg-quick@`echo ${SERVER_WG_NIC}${COLOREND}` \n`echo ${COLORORANGE}`If you get something like \"Cannot find device `echo ${SERVER_WG_NIC}`\", please reboot!`echo ${COLOREND}`"

NEWCLSTART_ENG="Tell me a name for the client.\nThe name must consist of alphanumeric character.\nIt may also include an underscore or a dash and can't exceed 15 chars.\n\n"
NEWCLSTART_RUS="Укажите имя нового клиента.\nИмя должно содержать только латинские буквы и цифры.\nТак же может содержать тире или подчеркивание, но не может содержать другие символы и не может превышать 15 символов.\n\n"

NEWCLNAME_ENG="Client name"
NEWCLNAME_RUS="Имя клиента"

NEWCLEXIST_ENG="\nA client with the specified name was already created, please choose another name.\n"
NEWCLEXIST_RUS="\nКлиент с таким именем уже существует. Укажите другое имя.\n"

NEWCLMAXIP_ENG="\nThe subnet configured supports only 253 clients.\n"
NEWCLMAXIP_RUS="\nТекущая сеть поддерживает только 253 клиента.\n"

NEWCLQR_ENG="\nHere is your client config file as a QR Code:\n"
NEWCLQR_RUS="\nКонфигурация Вашего клиента как QR-код:\n"

NEWCLCFG_ENG="It is also available in "
NEWCLCFG_RUS="Так же конфигурация доступна по адресу: "

NEWCLIPV4EXT_ENG="\nA client with the specified IPv4 was already created, please choose another IPv4.\n"
NEWCLIPV4EXT_RUS="\nКлиент с таким IPv4 адресом уже существуеи, укажите другой IPv4 адрес.\n"

NEWCLIPV6EXT_ENG="\nA client with the specified IPv6 was already created, please choose another IPv4.\n"
NEWCLIPV6EXT_RUS="\nКлиент с таким IPv6 адресом уже существуеи, укажите другой IPv6 адрес.\n"

DELUSERNO_ENG="\nYou have no existing clients!"
DELUSERNO_RUS="\nУ Вас нет ни одного клиента!"

DELUSERSEL_ENG="\nSelect the existing client you want to delete"
DELUSERSEL_RUS="\nВыберите клиента, которого нужно удалить"

DELUSERMENU_ENG='     m) Main menu\n'
DELUSERMENU_RUS='     m) Главное меню\n'

SELCL_ENG="Select one client"
SELCL_RUS="Выберите клиента из списка"

QRUSERSEL_ENG="\nSelect the existing client you want to display QR"
QRUSERSEL_RUS="\nВыберите клиента, конфиг которого нужно показать как QR"

RENAMECL_ENG="Enter new name for client"
RENAMECL_RUS="Введите новое имя для клиента"

RENAMECLCHAR_ENG="\nWe remind you that the name must consist of alphanumeric character.\nIt may also include an underscore or a dash and can't exceed 15 chars.\n\n"
RENAMECLCHAR_RUS="\nНапоминаем, что имя должно содержать только латинские буквы и цифры.\nТак же может содержать тире или подчеркивание, но не может содержать другие символы и не может превышать 15 символов.\n\n"

REMWG_ENG="Do you really want to remove WireGuard?"
REMWG_RUS="Вы действительно хотите удалить WireGuard?"

REMWGFAIL_ENG="\nWireGuard failed to uninstall properly.\n"
REMWGFAIL_RUS="\nWireGuard не смог удалиться.\n"

REMWGOK_ENG="\nWireGuard uninstalled successfully.\n"
REMWGOK_RUS="\nWireGuard успешно удалился.\n"	

REMWGCAN_ENG="\nRemoval aborted!\n"
REMWGCAN_RUS="\nУдаление прервано!\n"

function viewLangMenu() {
    MENULANG_OPT=""
	echo "======================================="
	echo "Select language (Digit from the list)"
	echo "Выберите язык (цифру из списка)"
	echo ""
	echo "   1) English"
	echo "   2) Русский"
	echo "   3) Exit (Выход)"
	echo ""
	until [[ ${MENULANG_OPT} =~ ^[1-3]$ ]]; do		
		read -rp "Select an option [1-3]: " MENULANG_OPT
	done
	case "${MENULANG_OPT}" in
	1)
    	echo ""
    	eval echo -e "$`echo COLORORANGE` ---=== English selected ===--- $`echo COLOREND`"
    	echo ""
		TLANG="ENG"
		;;
	2)
    	echo ""
    	eval echo -e "$`echo COLORORANGE` ---=== Выбран русский язык ===--- $`echo COLOREND`"
    	echo ""
		TLANG="RUS"
		;;
	3)
		echo "Item 3"
        exit 0
		;;
	esac
}

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
        eval echo -e "$`echo ROOTNEED"_"$TLANG`"		
		exit 1
	fi
}

function checkVirt() {
	if [ "$(systemd-detect-virt)" == "openvz" ]; then
		eval echo "$`echo VIRTVZ"_"$TLANG`"
		echo ""
		exit 1
	fi

	if [ "$(systemd-detect-virt)" == "lxc" ]; then
		eval echo "$`echo VIRTLX"_"$TLANG`"
		echo ""
		exit 1
	fi
}

function checkOS() {
	if [[ -e /etc/debian_version ]]; then
		source /etc/os-release
		OS="${ID}" # debian or ubuntu
		if [[ ${ID} == "debian" || ${ID} == "raspbian" ]]; then
			if [[ ${VERSION_ID} -lt 8 ]]; then				
				eval echo "$`echo DEBVER"_"$TLANG`"
				echo ""
				exit 1
			fi			
			OS=debian
		fi
	elif [[ -e /etc/fedora-release ]]; then
		source /etc/os-release
		OS="${ID}"
	elif [[ -e /etc/centos-release ]]; then
		source /etc/os-release
		OS=centos
	elif [[ -e /etc/oracle-release ]]; then
		source /etc/os-release
		OS=oracle
	elif [[ -e /etc/arch-release ]]; then
		OS=arch
	else	
	    eval echo "$`echo INSTOS"_"$TLANG`"
		echo ""
		exit 1
	fi
}

function newClient() {
	ENDPOINT="${SERVER_PUB_IP}:${SERVER_PORT}"
	eval echo -e "$`echo NEWCLSTART"_"$TLANG`"

	until [[ ${CLIENT_NAME} =~ ^[a-zA-Z0-9_-]+$ && ${CLIENT_EXISTS} == '0' && ${#CLIENT_NAME} -lt 16 ]]; do		
		read -rp "`eval echo $\`echo NEWCLNAME_$TLANG\``: " -e CLIENT_NAME
		CLIENT_EXISTS=$(grep -c -E "^### Client ${CLIENT_NAME}\$" "/etc/wireguard/${SERVER_WG_NIC}.conf")

		if [[ ${CLIENT_EXISTS} == '1' ]]; then			
			eval echo -e "$`echo NEWCLEXIST"_"$TLANG`"
		fi
	done

	for DOT_IP in {2..254}; do
		DOT_EXISTS=$(grep -c "${SERVER_WG_IPV4::-1}${DOT_IP}" "/etc/wireguard/${SERVER_WG_NIC}.conf")
		if [[ ${DOT_EXISTS} == '0' ]]; then
			break
		fi
	done

	if [[ ${DOT_EXISTS} == '1' ]]; then		
		eval echo -e "$`echo NEWCLMAXIP"_"$TLANG`"		
		exit 1
	fi

	BASE_IP=$(echo "$SERVER_WG_IPV4" | awk -F '.' '{ print $1"."$2"."$3 }')
	until [[ ${IPV4_EXISTS} == '0' ]]; do		
		CLIENT_WG_IPV4="${BASE_IP}.${DOT_IP}"
		IPV4_EXISTS=$(grep -c "$CLIENT_WG_IPV4/24" "/etc/wireguard/${SERVER_WG_NIC}.conf")

		if [[ ${IPV4_EXISTS} == '1' ]]; then			
			eval echo -e "$`echo NEWCLIPV4EXT"_"$TLANG`"			
		fi
	done

	BASE_IP=$(echo "$SERVER_WG_IPV6" | awk -F '::' '{ print $1 }')
	until [[ ${IPV6_EXISTS} == '0' ]]; do
		
		CLIENT_WG_IPV6="${BASE_IP}::${DOT_IP}"
		IPV6_EXISTS=$(grep -c "${CLIENT_WG_IPV6}/64" "/etc/wireguard/${SERVER_WG_NIC}.conf")

		if [[ ${IPV6_EXISTS} == '1' ]]; then		
			eval echo -e "$`echo NEWCLIPV6EXT"_"$TLANG`"		
		fi
	done

	CLIENT_PRIV_KEY=$(wg genkey)
	CLIENT_PUB_KEY=$(echo "${CLIENT_PRIV_KEY}" | wg pubkey)
	CLIENT_PRE_SHARED_KEY=$(wg genpsk)
	
	echo "[Interface]
PrivateKey = ${CLIENT_PRIV_KEY}
Address = ${CLIENT_WG_IPV4}/32,${CLIENT_WG_IPV6}/128
DNS = ${CLIENT_DNS_1},${CLIENT_DNS_2}

[Peer]
PublicKey = ${SERVER_PUB_KEY}
PresharedKey = ${CLIENT_PRE_SHARED_KEY}
Endpoint = ${ENDPOINT}
AllowedIPs = 0.0.0.0/0,::/0" >> "/etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

	echo -e "### Client ${CLIENT_NAME}
[Peer]
PublicKey = ${CLIENT_PUB_KEY}
PresharedKey = ${CLIENT_PRE_SHARED_KEY}
AllowedIPs = ${CLIENT_WG_IPV4}/32,${CLIENT_WG_IPV6}/128
#===" >> /etc/wireguard/${SERVER_WG_NIC}.conf

	wg syncconf "${SERVER_WG_NIC}" <(wg-quick strip "${SERVER_WG_NIC}")
	
	eval echo -e "$`echo NEWCLQR"_"$TLANG`"

	qrencode -t ansiutf8 -l L <"/etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

	eval echo -e "$`echo NEWCLCFG"_"$TLANG` /etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

}

function deleteClient() {
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then		
		eval echo -e "$`echo DELUSERNO"_"$TLANG`"
		exit 1
	fi

	eval echo -e "$`echo DELUSERSEL"_"$TLANG`"
	
	grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | nl -s ') '
	echo -e "\t---------\n"
	echo '     '"`eval echo -e $\`echo DELUSERMENU_$TLANG\``"

	if [[ ${NUMBER_OF_CLIENTS} == '1' ]];then			
			read -rp "`eval echo $\`echo SELCL_$TLANG\`` [1]: " CLIENT_NUMBER
		else
			read -rp "`eval echo $\`echo SELCL_$TLANG\`` [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi

	if [[ ${CLIENT_NUMBER} -eq 'm' ]];then
		mainMenu
		exit 1
	fi

	CLIENT_NAME=$(grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

	sed -i "/^### Client ${CLIENT_NAME}\$/,/\#===/d" "/etc/wireguard/${SERVER_WG_NIC}.conf"

	rm -f "/etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf"

	wg syncconf "${SERVER_WG_NIC}" <(wg-quick strip "${SERVER_WG_NIC}")

	deleteClient
	exit 1
}

function displayQR() {
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then		
		eval echo -e "$`echo DELUSERNO"_"$TLANG`"
		exit 1
	fi
	eval echo -e "$`echo QRUSERSEL"_"$TLANG`"
	grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | nl -s ') '
	echo -e "\t---------\n"
	echo '     '"`eval echo -e $\`echo DELUSERMENU_$TLANG\``"
	if [[ ${NUMBER_OF_CLIENTS} == '1' ]];then			
			read -rp "`eval echo $\`echo SELCL_$TLANG\`` [1]: " CLIENT_NUMBER
		else
			read -rp "`eval echo $\`echo SELCL_$TLANG\`` [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
	if [[ ${CLIENT_NUMBER} -eq 'm' ]];then
		mainMenu
		exit 1
	fi
	CLIENT_NAME=$(grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
    echo "Displaying QR code"
    qrencode -t ansiutf8 < /etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf
	exit 1	
}

function renameClient() {
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then		
		eval echo -e "$`echo DELUSERNO"_"$TLANG`"
		exit 1
	fi

	grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | nl -s ') '
	echo -e "\t---------\n"
	echo '     '"`eval echo -e $\`echo DELUSERMENU_$TLANG\``"
	if [[ ${NUMBER_OF_CLIENTS} == '1' ]];then			
			read -rp "`eval echo $\`echo SELCL_$TLANG\`` [1]: " CLIENT_NUMBER
		else
			read -rp "`eval echo $\`echo SELCL_$TLANG\`` [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
	if [[ ${CLIENT_NUMBER} -eq 'm' ]];then
		mainMenu
		exit 1
	fi
	CLIENT_NAME=$(grep -E "^### Client" "/etc/wireguard/${SERVER_WG_NIC}.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
	
	eval echo -e "$`echo RENAMECLCHAR"_"$TLANG`"

	read -rp "`eval echo $\`echo RENAMECL_$TLANG $CLIENT_NAME\``: " CLIENT_NEWNAME
	sed -i "/### Client ${CLIENT_NAME}\$/c### Client ${CLIENT_NEWNAME}" "/etc/wireguard/${SERVER_WG_NIC}.conf"
	mv "/etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NAME}.conf" "/etc/wireguard/clients/${SERVER_WG_NIC}-client-${CLIENT_NEWNAME}.conf"
}

function uninstallWg() {
	read -rp "`eval echo $\`echo REMWG_$TLANG\`` [y/n]: " -e -i n REMOVE
	if [[ $REMOVE == 'y' ]]; then
		checkOS

		systemctl stop "wg-quick@${SERVER_WG_NIC}"
		systemctl disable "wg-quick@${SERVER_WG_NIC}"

		if [[ ${OS} == 'ubuntu' ]]; then
			apt-get autoremove --purge -y wireguard qrencode
		elif [[ ${OS} == 'debian' ]]; then
			apt-get autoremove --purge -y wireguard qrencode
		elif [[ ${OS} == 'fedora' ]]; then
			dnf remove -y wireguard-tools qrencode
			if [[ ${VERSION_ID} -lt 32 ]]; then
				dnf remove -y wireguard-dkms
				dnf copr disable -y jdoss/wireguard
			fi
			dnf autoremove -y
		elif [[ ${OS} == 'centos' ]]; then
			yum -y remove kmod-wireguard wireguard-tools qrencode
			yum -y autoremove
		elif [[ ${OS} == 'oracle' ]]; then
			yum -y remove wireguard-tools qrencode
			yum -y autoremove
		elif [[ ${OS} == 'arch' ]]; then
			pacman -Rs --noconfirm wireguard-tools qrencode
		fi

		rm -rf /etc/wireguard
		rm -f /etc/sysctl.d/wg.conf

		sysctl --system

		systemctl is-active --quiet "wg-quick@${SERVER_WG_NIC}"
		WG_RUNNING=$?

		if [[ ${WG_RUNNING} -eq 0 ]]; then
			eval echo -e "$`echo REMWGFAIL"_"$TLANG`"
			exit 1
		else
			eval echo -e "$`echo REMWGOK"_"$TLANG`"
			exit 0
		fi
	else
		eval echo -e "$`echo REMWGCAN"_"$TLANG`"
	fi
}

function mainMenu() {
    MAINMENU_OPT=""	
	eval echo -e "$`echo MAINMENUTEXT"_"$TLANG`"
	
	until [[ ${MAINMENU_OPT} =~ ^[1-6]$ ]]; do
		read -rp "`eval echo $\`echo MAINMENUSELTEXT_$TLANG\`` [1-6]: " MAINMENU_OPT
	done
	case "${MAINMENU_OPT}" in
	1)
		newClient
		;;
	2)
		deleteClient
		;;
	3)
	    displayQR
	    ;;
	4)
	    renameClient
	    ;;
	5)
		uninstallWg
		;;
	6)
		exit 0
		;;
	esac
}

function adminSurvey() {	
	eval echo -e "$`echo SURVEYMAINTEXT"_"$TLANG`"
		
	SERVER_PUB_IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1)
	if [[ -z ${SERVER_PUB_IP} ]]; then
		SERVER_PUB_IP=$(ip -6 addr | sed -ne 's|^.* inet6 \([^/]*\)/.* scope global.*$|\1|p' | head -1)
	fi	
	read -rp "`eval echo $\`echo SURVPUBIP_$TLANG\``: " -e -i "${SERVER_PUB_IP}" SERVER_PUB_IP
	
	SERVER_NIC="$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)"
	until [[ ${SERVER_PUB_NIC} =~ ^[a-zA-Z0-9_]+$ ]]; do		
		read -rp "`eval echo $\`echo SURVPUBINT_$TLANG\``: " -e -i "${SERVER_NIC}" SERVER_PUB_NIC		
	done

	until [[ ${SERVER_WG_NIC} =~ ^[a-zA-Z0-9_]+$ && ${#SERVER_WG_NIC} -lt 16 ]]; do		
		read -rp "`eval echo $\`echo SURVWGINT_$TLANG\``: " -e -i wg0 SERVER_WG_NIC
	done

	until [[ ${SERVER_WG_IPV4} =~ ^([0-9]{1,3}\.){3} ]]; do		
		read -rp "`eval echo $\`echo SURVWGIP4_$TLANG\``: " -e -i 10.6.0.1 SERVER_WG_IPV4
	done

	until [[ ${SERVER_WG_IPV6} =~ ^([a-f0-9]{1,4}:){3,4}: ]]; do		
		read -rp "`eval echo $\`echo SURVWGIP6_$TLANG\``: " -e -i fd42:42:42::1 SERVER_WG_IPV6
	done

	RANDOM_PORT=$(shuf -i49152-65535 -n1)
	until [[ ${SERVER_PORT} =~ ^[0-9]+$ ]] && [ "${SERVER_PORT}" -ge 1 ] && [ "${SERVER_PORT}" -le 65535 ]; do		
		read -rp "`eval echo $\`echo SURVWGPORT_$TLANG\`` [1-65535]: " -e -i "${RANDOM_PORT}" SERVER_PORT
	done

	until [[ ${CLIENT_DNS_1} =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; do		
		read -rp "`eval echo $\`echo SURVDNS1_$TLANG\``: " -e -i 94.140.14.14 CLIENT_DNS_1
	done
	until [[ ${CLIENT_DNS_2} =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; do
		read -rp "`eval echo $\`echo SURVDNS2_$TLANG\``: " -e -i 94.140.15.15 CLIENT_DNS_2
		if [[ ${CLIENT_DNS_2} == "" ]]; then
			CLIENT_DNS_2="${CLIENT_DNS_1}"
		fi
	done

	eval echo -e "$`echo SURVENDTEXT"_"$TLANG`"
	read -n1 -r -p "`eval echo $\`echo PRESSANYKEY_$TLANG\``"
}

function installWG() {
	adminSurvey

	if [[ ${OS} == 'ubuntu' ]] || [[ ${OS} == 'debian' && ${VERSION_ID} -gt 10 ]]; then
		apt-get update
		apt-get install -y wireguard iptables resolvconf qrencode
	elif [[ ${OS} == 'debian' ]]; then
	    if [[ ${VERSION_ID} -eq 9 ]];then
	        echo "Debian 9!"
			echo "deb http://deb.debian.org/debian/ unstable main" | tee /etc/apt/sources.list.d/unstable-wireguard.list
			echo -e "Package: *\nPin: release a=unstable\nPin-Priority: 150\n" | tee /etc/apt/preferences.d/limit-unstable
	    fi
		if [[ ${VERSION_ID} -eq 10 ]];then
			if ! grep -rqs "^deb .* buster-backports" /etc/apt/; then
				echo "deb http://deb.debian.org/debian buster-backports main" >/etc/apt/sources.list.d/backports.list
			fi
		fi
		
		apt update
		apt install -y iptables resolvconf qrencode
		apt install -y wireguard wireguard-tools wireguard-dkms wireguard-dkms linux-headers-$(uname -r)
		modprobe wireguard
	elif [[ ${OS} == 'fedora' ]]; then
		if [[ ${VERSION_ID} -lt 32 ]]; then
			dnf install -y dnf-plugins-core
			dnf copr enable -y jdoss/wireguard
			dnf install -y wireguard-dkms
		fi
		dnf install -y wireguard-tools iptables qrencode
	elif [[ ${OS} == 'centos' ]]; then
		yum -y install epel-release elrepo-release
		if [[ ${VERSION_ID} -eq 7 ]]; then
			yum -y install yum-plugin-elrepo
		fi
		yum -y install kmod-wireguard wireguard-tools iptables qrencode
	elif [[ ${OS} == 'oracle' ]]; then
		dnf install -y oraclelinux-developer-release-el8
		dnf config-manager --disable -y ol8_developer
		dnf config-manager --enable -y ol8_developer_UEKR6
		dnf config-manager --save -y --setopt=ol8_developer_UEKR6.includepkgs='wireguard-tools*'
		dnf install -y wireguard-tools qrencode iptables
	elif [[ ${OS} == 'arch' ]]; then
		pacman -S --needed --noconfirm wireguard-tools qrencode
	fi

	mkdir /etc/wireguard >/dev/null 2>&1
	mkdir /etc/wireguard/clients >/dev/null 2>&1

	chmod 600 -R /etc/wireguard/

	SERVER_PRIV_KEY=$(wg genkey)
	SERVER_PUB_KEY=$(echo "${SERVER_PRIV_KEY}" | wg pubkey)

	# Save WireGuard settings
	echo "SERVER_PUB_IP=${SERVER_PUB_IP}
SERVER_PUB_NIC=${SERVER_PUB_NIC}
SERVER_WG_NIC=${SERVER_WG_NIC}
SERVER_WG_IPV4=${SERVER_WG_IPV4}
SERVER_WG_IPV6=${SERVER_WG_IPV6}
SERVER_PORT=${SERVER_PORT}
SERVER_PRIV_KEY=${SERVER_PRIV_KEY}
SERVER_PUB_KEY=${SERVER_PUB_KEY}
CLIENT_DNS_1=${CLIENT_DNS_1}
CLIENT_DNS_2=${CLIENT_DNS_2}" > /etc/wireguard/params

	# Add server interface
	echo "[Interface]
Address = ${SERVER_WG_IPV4}/24,${SERVER_WG_IPV6}/64
ListenPort = ${SERVER_PORT}
PrivateKey = ${SERVER_PRIV_KEY}" >"/etc/wireguard/${SERVER_WG_NIC}.conf"

	if pgrep firewalld; then
		FIREWALLD_IPV4_ADDRESS=$(echo "${SERVER_WG_IPV4}" | cut -d"." -f1-3)".0"
		FIREWALLD_IPV6_ADDRESS=$(echo "${SERVER_WG_IPV6}" | sed 's/:[^:]*$/:0/')
		echo "PostUp = firewall-cmd --add-port ${SERVER_PORT}/udp && firewall-cmd --add-rich-rule='rule family=ipv4 source address=${FIREWALLD_IPV4_ADDRESS}/24 masquerade' && firewall-cmd --add-rich-rule='rule family=ipv6 source address=${FIREWALLD_IPV6_ADDRESS}/24 masquerade'
PostDown = firewall-cmd --remove-port ${SERVER_PORT}/udp && firewall-cmd --remove-rich-rule='rule family=ipv4 source address=${FIREWALLD_IPV4_ADDRESS}/24 masquerade' && firewall-cmd --remove-rich-rule='rule family=ipv6 source address=${FIREWALLD_IPV6_ADDRESS}/24 masquerade'" >>"/etc/wireguard/${SERVER_WG_NIC}.conf"
	else
		echo "PostUp = iptables -A FORWARD -i ${SERVER_PUB_NIC} -o ${SERVER_WG_NIC} -j ACCEPT; iptables -A FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; iptables -t nat -A POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE; ip6tables -A FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE
PostDown = iptables -D FORWARD -i ${SERVER_PUB_NIC} -o ${SERVER_WG_NIC} -j ACCEPT; iptables -D FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; iptables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE; ip6tables -D FORWARD -i ${SERVER_WG_NIC} -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE" >>"/etc/wireguard/${SERVER_WG_NIC}.conf"
	fi

	echo "net.ipv4.ip_forward = 1
net.ipv6.conf.all.forwarding = 1" > /etc/sysctl.d/wg.conf

	sysctl --system

	systemctl start "wg-quick@${SERVER_WG_NIC}"
	systemctl enable "wg-quick@${SERVER_WG_NIC}"

	newClient

	eval echo -e "$`echo IFNEEDMORECL"_"$TLANG`"	
	
	systemctl is-active --quiet "wg-quick@${SERVER_WG_NIC}"
	WG_RUNNING=$?

	if [[ ${WG_RUNNING} -ne 0 ]]; then
		eval echo -e "$`echo WGRUNNINGTEXT"_"$TLANG`"		
	fi
}

# =================================================
# Main 
viewLangMenu
isRoot
checkVirt
checkOS
if [[ -e /etc/wireguard/params ]]; then
	source /etc/wireguard/params
	mainMenu
else
	installWG
fi
