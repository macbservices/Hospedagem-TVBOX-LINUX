#!/bin/bash

echo "Iniciando configuração completa do servidor web e Cloudflare Tunnel..."

# Atualizar sistema e instalar Apache + PHP Completo + SQLite3 + MySQL
sudo apt update && sudo apt upgrade -y
sudo apt install -y apache2 php libapache2-mod-php php-mysql php-curl php-json php-mbstring php7.4-sqlite3 php-sqlite3 mariadb-server
sudo a2enmod rewrite headers ssl
sudo systemctl restart apache2

echo "Apache + PHP + SQLite3 + MySQL instalados e configurados."

# Configurar MySQL (interativo)
echo "Configurando MySQL seguro... (responda as perguntas abaixo)"
sudo mysql_secure_installation

echo "Apache/PHP/SQLite3/MySQL pronto!"
echo "Coloque seus arquivos web em '/var/www/html/'. Exemplo de comando para copiar arquivos:"
echo "sudo cp -r /caminho/do/seu/site/* /var/www/html/"
echo "sudo chown -R www-data:www-data /var/www/html/"
echo "sudo chmod -R 755 /var/www/html/"

# Instalar cloudflared (Cloudflare Tunnel)
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt update
sudo apt install cloudflared -y

echo "Cloudflared instalado."

# Autenticar cloudflared na Cloudflare
echo "Abra o link abaixo no navegador para autenticar o Cloudflare Tunnel:"
cloudflared tunnel login
read -p "Pressione Enter após autenticar no navegador..."

# Receber nome do túnel e domínio
read -p "Digite o nome do túnel (exemplo: macb-tools): " NOME_TUNEL
read -p "Digite seu domínio (exemplo: macbtools.grythprogress.com.br): " DOMINIO

# Criar túnel
cloudflared tunnel create $NOME_TUNEL

# Capturar arquivo de credenciais
ARQUIVO_CREDENCIAIS=$(ls ~/.cloudflared/*.json | head -n 1)
if [ -z "$ARQUIVO_CREDENCIAIS" ]; then
  echo "Erro: arquivo de credenciais não encontrado. Saindo."
  exit 1
fi

# Criar arquivo de configuração do túnel
sudo mkdir -p /etc/cloudflared
sudo tee /etc/cloudflared/config.yml > /dev/null <<EOF
tunnel: $(basename $ARQUIVO_CREDENCIAIS .json)
credentials-file: $ARQUIVO_CREDENCIAIS

ingress:
  - hostname: $DOMINIO
    service: http://localhost:80
  - service: http_status:404
EOF

# Configurar DNS na Cloudflare para o túnel
cloudflared tunnel route dns $NOME_TUNEL $DOMINIO

# Instalar e iniciar serviço
sudo cloudflared service install
sudo systemctl enable cloudflared
sudo systemctl start cloudflared

echo "✅ Configuração COMPLETA concluída!"
echo "🌐 Seu site estará disponível em http://$DOMINIO"
echo "📁 Coloque arquivos em /var/www/html/ e teste com:"
echo "curl -I http://localhost"
echo "php -m | grep sqlite"
