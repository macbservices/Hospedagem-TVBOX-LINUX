# Hospedagem TV Box Linux

Este projeto automatiza a instalação de um servidor web Apache e configura um túnel Cloudflare para expor seu site com domínio personalizado no seu TV box rodando Ubuntu 18.04.

## Como usar

No seu TV box, basta rodar o comando abaixo para baixar e executar o script de instalação automática:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/macbservices/Hospedagem-TVBOX-LINUX/main/setup.sh)




O script irá:

- Atualizar o sistema e instalar Apache
- Pedir para você autenticar o Cloudflare Tunnel no navegador
- Pedir o nome do túnel (exemplo: site-damasceno)
- Pedir o domínio para usar (exemplo: eletronica.damascenodigitaltech.com.br)
- Criar e configurar o túnel automaticamente
- Iniciar o serviço do túnel para rodar em background

## Coloque seus arquivos web

Coloque os arquivos do seu site dentro da pasta padrão:

/var/www/html/


Você pode copiar seus arquivos para lá via terminal, por exemplo:

sudo cp -r /caminho/do/seu/site/* /var/www/html/


Ou editar diretamente a página inicial:

sudo nano /var/www/html/index.html


## Requisitos

- TV box com Ubuntu 18.04 instalado
- Conexão com internet para baixar pacotes
- Conta ativa no Cloudflare com domínio registrado

---

## Autor e Propriedade do Projeto

Este projeto, denominado **Hospedagem TV Box Linux**, foi desenvolvido e é mantido exclusivamente por **macbservices**. Todos os direitos autorais e responsabilidade sobre o conteúdo, código-fonte, documentação e distribuição são reservados ao autor.

Ao utilizar este projeto, você reconhece **macbservices** como o único detentor original e legítimo do código e documentos aqui presentes.

Para contato, suporte ou propostas de colaboração, utilize os canais oficiais do repositório no GitHub:  
https://github.com/macbservices/Hospedagem-TVBOX-LINUX

---

Caso tenha dúvidas, abra uma issue no repositório.


```bash
bash <(curl -sSL https://raw.githubusercontent.com/macbservices/Hospedagem-TVBOX-LINUX/main/phpmyadmin.sh)
