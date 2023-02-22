# Atak SearchApp

Aplicativo cross-platform Android/iOS em Flutter desenvolvido como parte do teste realizado para a empresa Atak Sistemas.

## Descrição

Aplicativo cross-platform desenvolvido utilizando Flutter e Dart, onde o objetivo foi desenvolver, em qualquer linguagem ou plataforma, um cliente para consumir a API desenvolvida em qualquer linguagem, e mostrar os resultados de uma pesquisa no Google. 
Ex: <i>Apenas um campo para entrada de dados do valor a ser pesquisado; Um botão para disparar a pesquisa; Um container para exibir o resultado. Não pode ser utilizado IFrames, ou similares. O Titulo deve ser exibido, sem link. O Link logo abaixo do Titulo, clicável e abrir em uma nova janela. Não deve ser exibido mais nada da página do Google. Todas as outras informações, cabeçalhos, rodapés, etc devem ser descartados.</i>

O aplicativo foi desenvolvido utilizando GetX como State Management. Ao iniciar, o aplicativo coloca a controller HomePageController na memória, e ao fazer isso, pega os dados de login salvos diretamente dentro do código e tenta realizar um login na API, que com sucesso retorna um token JWT, permitindo que o usuário possa acessar todas as rotas restritas da API. 

A HomePage exibe um input, onde o usuário pode digitar qualquer termo que desejar, e então pode escolher entre retornar os resultados da pesquisa utilizando o Cheerio ou o Puppeteer. Também é possível trocar de um para o outro, possibilitando a comparação direta de velocidade entre as duas abordagens. Ao clicar no botão de pesquisar com uma das duas bibliotecas, o aplicativo exibe uma tela de carregamento enquanto aguarda os resultados chegarem da Api em localhost. Os resultados então são exibidos ao usuário, onde o mesmo pode clicar no link que desejar, e então a página será aberta externamente em seu navegador padrão do dispositivo. Se desejar, também é possível avançar ou retroceder as páginas da pesquisa, e então uma nova requisição é feita, que retorna os dados da nova página.

Também foram implementados testes de unidade e testes de integração (e2e).

## Instalação - ATENÇÃO

1. Ter o Flutter instalado na máquina, pode ser feito através do link: https://docs.flutter.dev/get-started/install, que por sua vez, obriga a instalação do Android Studio, mas o projeto pode ser rodado também através do VS Code se preferir.

2. Ter subido a <b>atak-searchapi</b> com <b>npm run start</b> em: https://github.com/fefsouza10/atak-searchapi

3. Clonar o projeto em alguma pasta, e então abrí-lo através do Android Studio ou VS Code.

4. <b>IMPORTANTE</b>: Entre no arquivo <b>lib/config/http_config.dart</b>, e siga as instruções:

Caso vá rodar o aplicativo em um dispositivo FÍSICO, na variável 'localhost', troque o IP pelo IPV4 da sua máquina na sua rede. Provavelmente só será necessário trocar os dois últimos números antes da porta 3000:
```bash
'http://192.168.X.X:3000'
```
Caso vá rodar o aplicativo em um emulador na sua máquina, troque o valor da variável 'localhost' por:
```bash
'http://10.0.2.2:3000'
```

Isso se dá por conta dos valores diferentes de localhost que um dispositivo físico e um emulador conseguem ler para acessar a API. Sem essas alterações, o aplicativo não consegue se conectar na API para executar suas tarefas.

## Testes

Para rodar os testes de unidade, rode pela IDE o arquivo <b>test/home_page_controller_test.dart</b>, ou rode pelo terminal com o comando:
```bash
$ flutter test test/home_page_controller_test.dart
```

Para rodar os tests de integração, rode pela IDE o arquivo <b>integration_test/home_page_test.dart</b>, ou rode pelo terminal com o comando:
```bash
$ flutter test integration_test/home_page_test.dart
```
