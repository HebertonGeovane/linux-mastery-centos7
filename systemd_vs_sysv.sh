#!/bin/bash

# =================================================================
# Systemd - Localizando os arquivos do Sistema
# =================================================================

# 1. Navegando até o diretório principal do systemd
# É aqui que o CentOS guarda as definições de como o sistema deve iniciar
cd /usr/lib/systemd/system

# 2. Onde o Administrador mexe (/etc/systemd/system)
cd /etc/systemd/system
ls
# Aqui ficam as customizações e os links para o que deve iniciar no boot.
# default.target: É um link que define qual target o sistema inicia por padrão.

# 3. Onde o Sistema mora (/usr/lib/systemd/)
cd /usr/lib/systemd/
ls
# Este diretório contém os binários e geradores reais do systemd.
# Note o diretório 'system' aqui dentro: é onde ficam os arquivos .service originais.

# 4. Validando a transição SysV -> Systemd
# Listando todos os arquivos que terminam em .target
ls *.target

# 5. O segredo dos links simbólicos
ls -l runlevel6.target
# Você notou que: runlevel6.target -> reboot.target
# Isso prova que o comando 'init 6' apenas chama o 'reboot.target' do systemd.

# 6. Verificando o alvo de inicialização padrão (Default Target)
systemctl get-default
# Saída: multi-user.target (Equivalente ao antigo Runlevel 3)

# 7. O comando para restaurar ou isolar o target padrão
systemctl isolate default.target