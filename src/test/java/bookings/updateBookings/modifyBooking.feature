Feature: Feature: Actualizar una reserva existente

Yo como usuario verificado
Quiero actualizar los detalles de una reserva por su ID
Para corregir o modificar la informacion de la misma

  Background:
    * url url_Booking
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * def createToken = call read('classpath:bookings/auth/authentification.feature')
    * header Cookie = createToken.token

    * def createBookings =
      """
      function() {
        return karate.call('classpath:bookings/createBookings/createRequestBooking.feature@CreateBooking');
      }
      """

    * def getRandom =
      """
      function() {
        return karate.call('classpath:bookings/tools/dataGenerator.feature');
      }
      """

  Scenario: Actualizar una reserva exitosamente por ID
    * def createBooking = call createBookings
    * def randomData = call getRandom
    * def bookingId = createBooking.response.bookingid
    * def requestData = randomData.requestDataT
    * def expectedResponse = requestData
    * def expectedSchema = randomData.responseSchemaData.booking

    Given path 'booking/' + bookingId
    And request requestData
    When method PUT
    Then status 200
    And match response == "#object"
    And match response == expectedResponse
    And match response == expectedSchema

  Scenario Outline: Verificar que al intentar actualizar una reserva con ID que tiene <description>, se obtenga un código de error HTTP <httpStatus> <typeStatus>
    * def randomData = call getRandom
    * def requestData = randomData.requestDataT
    Given path 'booking/' + <invalidId>
    And request requestData
    When method PUT
    Then status <httpStatus>
    And match response == <typeStatus>
    Examples:
      | description           | invalidId | httpStatus     | typeStatus           |
      | caracteres especiales | "$%&?&"   | 405            | "Method Not Allowed" |
      | numeros negativos     | -5718     | 405            | "Method Not Allowed" |
  # Tuve que usar el error HTTP 405 como status esperado y hacer una asercion, es el que arroja el servidor cuando uso un id invalido en el caso de un DELETE o un PUT,
  # parece ser un error en la API, ya lo he comprobado en postman.

  Scenario Outline: Verificar que al intentar actualizar una reserva con <description>, se obtenga un código de error HTTP <httpStatus> <typeStatus>,
    * def createBooking = call createBookings
    * def randomData = call getRandom
    * def bookingId = createBooking.response.bookingid
    * def requestData = randomData

    Given path 'booking/' + bookingId
    And request requestData.<requestD>
    When method PUT
    Then status <httpStatus>
    And match response != "#object"
    Examples:
      | description          | requestD          | httpStatus     | typeStatus    |
      | parametros vacios    | requestVoid       | 400            | "Bad Request" |
      | parametros null      | requestNullData   | 400            | "Bad Request" |