<h1 align="center">Open-Buffet</h1>

<div align="center">

  ![Static Badge](https://img.shields.io/badge/ruby-3.2.3-black?style=for-the-badge&logo=ruby&logoColor=red&labelColor=black&color=white)
  ![Static Badge](https://img.shields.io/badge/ruby_on_rails-7.1.3-black?style=for-the-badge&logo=rubyonrails&logoColor=red&labelColor=black&color=white)
  ![Static Badge](https://img.shields.io/badge/Sqlite3-3.37.2-black?style=for-the-badge&logo=sqlite&logoColor=blue&labelColor=black&color=white)


</div>


<p align="center">
 <a href="#started">Executando o projeto</a> • 
 <a href="#test">Testes</a> • 
 <a href="#GuideApp">Guia de uso da aplicação</a> •
 <a href="#information">Informações da aplicação</a> •
 <a href="#observation">Observação</a> •
 <a href="#routes">Documentação API</a>
</p>


<h2 id="started">🚀 Executando o projeto: </h2>

Para executar o projeto Open-Buffet, é necessário possuir na sua maquina as segintes ferramentas instaladas e executar os passos seguintes.

<h3>Pré requisitos</h3>

- [Ruby 3.2.3](https://www.ruby-lang.org/en/news/2024/01/18/ruby-3-2-3-released/)
- [SQLite3 3.37.2](https://www.sqlite.org/)
- [Libvips](https://www.libvips.org/)

Comando para instalar o Libvips no ubuntu:

```sh 
sudo apt install libvips-dev
```

<h3>Passos para a execução</h3>

- Clone o repositório

```sh 
  git clone https://github.com/DaniloRibeiro07/Open-Buffet.git
```

- Abra o diretório pelo terminal
```sh 
  cd Open-Buffet
```

- Instale as Gems via bundle

```sh 
  bundle install
```

- Cria e popula o banco de dados

```sh 
  rails db:setup
```

- Execute a aplicação

```sh 
  rails s
```

- Acesse a aplicação no link http://localhost:3000/

<h2 id="test">Testes</h2>

<p>Comando para executar testes integrados da aplicação:</p>

```sh
  rspec
```

<h2 id="GuideApp">Guia de Uso da aplicação</h2>

Ao acessar a aplicação, o usuário visualizará na tela inicial os buffets cadastrados, poderá clicar nos buffets para vê detalhes, pesquisar pelo nome do buffet, ou cidade ou nome do evento e fazer login.

Enquanto o usuário não fizer login, ele só terá acesso a páginas de detalhes de eventos do buffet ou do próprio buffet.

Se o usuário estiver logado como cliente, ele poderia fazer um pedido, vê o andamento de todos os seus pedidos, conversar com o buffet, avaliar o pedido após confirmado e realizado o evento. 

Se o usuário estiver logado como dono do buffet, ele deverá ter informado os dados do seu buffet, poderá cadastrar evento, ativar ou desativar o seu evento e o seu buffet, vê todos os seus pedidos e vê outros buffets.

<h2 id="information">Informações da aplicação</h2>

Na aplicação há 3 usuários clientes: <br>
- Usuário Joana, email: Joana@teste.com e senha: teste123 <br>
- Usuário Sabrina, email: Sabrina@teste.com e senha : teste123 <br>
- Usuário Olivia, email: Olivia@teste.com e senha: teste123<br>


Na aplicação há 7 usuários empresas: <br>
- Usuário Alecrim, email: Alecrim@teste.com e senha: teste123<br>
Que possui um buffet e dois tipos de evento.<br>


- Usuário Marcola, email: Marcola@teste.com e senha: teste123<br>
Que possui um buffet e três tipos de evento.<br>
Com 4 pedidos aprovados e avaliados.<br>
1 Pedido Aguardando Avaliação do Cliente<br>
1 Pedido aguardando a avaliação do buffet<br>

- Usuário Nanda, email: Nanda@teste.com e senha: teste123<br>
Que possui um buffet e três tipos de evento.<br>

- Usuário Otavio, email: Otavio@teste.com e senha: teste123<br>
Que possui um buffet, desabilitado, e um tipo de evento.<br>

- Usuário Marcia, email: Almeida@teste.com e senha: teste123<br>
Que ainda não cadastrou o seu buffet.<br>

- Usuário Sofia, email: Sofia@teste.com e senha: teste123<br>
Sofia possui o seu buffet e dois eventos cadastrados:<br>
Amazonico, que está desabilitado<br>
Pirata, que está habilitado, e com duas imagens<br>

- Usuário Matheus, email: MatheusSilva@teste.com e senha: teste123<br>
Matheus possui apenas o buffet, sem eventos cadastrados


<h2 id="observation">Observação</h2>

Observação na tarefa API de Buffets: <br>
Tópico: Consulta de disponibilidade? <br>

Um buffet <strong>estará disponível</strong> quando não houver agendamentos confirmados naquele dia. <br><br>

<h2 id="routes">Documentação da API: </h2>

- [Listagem de Bufets](#listagem-de-buffets)
- [Listagem de tipos de eventos de um buffet](#listagem-de-tipos-de-eventos-de-um-buffet)
- [Detalhes de um buffet](#detalhes-de-um-buffet)
- [Consulta de disponibilidade](#consulta-de-disponibilidade)

### <a name = "listagem-de-buffets"></a> Listagem de Buffets: <br>

Para requisitar uma listar de todos os buffet será necessário fazer a seguinte requisição:

Verbo: <strong>GET</strong> URL: http://127.0.0.1:3000/api/v1/buffet_registrations

A resposta a requisição será um json contendo uma lista de objetos.
Cada objeto conterá o ID do buffet, nome, estado e cidade.
Se a requisição for realizada com sucesso, o status retornado é 200.

Caso ocorra um erro no servidor durante a requisição, haverá uma resposta com status 500.

Exemplo: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/
<br>
Resultado da requisição:<br>
Status: 200<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
[
    {
        "id": 1,
        "trading_name": "Buffet da familia",
        "state": "TO",
        "city": "Palmas"
    },
    {
        "id": 2,
        "trading_name": "Buffet da Avon",
        "state": "RJ",
        "city": "São Gonçalo"
    },
    {
        "id": 3,
        "trading_name": "Buffet Alegre",
        "state": "TO",
        "city": "Palmas"
    }
]
```

Caso não haja buffets cadastado, o resultado será uma lista json vázia.

Para requisitar uma lista filtrada pelo nome do buffet, será necessário fazer a seguinte requisição:

Verbo: <strong>GET</strong> URL: http://127.0.0.1:3000/api/v1/buffet_registrations?filter=`name`

Onde o "`name`" da URL é o nome utilizado no filtro. <br>

A resposta a requisição será um json contendo uma lista de objetos filtrados. Cada objeto conterá o ID do buffet, nome, estado e cidade.
O status da requisição com sucesso é `200`.

Caso não seja encontrado buffets com o '`name`' informado, será retornado um objeto json, com status `406` e com o attributo "`errors`" "igual a 'Não foi encontrados registros de '`name`'"

Caso ocorra um erro no servidor durante a requisição, haverá uma resposta com status 500.

Exemplo de requisição com sucesso filtrando buffets pelo nome: 

Requisição: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/?filter=`alegre`

Resultado da requisição:<br>
Status: 200<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
[
    {
        "id": 3,
        "trading_name": "Buffet Alegre",
        "state": "TO",
        "city": "Palmas"
    }
]
```
Exemplo de requisição com falha, pois não há buffets com o name informado:

Requisição: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/?filter=`super`

Resultado da requisição:<br>
Status: 406<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
    "errors": "Não foi encontrados registros de super"
}
```


### <a name = "listagem-de-tipos-de-eventos-de-um-buffet"></a>  Listagem de tipos de eventos de um buffet:

Para requisitar uma listar de todos os eventos de um buffet será necessário fazer a seguinte requisição:

Verbo: <strong>GET</strong> URL: http://127.0.0.1:3000/api/v1/buffet_registrations/`buffet_registration_id`/event_types

Onde `buffet_registration_id` deve ser substitudo pelo ID do buffet.

Caso haja um buffet com o ID informado, será dado a seguinte resposta:

A resposta a requisição será um json contendo uma lista de objetos de tipos de evento deste buffet.
Cada objeto conterá o ID do tipo de evento, nome, descrição e quantidade mínima e máxima de pessoas, duração do evento, o menu, se pode conter bebidas, decorações, serviço de valet, se pode ser dentro ou fora do buffet, ID do buffet, se o valor é diferente no final de semana ou não e os valores na semana e final de semana.<br>
Caso não haja tipos de eventos cadastrado no buffet, a resposta será uma lista vazia.
O status da requisição com sucesso é 200.

Caso não seja encontrado buffets com o `id` informado, será retornado um objeto json, com status `406` e com o attributo "`errors`" "igual a 'Não há buffet com o id: '`id`'"


Caso ocorra um erro no servidor durante a requisição, haverá uma resposta com status `500`.

Exemplo: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/1/event_types <br>
Resultado da requisição:<br>
Status: 200<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
[
    {
        "id": 1,
        "name": "Chá de revelação",
        "description": "Chá de revelação para novos pais ",
        "minimum_quantity": 10,
        "maximum_quantity": 55,
        "duration": 63,
        "menu": "Bolo, salgados e docinhos",
        "alcoholic_beverages": false,
        "decoration": true,
        "valet": false,
        "insider": true,
        "outsider": false,
        "buffet_registration_id": 1,
        "different_weekend": false,
        "weekend_price": {
            "base_price": 50.39,
            "price_per_person": 30,
            "overtime_rate": 30
        },
        "working_day_price": {
            "base_price": 50.39,
            "price_per_person": 30,
            "overtime_rate": 30
        }
    }
]
```

Exemplo: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/991/event_types (buffet inexistente)<br>
Resultado da requisição:<br>
Status: 406<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
    "errors": "Não há buffet com o id: 991"
}
```

### <a name = "detalhes-de-um-buffet"></a>  Detalhes de um buffet:

Para requisitar detalhes de um buffet será necessário fazer a seguinte requisição:

Verbo: <strong>GET</strong> URL: http://127.0.0.1:3000/api/v1/buffet_registrations/`id`

Onde `id` deve ser substitudo pelo ID do buffet.

Caso haja um buffet com o ID informado, será dado a seguinte resposta:

A resposta a requisição será um json contendo um objeto com os atributos sendo os detalhes do buffet.

Os atributos serão: id, nome fantasia, telefone, email, logradouro, numero, bairro, estado, cidade, CEP, descrição complemento, um objeto de formas de pagamentos e uma lista de objetos de tipos de evento.<br>

O objeto de formas de pagamentos contém nos seus elementos os métodos de pagamento e o valor de cada elemento representa se é aceito ou não, caso o valor seja true, o metodo de pagamento é aceito, caso o contrário, não. <br>

Cada objeto do tipo de evento contem um id e nome do evento.<br>
Caso não haja tipos de eventos cadastrado no buffet, a resposta será uma lista vazia.

O status da requisição com sucesso é 200.

Caso não seja encontrado buffets com o `id` informado, será retornado um objeto json, com status `406` e com o attributo "`errors`" "igual a 'Não há buffet com o id: '`id`'"

Caso ocorra um erro no servidor durante a requisição, haverá uma resposta com status `500`.

Exemplo: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/1 <br>
Resultado da requisição:<br>
Status: 200<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
    "id": 1,
    "trading_name": "Buffet da familia",
    "phone": "7995876812",
    "email": "Maria@teste.com",
    "public_place": "Quadra 1112 Sul Alameda 5",
    "neighborhood": "Plano Diretor Sul",
    "state": "TO",
    "city": "Palmas",
    "zip": "77024-171",
    "description": "O melhor buffet das perfumaras",
    "payment_method_id": 1,
    "address_number": "25A",
    "complement": "",
    "payment_method": {
        "pix": true,
        "boleto": null,
        "credit_card": null,
        "debit_card": null,
        "money": null,
        "bitcoin": null,
        "bank_transfer": null
    },
    "event_types": [
        {
            "id": 1,
            "name": "Chá de revelação"
        }
    ],
    "average": "2.0"
}
```

Exemplo: GET para http://127.0.0.1:3000/api/v1/buffet_registrations/9999 (buffet inexistente)<br>
Resultado da requisição:<br>
Status: 406<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
    "errors": "Não há buffet com o id: 9999"
}
```

### <a name = "consulta-de-disponibilidade"></a>  Consulta de disponibilidade

Para requisitar se há disponibilidade de um buffet para um determinado evento, será necessário fazer a seguinte requisição

Verbo: <strong>POST</strong> URL: http://localhost:3000/api/v1/event_types/`event_type_id`/orders?date=`date_value`&amount_of_people=`number_value`

Onde `event_type_id` deve ser substituido pelo ID do tipo de evento,
`date_value` deve ser substitudo pela data do evento e `number_value` deve ser substitudo pela quantidade de pessoas participantes do evento.


<strong>Haverá disponibilidade para o evento caso não haja pedidos confirmados no dia.</strong>

O `data_value` deve esta no formato de data dd/mm/yyyy e deve ser maior ou igual a data de hoje. Caso contrário, o servidor retornará como resposta a requisição o status `412` e no body, um arquivo json com o erro de data.

O `number_value` é a quantidade de participantes, este deve ser maior ou igual a quantidade mínima de participantes e menor ou igual a quantidade máxima. Caso contrário, o servidor retornará como resposta a requisição o status `412` e no body, um arquivo json com o erro de quantidade de participantes.

Caso haja um tipo de evento com o ID informado, não haja um pedido confirmado no dia, a data seja válida e quantidade de pessoas também, a resposta será dada da seguinte forma:

A resposta à requisição será um json contendo um único atributo ('prior_value') sendo o valor do pedido.

Caso não haja um problema no servidor, o status da resposta será 200.

Exemplo:
POST para http://localhost:3000/api/v1/event_types/1/orders?date=2025/05/12&amount_of_people=30

Resultado da requisição:<br>
Status: 200<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "prior_value": 650.39
}
```

Caso não seja encontrado o tipo de evento com o `id` informado, será retornado um objeto json, com status `406` e com o attributo "`errors`" "igual a 'Não há um tipo de evento com o id: '`id`'"

Exemplo: POST para  http://localhost:3000/api/v1/event_types/99999/orders?date=2025/05/12&amount_of_people=30 (tipo de evento inexistente)<br>
Resultado da requisição:<br>
Status: 406<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": "Não há um tipo de evento com o id: 9999"
}
```

Caso ocorra um erro no servidor durante a requisição, haverá uma resposta com status `500`.

Caso não seja informado a data ou a quantidade de pessoas no evento, será retornado um erro de status 412 e no corpo da resposta, haverá um objeto json com o elemento 'errors' contendo uma lista de strings de errors.

Exemplo: POST para  http://localhost:3000/api/v1/event_types/1/orders?amount_of_people=30 (Não há data)<br>
Resultado da requisição:<br>
Status: 412<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": [
    "Data não pode ficar em branco",
    "Data deve ser maior do que hoje (13/05/2024)"
  ]
}
```

Exemplo: POST para  http://localhost:3000/api/v1/event_types/1/orders?date=2035/05/12 (Não há quantidade de pessoas)<br>
Resultado da requisição:<br>
Status: 412<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": [
    "Participantes do Evento não pode ficar em branco"
  ]
}
```

Exemplo: POST para  http://localhost:3000/api/v1/event_types/1/orders (Não há quantidade de pessoas e nem data)<br>
Resultado da requisição:<br>
Status: 412<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": [
    "Data não pode ficar em branco",
    "Participantes do Evento não pode ficar em branco",
    "Data deve ser maior do que hoje (13/05/2024)"
  ]
}
```

Caso a quantidade de pessoas seja maior ou menor do que a suportada pelo evento, será retornado um erro com status 412 e com o corpo do texto informado o erro e a quantidade suportada.

Exemplo: POST para  http://localhost:3000/api/v1/event_types/1/orders?date=2025/05/12&amount_of_people=500 (Quantidade de pessoas maior do que o suportado)<br>
Resultado da requisição:<br>
Status: 412<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": [
    "Participantes do Evento Deve ser menor ou igual a 55"
  ]
}
```

Exemplo: POST para  http://localhost:3000/api/v1/event_types/1/orders?date=2025/05/12&amount_of_people=1 (Quantidade de pessoas menor do que o suportado)<br>
Resultado da requisição:<br>
Status: 412<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": [
    "Participantes do Evento Deve ser maior ou igual a 10"
  ]
}
```

Caso a data informada seja menor do que o dia de hoje, o resultado da requisição conterá um erro de status 412 e no corpo da resposta haverá um attributo 'errors' com uma lista de errors. 

Exemplo: POST para  http://localhost:3000/api/v1/event_types/1/orders?date=2021/05/12&amount_of_people=1 (Data do evento inferior ao dia de hoje)<br>
Resultado da requisição:<br>
Status: 412<br>
Content_type: application/json; charset=utf-8<br>
body:<br>

```json
{
  "errors": [
    "Data deve ser maior do que hoje (13/05/2024)"
  ]
}
```


