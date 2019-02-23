# imagem/rails5-dev

## Introdução
Esse é um container gerado para docker com o objetivo facilitar o desenvolvimento de aplicações em Ruby on Rails.

## Versões utilizadas
Esse container está equipado com Ruby 2.5.3 e Rails 5.2.2 (além de todas as suas dependências), visando oferecer um sistema mínimo para que se estabelaça um ambiente de desenvolvimento Ruby on Rails.

## O que preciso saber antes de começar?
-- Você utilizará dois containers para desenvolver sua aplicação, um será o container com o postgres e o outro com o ambiente Rails. O comando para o banco de dados cria um usuario `root` com senha `root`, o arquivo yml de configuração do seu projeto deve utilizar esse usuário ou o comando que inicia o container do postgres deve ser mudado.

-- Para acessar o banco de dados você precisará configurar seu arquivo database.yml para utilizar o host a partir da variável de ambiente DB_HOST, além do adapter, username e password do banco:
```
 #---- myapp/config/database.yml
 
 default: &default
   adapter: postgresql
   username: root
   password: root 
   host: <%= ENV['DB_HOST'] %>
```
  Assim você poderá utilizar a mesma imagem em diferentes ambientes Linux, Mac ou Windows (a maneira com que o docker trata as redes no Linux é diferente, por isso usar uma variavel de ambiente é uma boa opção). 

-- O container Rails será iniciado em um diretório `/myapp` que será mapeado para uma pasta de projeto local do seu computador, a partir daí você poderá executar seus comandos para desenvolvimento do seu projeto à vontade.

-- O container Rails utiliza como base uma imagem do Ubuntu 16, na tentativa de estabelecer um ambiente padrão comum de desenvolvimento.

## Tá, mas como funciona???
Primeiro baixe e instale o docker no seu computador. Então baixe esse repositório e abra a interface de comando do seu pc (shell, cmd, etc..), acesse a pasta do repositório utilizando o terminal e execute o comando:

`docker build -t "img/rails5-dev" .`

Um longo processo de download e configuração acontecerá, criando a imagem do rails5-dev para ser utilizada no docker.

Depois da criação da imagem execute o seguinte comando:

`docker run --rm -d --name pgserver -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres`

Esse comando inicia um container com o servidor postgres. Ele também cria um usuário root, com senha root, no container e criar um diretório virtual `pgdata` onde ficarão salvos os dados criados no BD (você normalmente perderia todos os dados do container graças à tag `--rm`, mas, nesse caso, você descartará toda a informação do container EXCETO os dados mapeados na unidade virtual, assim não teremos lixo armazenado à toa).

Agora para iniciar o container do Ruby on Rails, acesse a pasta do seu projeto (ainda utilizando o terminal) e execute um dos seguintes comandos:

***************** Comando para Linux *****************
``docker run -it --rm --net=host -e DB_HOST=localhost -v gemdata:/usr/local/bundle -v `pwd`:/myapp img/rails5-dev bash``

************** Comando para Windows/Mac **************
`docker run -it --rm -p 3000:3000 -e DB_HOST=host.docker.internal -v gemdata:/usr/local/bundle -v %cd%:/myapp img/rails5-dev bash`

Esse comando fará com que o container com a imagem img/rails5-dev seja iniciada, a partir daí você poderá executar vários comandos (o primeiro provavelmente será `bundle install`). Falando do bundle install, os dados referentes à instalação das gems serão salvos no diretório virtual `gemdata`, assim você não terá que baixa-los toda vez que executar o container.

Um detalhe a mais, você talvez queira iniciar seu servidor utilizando o comando:
`rails server -b 0.0.0.0`

Alguns ambientes podem encrencar com o localhost de um ambiente docker, se você indicar o endereço 0.0.0.0 você terá a garantia de que o container se conectará à porta do host. E não se esqueça de alterar seu database.yml para usar as configurações informadas no começo desse readme!!!!

###Divirta-se!
