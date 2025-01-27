@ignore
Feature: Generar un token

Yo Como usuario del sistema
Quiero generar un token valido
Para acceder a los recursos protegidos

  Background:
    * url url_Booking
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

    * def admin =
    """
    {
      "username" : "admin",
      "password" : "password123"
    }
    """

  @CreateTokenBooking
  Scenario: Crear un nuevo token
    Given path 'auth'
    And request admin
    When method POST
    Then status 200
    And response.token == '#string'
    * def token = "token=" + response.token

