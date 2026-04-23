# Linux Mastery - CentOS 7

Repositório dedicado à documentação e laboratórios práticos da Formação Linux Completa.

## 🛠️ Passo 1: Preparação do Setup

Para este laboratório, utilizamos uma estrutura de virtualização integrada para simular um ambiente de administração de servidores real:

1. **WSL2 (Ubuntu 24.04):** Terminal de gerenciamento principal para execução de comandos Git e acesso SSH.
2. **VirtualBox:** Hypervisor para execução da máquina virtual CentOS 7.
3. **Vagrant:** Ferramenta para infraestrutura como código (IaC), automatizando a criação da VM.
4. **VS Code:** IDE principal para edição de scripts e documentação via extensão WSL.

## 🚀 Passo 2: Provisionamento da VM

1. **Configuração do Vagrantfile:** Definição de hardware (1GB RAM, 1 vCPU) e nome personalizado da instância.
2. **Rede em Bridge:** Configuração de interface de rede em modo bridge para comunicação direta entre o host e a VM.
3. **Comando de Inicialização:**
   ```bash

   vagrant up

   ```
## 🔐 Passo 3: Conectividade e Acesso Remoto

Para garantir um fluxo de trabalho eficiente entre o Host (Windows/WSL) e o Guest (CentOS), as seguintes configurações foram aplicadas:

1. **Ajuste de Autenticação:** Alteração no arquivo de configuração do serviço SSH da VM (`/etc/ssh/sshd_config`) para permitir `PasswordAuthentication yes`, possibilitando o acesso via senha.
2. **Reinicialização do Serviço:** Aplicação das novas diretivas de segurança através do comando:
   ```bash
   
   sudo systemctl restart sshd

   ```