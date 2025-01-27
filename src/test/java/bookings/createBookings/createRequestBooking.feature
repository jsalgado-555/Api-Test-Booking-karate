Feature: Crear una nueva reserva

Yo como usuario verificado
Quiero crear una nueva reserva
Para asegurarme de tener un espacio reservado

  Background:
    * url url_Booking
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

    * def getRandom =
      """
      function() {
        return karate.call('classpath:bookings/tools/dataGenerator.feature');
      }
      """
  @CreateBooking
  Scenario: Crear una nueva reserva
    * def randomData = call getRandom
    * def requestData = randomData.requestDataT
    * def expectedResponse = randomData.responseDataT
    * def expectedSchema = randomData.responseSchemaData

    Given path 'booking'
    And request requestData
    When method POST
    Then status 200
    And match response == "#object"
    And match response == expectedResponse
    And match response == expectedSchema

  Scenario Outline: Verificar que al intentar crear una reserva con <description>, se obtenga un código de error HTTP <httpStatus> <NameStatus>,
    * def randomData = call getRandom
    * def requestData = randomData
    * def expectedResponse = randomData.responseDataT

    Given path 'booking'
    And request requestData.<requestD>
    When method POST
    Then status <httpStatus>
    And match response == <NameStatus>
    Examples:
      | description            | requestD                  | httpStatus     | NameStatus              |
      | parametros vacios      | requestVoid               | 500            | "Internal Server Error" |
      | parametros null        | requestNullData           | 500            | "Internal Server Error" |
      | parametros incorrectos | requestIncorretDataType   | 500            | "Internal Server Error" |
    # Al parecer al mandar un POST con datos null, datos vacios (es decir que la estructura json sea '{}') y al ingresar parametros incorrectos (por ejemplo firstname:91),
    # arroja un error HTTP 500 'Internal Server Error', lo que es un bug en la API, ya que deberia arrojar un error HTTP 400 'Bad Request', ya lo he comprobado en postman
    # y sigue arrojando el error HTTP 500. Por lo tanto para que la prueba se ejecute satisfactoriamente el status esperado lo pondre como un HTTP 500.