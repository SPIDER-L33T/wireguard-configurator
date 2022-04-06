# wireguard-configurator
Interactive Wireguard configuration tool for server and clients
## RUS
### Описание
Интерактивный инструмент развертывания и обслуживания VPN-сервера для индивидуального использования на базе WireGuard.

Не требует навыков администрирования Linux-систем.


Что умеет:
- Работает на русском и английском языках (выбирается при запуске)
- Установить и удалить VPN-сервер
- Добавлять клиентов
- Удалять клиентов
- Переименовывать клиентов
- Показывать конфигурацию клиента в виде QR-кода

### Установка и использование

Авторизовавшись как пользователь root, выполните команду:
```bash
wget -O wireguard-configurator.sh "https://raw.githubusercontent.com/SPIDER-L33T/wireguard-configurator/main/wireguard-configurator.sh" && chmod +x wireguard-configurator.sh && ./wireguard-configurator.sh
```
![image](https://user-images.githubusercontent.com/8372513/162054779-b4a55e49-e560-4f10-906f-82a55f565d6e.png)

и отвечайте на вопросы интерактивного конфигуратора.

Будет что-то типа такого:

![image](https://user-images.githubusercontent.com/8372513/162055457-408d47d3-8221-4bb9-8f17-dd0ef8e78c8a.png)

После того, как WireGuard установится, автоматически запустится добавление первого клиента.

В дальнейшем, если нужно будет добавить или удалить клиента, достаточно повторно запустить конфигуратор командой:
```bash
./wireguard-configurator.sh
```

Программу для клиента можно скачать с официального сайта: https://www.wireguard.com/install/
## ENG
### Description
An interactive VPN server deployment and maintenance tool for individual use based on WireGuard.

Does not require Linux administration skills.

What can:
- Works in Russian and English (selected at startup)
- Install and uninstall the VPN-server
- Add clients
- Delete clients
- Rename clients
- Show client configuration as a QR code

### Installation and use
After logging in as root user, run the command:
```bash
wget -O wireguard-configurator.sh "https://raw.githubusercontent.com/SPIDER-L33T/wireguard-configurator/main/wireguard-configurator.sh" && chmod +x wireguard-configurator.sh && ./wireguard-configurator.sh
```

and answer the questions of the interactive configurator.

In the future, if you need to add or remove a client, just restart the configurator with the command:
```bash
./wireguard-configurator.sh
```
