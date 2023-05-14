# Projeto Paygo-ACBr-SACFiscal-Nuvem Fiscal

![Demo PayGO Flutter](https://github.com/sacfiscal/paygo_flutter/blob/main/images/logo.png)


## Demo PayGO Flutter

Este projeto visa acelerar a estratégia da Software House na adoção do android no varejo, integrado ao TEF PayGO e API NFC-e da Nuvem Fiscal, demonstrando como integrar ao PayGO Integrado no android e à API de NFC-e.

## Ambiente e Packages Utilizados

- Flutter 3.7.7: (https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.7.7-stable.zip)
- Dart 2.19.4 – DevTools 2.20.1
- PayGO_SDK 0.0.3 (pub.dev)
- Aplicativo PayGO Integrado v. 4.1.21.8 (https://projetoacbr.com.br/tef/#integracao)


## Estrutura do Projeto

![Demo PayGO Flutter]https://github.com/sacfiscal/paygo_flutter/blob/main/docs/images/estrutura.png

- Commons: Camadas de base, utilizadas nas demais camadas do projeto.
	- Constantes: Configurações de acesso à api da Nuvem Fiscal e do banco de dados SQLite criado na aplicação
	- Functions: Funções usadas pelo projeto, como acesso a api da Nuvem Fiscal e persistência de entidades
	- Styles: Definições de cores e visuais do aplicativo 
	- Types: tipos de dados fixos usados na aplicação (equivalente  enums)
-  Domains/models: Entidades do projeto
	- Application: Acesso à bluetooth e impressoras
	- Database/paygo_sqlite: Models de entidades de persistência

- Infrastructure: Camada de service de repositórios e de API. Nesta camada temos os DTOs para cada endpoint usado da api nuvem fiscal, assim como os objetos DAO de persistência das entidades no banco de dados.
	- Service > Elgin: Classe de acesso à impressão no equipamento Elgin M10
- Presentation: Camada de visualização da aplicação.
	- Application: Controllers dos componentes visuais
	- Views: Telas visuais do aplicativo




## Execução da chamada do TEF:

Ocorre em application_controller.dart, solicitarPagamentoClick() (linha 960). 
PayGOSdk repository = PayGOSdk(); // aqui é chamado o sdk (paygo_integrado_service.sdk) que efetua as transações com o PayGOIntegrado.



## Execução da Chamada da API NFC-e:

Ocorre em: lib\infrastructure\services\api\nuvem_fiscal\documentos_eletronicos\service\documentos_eletronicos_service.dart
Aqui temos os endpoints utilizados para geração consulta do cnpj, geração da NFC-e, inutilização de numeração e cancelamento da NFC-e.


## Utilização do Aplicativo

1 - Na primeira execução do app, será solicitado o CNPJ da empresa, que deverá estar previamente cadastrada na API da Nuvem Fiscal, pela própria Software House.

2 - Após a validação do CNPJ na API da Nuvem Fiscal, será solicitado login (usuário: admin/senha: admin) para acesso ao app.

![Demo PayGO Flutter](https://github.com/sacfiscal/paygo_flutter/blob/main/docs/images/login.png)

3 - Na tela principal temos acesso aos cadastros e às configurações. Inicialmente deve ser configurado o ambiente de emissão, a série de NFCe a ser utilizada e a última numeração para sequência da NFC-e.

![Demo PayGO Flutter](https://github.com/sacfiscal/paygo_flutter/blob/main/docs/images/login.png)

4 - Na aba de Impressão, escolhemos a impressora, via bluetooth que será utilizada nas impressões.

![Demo PayGO Flutter](https://github.com/sacfiscal/paygo_flutter/blob/main/docs/images/config.png)


5 - Na tela de venda, após inserir os produtos, ocorre a finalização da venda com o pagamento via TEF ou dinheiro e na sequência a emissão da NFC-e.

![Demo PayGO Flutter](https://github.com/sacfiscal/paygo_flutter/blob/main/docs/images/venda.png)

6 - O XML autorizado é baixado e salvo no banco dedados local e a impressão do DANFECe se dá consumindo o endpoint de ESCPOS na API da Nuvem Fiscal, e mandando para o componente ACBrPOSPrinter.

7 - Os comprovantes de transações TEF impressos também são gravados no banco de dados local do app.

8 - O aplicativo possui a implementação da inutilização de numeração e cancelamento da NFCe.

![Demo PayGO Flutter](https://github.com/sacfiscal/paygo_flutter/blob/main/docs/images/inutilizacao.png)


## Licença

MIT
