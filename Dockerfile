# Buscando algumas imagens do docker hub para facilitar a vida
FROM ubuntu:16.04
FROM ruby:2.5.3
MAINTAINER felipearmat@gmail.com

# Instalando o curl logo de Início
RUN apt-get update \
&& apt-get install curl -y

# Instalando algumas dependências
# (Os comandos RUN são separados pois geram um save point de onde a imagem pode ser reconstruída posteriormente)
RUN apt-get install -y zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev

# Instalando yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update \
&& apt-get install -y yarn

# Instalando o bundler
RUN /bin/bash -l -c "gem install bundler"

# Instalando o NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get install -y nodejs

# Instalando o Rails
RUN /bin/bash -l -c "gem install rails -v 5.2.2"

#Fazendo TODOS os updates da imagem
RUN apt-get upgrade -y

# Criando a pasta do app
RUN cd /
RUN mkdir myapp

# Configurando o container para começar diretamente na pasta myapp
WORKDIR /myapp

# Disponibilizando a porta 3000 para o docker
EXPOSE 3000
