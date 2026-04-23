# --- TROUBLESHOOTING REPOSITÓRIO CENTOS 7 ---
# O CentOS 7 atingiu EOL (End of Life). 
# Foi necessário apontar os repositórios para o vault.centos.org.
# Comandos utilizados: sed -i para atualizar as URLs em /etc/yum.repos.d/CentOS-Base.repo

# 1. Instalação do Apache (Servidor Web)
yum install httpd -y

# 2. Habilitando o serviço para iniciar com o sistema
systemctl enable httpd
# O 'enable' cria o link simbólico em /etc/systemd/system/multi-user.target.wants/

# 3. Analisando o arquivo de unidade (Onde o Systemd sabe o que fazer)
ls -l /usr/lib/systemd/system/httpd.service
cat /usr/lib/systemd/system/httpd.service
# Aqui vemos variáveis como ExecStart (comando que inicia o Apache)

# 4. Verificando portas ANTES do início do serviço
ss -ln | grep 80
# Observação: A porta 80 deve estar vazia (nenhum serviço escutando)

# 5. Iniciando o serviço e validando a porta 80
systemctl start httpd
ss -ln | grep 80
# Agora a porta 80 aparece como 'LISTEN'

# 6. Verificando o status completo
systemctl status httpd
# Active: active (running) -> Serviço rodando com sucesso!
# Main PID: 21886          -> O processo principal no Linux

# 7. Parando o serviço imediatamente
systemctl stop httpd
# O comando encerra todos os processos (PIDs) do Apache.
# Se rodar 'ss -ln | grep 80' agora, a porta 80 terá sumido.

# 8. Desabilitando a inicialização automática
systemctl disable httpd
# Isso remove o link simbólico que o 'enable' criou.
# O Apache NÃO vai ligar sozinho quando você reiniciar o servidor.