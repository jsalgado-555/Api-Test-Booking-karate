Feature: Consultar las reservas existentes

Yo como usuario verificado
Quiero obtener la lista de reservas
Para revisar los detalles de las reservas activas

  Background:
    * url url_Booking

    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

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

  Scenario: Buscar todas las reservas correctamente
    Given path 'booking'
    When method GET
    Then status 200
    And match response[0].bookingid == '#number'
    And match response[0].bookingid == '#notnull'
    #And print response

  Scenario: Obtener una Reserva por id
    * def createBooking = call createBookings
    * def randomData = call getRandom
    * def bookingId = createBooking.response.bookingid
    * def requestData = randomData.requestDataT
    * def expectedResponse = createBooking.response.booking
    * def expectedSchema = randomData.responseSchemaData.booking

    Given path 'booking/' + bookingId
    When method GET
    Then status 200
    And match response == expectedResponse
    And match response == expectedSchema

  Scenario Outline: Verificar que al intentar buscar una reserva por ID que tiene <description>, se obtenga un código de error HTTP <httpStatus> <typeStatus>
    Given path 'booking/' + <invalidId>
    When method GET
    Then status <httpStatus>
    Examples:
      | description           | invalidId | httpStatus     | typeStatus    |
      | caracteres especiales | "$%&?&"   | 404            | "Not Found" |
      | numeros negativos     | -5718     | 404            | "Not Found" |