![Frame 2](https://github.com/user-attachments/assets/576829fe-7608-4c40-afa0-c9f2965cdfb4)

# Konsi Test ReadMe

O projeto "Konsi Test" é um aplicativo desenvolvido em Flutter como parte de um teste de habilidades. A aplicação foi criada para otimizar o fluxo de trabalho de Carlos, um servidor público que precisa pesquisar CEPs e visualizar bairros no mapa de forma eficiente, além de registrar e consultar esses endereços de maneira rápida e organizada.

Este documento tem como objetivo fornecer instruções detalhadas sobre a instalação, configuração e utilização do projeto.

APK: https://drive.google.com/file/d/1b0Fsgafg8eTrXJ-i0NiC1w1NgaogQnu_/view?usp=sharing


## Sumário

- [Funcionalidades](#funcionalidades)
- [Instalação](#instalação)
  - [Pré-requisitos](#pré-requisitos)
  - [Clonando o Repositório](#clonando-o-repositório)
  - [Configuração](#configuração)
  - [Build e Execução](#build-e-execução)
- [Utilização](#utilização)
- [Manutenção e Atualizações](#manutenção-e-atualizações)
- [Licença](#licença)

## Funcionalidades

As principais funcionalidades do Konsi Test incluem:

- **Pesquisa de CEP:** Permite ao usuário buscar CEPs e exibir o bairro correspondente.
- **Visualização de Mapas:** Exibe o local do bairro no mapa com base no CEP informado.
- **Registro Automático:** Armazena os CEPs pesquisados automaticamente para facilitar futuras consultas.
- **Busca por Histórico:** Sistema de pesquisa que permite ao usuário encontrar endereços previamente registrados.

## Instalação

Siga as instruções abaixo para instalar e configurar o Konsi Test em seu ambiente de desenvolvimento.

### Pré-requisitos

Antes de iniciar, garanta que as seguintes dependências e ferramentas estejam instaladas:

- [Flutter 3.24](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio ou VS Code](https://flutter.dev/docs/get-started/editor)
- Acesso ao repositório do projeto

### Clonando o Repositório

1. Abra seu terminal ou prompt de comando.

2. Clone o repositório privado usando o comando:

   `https://github.com/GuilhermeZety/konsi_test.git`

3. Navegue até o diretório do projeto:

   `cd konsi_test`

### Configuração

1. Instale as dependências do projeto:

   `flutter pub get`

2. Adicione a chave da API do Google Maps:

   - No arquivo `.env`, substitua `SUA_CHAVE_AQUI` pela sua chave de API do Google Maps.
   - No arquivo `android/maps.properties`, substitua `SUA_CHAVE_AQUI` pela mesma chave.

   **Observação:** Caso você não tenha uma chave de API do Google Maps, entre em contato via e-mail guilherme.zety@outlook.com ou pelo WhatsApp (47) 99245-2912, e enviarei uma chave para você.

### Build e Execução

1. Conecte seu dispositivo ou inicie um emulador.

2. Para compilar e executar o projeto, utilize o comando:

   `flutter run`

   Isso compilará o aplicativo e o instalará no dispositivo conectado ou emulador.

## Utilização

Após a instalação, siga os passos abaixo para utilizar o STMF:
 
1. **Busca de CEP:** Insira o CEP desejado para pesquisar o bairro correspondente e visualizar sua localização no mapa.
2. **Salvar Endereço:** A cada pesquisa, o endereço será salvo automaticamente para referência futura.
3. **Histórico de Pesquisas:** Utilize a funcionalidade de busca para encontrar rapidamente CEPs e endereços previamente pesquisados.

## Manutenção e Atualizações

As atualizações do projeto são gerenciadas internamente. Para aplicar atualizações:

1. Puxe as últimas mudanças do repositório:

   `git pull origin main`

2. Reconstrua o projeto se necessário:

   `flutter clean && flutter pub get && flutter run`

3. Siga os procedimentos internos para deploy em ambientes de produção.

## Licença

Este projeto foi desenvolvido como parte de um teste de habilidades e é de uso exclusivo para avaliação pela empresa.
