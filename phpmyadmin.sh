#!/bin/bash
# setup-mysql-phpmyadmin.sh
# Script separado para instalar apenas MySQL + phpMyAdmin em TV Box

echo "🚀 Instalando MySQL + phpMyAdmin para gerenciar bancos .sql..."

# Instalar pacotes necessários
sudo apt update
sudo apt install -y mariadb-server phpmyadmin php-mbstring php-zip php-gd php-xml php-curl libapache2-mod-php

# Configurar phpMyAdmin
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo chown -R www-data:www-data /var/www/html/phpmyadmin
sudo chmod -R 755 /var/www/html/phpmyadmin

# Configurar Apache para PHP
sudo a2enmod rewrite headers ssl
sudo systemctl restart apache2

# Configurar MySQL seguro (interativo)
echo "🔐 Configurando MySQL seguro... Responda as perguntas:"
sudo mysql_secure_installation

# Criar usuário phpMyAdmin com senha simples
sudo mysql -e "CREATE USER IF NOT EXISTS 'phpmyadmin'@'localhost' IDENTIFIED BY 'admin123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;"
sudo mysql -e "FLUSH PRIVILEGES;"

echo ""
echo "✅ INSTALAÇÃO CONCLUÍDA!"
echo ""
echo "🌐 ACESSE O PAINEL:"
echo "http://SEU_DOMINIO/phpmyadmin"
echo ""
echo "👤 LOGIN PHPMYADMIN:"
echo "Usuário: phpmyadmin"
echo "Senha:   admin123"
echo ""
echo "⚠️  MUDA A SENHA LOGADO no phpMyAdmin > Usuários"
echo ""
echo "📋 COMO USAR COM .SQL:"
echo "1. Acesse phpMyAdmin"
echo "2. Clique 'Nova' → Nome do banco (ex: site1)"
echo "3. Importar → Escolher arquivo.sql → Executar"
echo "4. Usuários > Adicionar usuário para o site"
echo ""
echo "💾 Teste se funcionou:"
echo "curl -I http://localhost/phpmyadmin"
