#!/bin/bash

# =================================================================
# cd / && ls -l          # Listagem da raiz e identificação de links simbólicos
# cd bin && pwd          # Binários de comandos do usuário (link para /usr/bin)
# bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  swapfile  sys  tmp  usr  vagrant  var
# =================================================================


# 1. /boot: Arquivos essenciais para a inicialização do sistema
cd /boot
ls -l
# vmlinuz: O coração do sistema (Kernel do Linux)
# initramfs: Sistema de arquivos temporário usado no boot (carrega drivers)
# grub2: Configurações do gerenciador de boot

# 2. /dev: Arquivos de dispositivos (Hardware)
# No Linux, tudo é arquivo, inclusive o hardware.
cd /dev
ls
# sda: Representa o seu disco rígido (Serial Digital Archive)
# tty: Representa os terminais de console

# 3. Verificando partições de disco
# O comando fdisk -l lista os discos e partições disponíveis no sistema.
sudo fdisk -l

# 4. /etc: O "Cartório" do sistema. Contém arquivos de configuração global.
cd /etc
ls
# crontab: Agendamento de tarefas automáticas.
# openldap: Configurações de diretório (visto na ementa do curso).
# postfix: Configurações do servidor de e-mail (SMTP).

# 5. Explorando o Postfix (Servidor de E-mail)
cd postfix
ls
# main.cf: O arquivo de configuração principal do Postfix.
# master.cf: Define como os processos do Postfix rodam.

# 6. /home: Onde moram os usuários comuns do sistema.
cd /home
ls
# vagrant: Diretório pessoal do usuário padrão desta VM.
# Nota: Cada usuário criado terá uma pasta aqui (ex: /home/heberton).

# 7. Criando um novo usuário e validando o diretório /home
# O comando adduser cria o usuário e automaticamente gera sua pasta em /home
sudo adduser heberton

cd /home
ls -la
# Observações:
# - .  : Representa o diretório atual (/home)
# - .. : Representa o diretório pai (raiz /)
# - Notar que o diretório 'heberton' tem permissões drwx------ (privado)

# 8. /lib e /lib64: Bibliotecas essenciais do sistema
# Assim como o /bin, no CentOS 7 estes são links simbólicos.
cd /
ls -l | grep lib

# Anotação:
# lib -> usr/lib     : Bibliotecas de 32 bits (legado/essencial)
# lib64 -> usr/lib64 : Bibliotecas de 64 bits (padrão atual)

# 9. /lib: Bibliotecas compartilhadas essenciais
cd /lib
ls
# Observação: Aqui ficam bibliotecas para o Kernel, Systemd e Firmwares.

# 10. Explorando o GRUB (Bootloader)
# O GRUB precisa de módulos específicos para entender o hardware no boot.
cd grub/i386-pc
ls
# Nota: Você verá diversos arquivos .mod. Eles são os "plugins" que permitem
# que o GRUB entenda sistemas de arquivos como EXT4, XFS ou LVM.

# 11. /usr: Unix System Resources
# No CentOS 7, este é o diretório mais importante, pois centraliza os 
# arquivos que antigamente ficavam espalhados na raiz.
cd /usr
ls
# bin: Binários dos usuários (onde o /bin aponta).
# sbin: Binários do sistema (comandos de admin).
# lib e lib64: Bibliotecas dos programas.
# share: Documentação e arquivos compartilhados (arquitetura independente).

# 12. /mnt e /media: Pontos de montagem temporários
cd /
ls -ld mnt media
# /mnt: Usado por administradores para montar sistemas de arquivos manualmente.
# /media: Geralmente usado pelo sistema para montagem automática de mídias (CD/USB).

# 13. /media e /mnt: Pontos de Montagem
# /media: Montagens automáticas do SO (ex: Pendrive, CD-ROM).
# /mnt: Montagens manuais feitas pelo Administrador (ex: um disco extra da AWS).
cd /media
ls

# 14. /opt: Optional (Softwares de terceiros)
# Local para instalação de pacotes que não seguem o padrão do repositório oficial.
# Exemplo: Agentes de monitoramento, Google Chrome, etc.
ls -ld /opt

# 15. /proc e /sys: Diretórios Virtuais (Pseudo-Filesystems)
# Importante: Esses arquivos NÃO existem no disco, eles são criados na Memória RAM.
# /proc: Informações sobre processos e recursos do Kernel (CPU, Memória).
ls /proc
cat /proc/cpuinfo # Exemplo: Ver detalhes do processador

# /sys: Informações sobre o hardware e drivers gerenciados pelo Kernel.
ls /sys

# 16. /root: O Home do Superusuário
# Diferente dos usuários comuns, o root tem sua própria pasta na raiz por segurança.
sudo ls -la /root

# 17. /run: Dados de tempo de execução
# Armazena dados de programas que estão rodando desde o último boot (ex: IDs de processo).
ls /run

# 18. /sbin: System Binaries
# Comandos executáveis exclusivos para o administrador (root), como fdisk, iptables.
ls -l /sbin # No CentOS 7, também é um link para /usr/sbin.

# 19. /srv: Service Data
# Dados de serviços providos pelo sistema (ex: arquivos de um servidor FTP).
ls /srv

# 20. /tmp: Arquivos Temporários
# Qualquer usuário pode escrever aqui. Geralmente é limpo a cada reinicialização.
ls -la /tmp

# 21. /var: Variable (Arquivos variáveis)
# Onde ficam os dados que mudam constantemente.
# /var/log: Logs do sistema (Onde o SRE passa a maior parte do tempo).
# /var/cache: Dados temporários de pacotes (YUM).
ls /var/log

# 22. /vagrant: Pasta compartilhada (Exclusivo do Vagrant)
# Este diretório é um espelho da pasta do seu projeto no Windows/WSL.
ls /vagrant

# 23. swapfile: Memória Virtual
# No CentOS, se a RAM acabar, o sistema usa este arquivo no disco para não travar.
ls -lh /swapfile