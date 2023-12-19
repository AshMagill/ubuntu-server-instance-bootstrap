# ubuntu-server-instance-bootstrap

This is a really simple shell script that will get you set up in ubuntu server in aws really fast

you have to be root to use this shell script (run it with sudo)

it will:
install docker
install docker compose
pull whatever repo from github you need, it will prompt you for the github repo address, your username, and password

Please read the shell script before using for the fist time if youre unsure of safety and securtiy, its very safe though.

run this to curl this shell scirpt to your instance:

```
curl -o letsroll.sh https://raw.githubusercontent.com/AshMagill/ubuntu-server-instance-bootstrap/main/letsroll.sh
```
