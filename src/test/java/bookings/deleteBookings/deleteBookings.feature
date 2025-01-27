Feature: Eliminar una reserva

Yo como usuario verificado
Quiero eliminar una reserva por su ID
Para cancelar una reserva que ya no necesito

  Background:
    * url url_Booking
    * def createToken = call read('classpath:bookings/auth/authentification.feature')
    * header Cookie = createToken.token

    * def createBookings =
      """
      function() {
        return karate.call('classpath:bookings/createBookings/createRequestBooking.feature@CreateBooking');
      }
      """

  Scenario: Eliminar una reserva por ID exitosamente
    * def createBooking = call createBookings
    * def bookingId = createBooking.response.bookingid

    Given path 'booking/' + bookingId
    When method DELETE
    Then status 201
    And print response
    And match response == "Created"
    # Lo ideal seria que el codigo HTTP fuese un 204 'Not Content'

  Scenario Outline: Verificar que al intentar eliminar una reserva con ID que tiene <description>, se obtenga un código de error HTTP <httpStatus> <typeStatus>
    Given path 'booking/' + <invalidId>
    When method DELETE
    Then status <httpStatus>
    And match response == <typeStatus>
    Examples:
      | description           | invalidId | httpStatus     | typeStatus           |
      | caracteres especiales | "$%&?&"   | 405            | "Method Not Allowed" |
      | numeros negativos     | -5718     | 405            | "Method Not Allowed" |
    # Tuve que usar el error HTTP 405 como status esperado, es el que arroja el servidor cuando uso un id invalido en el caso de un DELETE o un PUT,
    # parece ser un error en la API, ya lo he comprobado en postman.
