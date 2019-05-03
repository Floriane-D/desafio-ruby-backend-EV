# Desafio de Backend da Estante Virtual

Esse repositório foi feito no contexto do [desafio de backend da Estante Virtual](https://github.com/estantevirtual/vagas/blob/master/desafios/backend.md). O desafio consiste em criar uma API no Ruby on Rails para gerir competições dos Jogos Olímpicos.

Foram usadas as versões 2.5.3 do Ruby e 5.2.2 do Rails.

## Instalação

### Clone

Para instalar a API, é preciso fazer um clone do repositório abaixo:

```
git clone https://github.com/Floriane-D/desafio-ruby-backend-EV.git
```

### Instalação das dependências

Depois, é necessário instalar as dependências, executando o comando abaixo:

```
bundle install
```

### Preparação do banco de dados

a API usa o SQLite 3 como banco de dados. Para prepará-lo, é preciso executar os comandos abaixo:

```
bundle install rake db:create (para criar a database)
bundle install rake db:migrate (para criar as tabelas de competições, atletas e resultados)
bundle install rake db:seed (para criar exemplos de competições, atletas e resultados)
```

### Testes

Antes de usar a API, é importante verificar que a serie de testes não está dando erros. Favor lançar a operação abaixo:

```
bundle exec rspec
```

### Lançamento da API

Para lançar a API, favor executar o comando abaixo:

```
bundle exec rails s
```
A API agora roda na porta 3000.

## API

O objectivo da API é gerir as competições dos Jogos Olímpicos.

### Competições

Cada competição tem os seguintes parâmetros:

* **name**: nome da competição (obrigatório)

* **unit**: unidade de medida dos resultados (obrigatório)

* **finished**: boolean flag para dizer se a competição já estiver encerrada ou não (default: false)

* **max_number_of_attempts**: limite de tentativas por atleta nessa competição (default: 1)

* **criteria_to_win**: critério para fazer o ranking dos resultados. Tem apenas duas possibilidades: *max* e *min* (default: max)

#### Cadastramento de competições: POST /competitions

Para cadastrar uma competição, é necessário passar os parâmetros obrigatórios (e os opcionais, caso tenham) no comando.

Exemplo

```

curl -s -X POST -d "name=Salto em altura&unit=m" http://localhost:3000/competitions | jq

```

##### Retorno:

```
{
  "id": 3,
  "name": "Cuspe a distância",
  "unit": "m",
  "finished": false,
  "criteria_to_win": "max",
  "max_number_of_attempts": 1,
  "ranking": []
}

```

#### Visualização de todas as competições: GET /competitions

A visualização de todas as competições mostra os parâmetros de cada competição, sem o ranking.

Exemplo:

```
curl -s http://localhost:3000/competitions | jq
```

Retorno:

```
[
  {
    "id": 1,
    "name": "100m classificatoria 1",
    "unit": "s",
    "finished": false,
    "criteria_to_win": "min",
    "max_number_of_attempts": 1,
    "url": "http://localhost:3000/competitions/1"
  },

  {
    "id": 2,
    "name": "Dardo semifinal",
    "unit": "m",
    "finished": false,
    "criteria_to_win": "max",
    "max_number_of_attempts": 3,
    "url": "http://localhost:3000/competitions/2"
  },

  {
    "id": 3,
    "name": "Salto em altura",
    "unit": "m",
    "finished": false,
    "criteria_to_win": "max",
    "max_number_of_attempts": 1,
    "url": "http://localhost:3000/competitions/3"
  }
]

```

#### Visualização de uma competição: GET /competitions/id

A visualização de uma competição mostra todos os parâmetros da competição, inclusive o ranking dos resultados, do melhor até o pior.

Exemplo:

```
curl -s http://localhost:3000/competitions/1 | jq
```

Retorno:

```
{
  "id": 1,
  "name": "100m classificatoria 1",
  "unit": "s",
  "finished": false,
  "criteria_to_win": "min",
  "max_number_of_attempts": 1,
  "ranking": [
    {
      "name": "Cassie Emard",
      "athlete_id": 3,
      "value": 9.5
    },
    {
      "name": "Maida Dach",
      "athlete_id": 5,
      "value": 10.1
    },
    {
      "name": "Jewel Auer Jr.",
      "athlete_id": 1,
      "value": 11.2
    },
    {
      "name": "Jaimee Rosenbaum",
      "athlete_id": 2,
      "value": 12.0
    },
    {
      "name": "Walker Rosenbaum",
      "athlete_id": 4,
      "value": 14.1
    }
  ]
}
```

#### Atualização de uma competição: PATCH /competitions/id

Para atualizar um ou vários parâmetros da competição, é necessário incluir os parâmetros atualizados no comando, como ilustrado abaixo:

Exemplo:

No exemplo, o nome da competição 1 vai ser atualizado para “100m final”

```
curl -s -X PATCH -d "name=100m final" http://localhost:3000/competitions/1 | jq
```

Retorno:

```
{
  "id": 1,
  "name": "100m final",
  "unit": "s",
  "finished": false,
  "criteria_to_win": "min",
  "max_number_of_attempts": 1
}

```

#### Finalização de uma competição : PATCH /competitions/id/finish

A finalização de uma competição vai encerrá-la.

Exemplo:

```
curl -s -X PATCH http://localhost:3000/competitions/2/finish | jq
```

Retorno:

```
{
  "id": 2,
  "name": "Dardo semifinal",
  "unit": "m",
  "finished": true,
  "criteria_to_win": "max",
  "max_number_of_attempts": 3,
  "ranking": [
    {
      "athlete_name": "Cassie Emard",
      "athlete_id": 3,
      "value": 98
    },
    {
      "athlete_name": "Jewel Auer Jr.",
      "athlete_id": 1,
      "value": 97
    },
    {
      "athlete_name": "Jaimee Rosenbaum",
      "athlete_id": 2,
      "value": 94
    },
    {
      "athlete_name": "Walker Rosenbaum",
      "athlete_id": 4,
      "value": 90
    },
    {
      "athlete_name": "Maida Dach",
      "athlete_id": 5,
      "value": 80
    }
  ]
}
```

#### Supressão de uma competição : DELETE /competitions/id

Exemplo:

```
curl -s -X DELETE http://localhost:3000/competitions/3 | jq
```

Retorno:

```

```
É normal que a supressão de uma competição não retorna nada.

### Resultados

O cadastro dos resultados pode ser feito tanto para competições e atletas já existentes, como para competições e/ou atletas ainda não cadastrados.

#### Competição e atleta já existentes

Se a competição e o atleta já estejam cadastrados, precisa apenas passar nos parâmetros do comando os IDs da competição e do atleta, junto com a valor do resultado :

* **competition_id**: ID da competição (obrigatório)

* **athlete_id**: ID do atleta (obrigatório)

* **value**: valor do resultado (obrigatório)

Exemplo com competição e atletas existentes:

```

curl -s -X POST -d "competition_id=2&athlete_id=4&value=99" http://localhost:3000/results | jq

```

Retorno:

```
{
  "id": 21,
  "value": 99,
  "athlete_name": "Jaimee Rosenbaum",
  "competition_name": "Dardo semifinal"
}

```

#### Competição e/ou atleta ainda não cadastrados

Caso a competição e/ou o atleta ainda não foram cadastrados, precisa passar os parâmetros abaixo, junto com a valor do resultado :

Parâmetros obrigatórios:

* **competition**: nome da competição (obrigatório)
* **unit**: unidade de medida da competição (obrigatório)
* **athlete**: nome do atleta (obrigatório)
* **value**: valor do resultado (obrigatório)

Parâmetros opcionais:
* **max_number_of_attempts** (default: 1)
* **criteria_to_win** (default: max)

Exemplo com atleta ainda não cadastrado:

```
curl -s -X POST -d "competition_id=1&athlete=Usain Bolt&value=9.58" http://localhost:3000/results | jq
```

Retorno:

```
{
  "id": 22,
  "value": 9.58,
  "athlete_name": "Usain Bolt",
  "competition_name": "100m final"
}

```
Exemplo com competição ainda não cadastrada:

```
curl -s -X POST -d "competition=400m com barreiras&unit=m&athlete_id=3&value=52" http://localhost:3000/results | jq
```

Retorno:

```
{
  "id": 23,
  "value": 52,
  "athlete_name": "Cassie Emard",
  "competition_name": "400m com barreiras"
}
```

Exemplo com atleta e competição ainda não cadastrados:

```
curl -s -X POST -d "competition=Lançamento de martelo&unit=m&max_number_of_attempts =3&athlete=Betty Heidler&value=77" http://localhost:3000/results | jq
```

Retorno:

```
{
  "id": 24,
  "value": 77,
  "athlete_name": "Betty Heidler",
  "competition_name": "Lançamento de martelo"
}
```
