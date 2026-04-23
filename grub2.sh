#!/bin/bash

# =================================================================
# ASSUNTO: Configuração do Grub2 - Preparação do Ambiente
# =================================================================

# 1. Trocar para o usuário comum criado para os testes
# O objetivo é testar permissões fora do usuário root
su - heberton

# 2. Verificar o endereço IP da interface de rede
# Usado para garantir a conectividade antes de testar o acesso SSH
ip addr show

# 3. Testar a conexão SSH de um terminal externo (WSL)
# Comando utilizado: ssh heberton@192.168.143.15

# =================================================================

# 1. Acessando os arquivos binários do Grub2 (Onde ele vive)
cd /boot/grub2
ls
# Aqui você viu o arquivo grub.cfg - Este é o arquivo final que o sistema lê.
# IMPORTANTE: Não devemos editar o grub.cfg manualmente.

# 2. Acessando o arquivo de configuração de usuário (Onde editamos)
cd /etc/default
ls
# O arquivo 'grub' dentro desta pasta é onde o administrador faz as mudanças.
# Aqui definimos tempo de timeout e parâmetros do kernel.

# 3. Lendo as configurações atuais
cat grub
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 elevator=noop crashkernel=auto"
GRUB_DISABLE_RECOVERY="true"

#Explicação:

#/boot/grub2/grub.cfg: É o arquivo "compilado". O Linux lê esse arquivo para saber como iniciar, mas ele é gerado automaticamente.

#/etc/default/grub: É o arquivo de "entrada". Quando você quer mudar o tempo de espera do menu ou a resolução da tela, você edita este arquivo e depois roda um comando para atualizar o outro.

# 4. Explorando os scripts geradores do Grub
cd /etc/grub.d
ls

# Entendendo os scripts:
# 00_header: Define as configurações gerais (como o timeout).
# 01_users: Gerencia autenticação de usuários no boot.
# 10_linux: Localiza o Kernel do Linux e cria as entradas do menu.
# 30_os-prober: Tenta encontrar outros Sistemas Operacionais (Dual Boot).
# 40_custom: Espaço para você adicionar entradas manuais personalizadas.

# 5. Editando o arquivo de configuração principal (via root)
vi /etc/default/grub

# Explicação das variáveis que você encontrou:

# GRUB_TIMEOUT=1
# Define quanto tempo (em segundos) o menu fica esperando você escolher uma opção.
# No seu caso, está configurado para apenas 1 segundo.

# GRUB_DEFAULT=saved
# Indica que o sistema vai iniciar por padrão na última opção que você escolheu
# ou na primeira da lista caso nunca tenha escolhido.

# GRUB_CMDLINE_LINUX="..."
# Essa é a linha mais importante. São os parâmetros que o Kernel recebe ao ligar.
# Exemplos no seu arquivo: 
# - console=tty0: Envia a saída para o monitor virtual.
# - crashkernel=auto: Reserva memória para logs caso o sistema trave (Kernel Panic).

# GRUB_DISABLE_RECOVERY="true"
# Desabilita aquelas opções de "Modo de Recuperação" no menu inicial.

# 6. Exemplo de customização do GRUB
/etc/default/grub

# CONFIGURAÇÃO ORIGINAL:
# GRUB_TIMEOUT=1          -> Menu aparece por apenas 1 segundo
# GRUB_DEFAULT=saved      -> Inicia na última opção salva
# GRUB_DISABLE_RECOVERY="true" -> Oculta modo de recuperação

# CONFIGURAÇÃO DE EXEMPLO (Para testes):
# GRUB_TIMEOUT=10         -> Dá 10 segundos para o usuário escolher o Kernel
# GRUB_DEFAULT=2          -> Inicia automaticamente na terceira opção da lista (índice 0, 1, 2)
# GRUB_DISABLE_RECOVERY="false" -> Mostra as opções de recuperação no menu

# 7. Aplicando as alterações do Grub
# O comando grub2-mkconfig lê os scripts em /etc/grub.d e o arquivo /etc/default/grub
# e gera um novo arquivo de configuração final.

# IMPORTANTE: Use sempre o redirecionamento -o para o caminho do arquivo oficial.
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# O que esse comando faz:
# - Procura por kernels instalados em /boot.
# - Procura por outros sistemas operacionais.
# - Gera a lista de entradas do menu que você vê ao ligar a máquina.