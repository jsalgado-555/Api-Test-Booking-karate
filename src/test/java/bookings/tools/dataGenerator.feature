@ignore
Feature: Plantilla para generar la data

  Background:
    * def fakerData = call read('classpath:bookings/tools/fakerDataGenerator.feature')
    * def bookingData = fakerData.data

    * def requestTemplate =
      """
      function(data){
        return {
          "firstname": data.firstname,
          "lastname": data.lastname,
          "totalprice": data.totalprice,
          "depositpaid": data.depositpaid,
          "bookingdates": {
            "checkin": data.checkin,
            "checkout": data.checkout
          },
          additionalneeds: data.additionalneeds
        }
      }
      """

    * def responseTemplate =
      """
      function(data){
        return {
          bookingid: data.typeOfValue.number,
          booking: requestTemplate(data)
        }
      }
      """

    * def responseSchema =
      """
      function(data){
        return {
          "bookingid": data.typeOfValue.number,
          "booking": {
            "firstname": data.typeOfValue.string,
            "lastname": data.typeOfValue.string,
            "totalprice": data.typeOfValue.number,
            "depositpaid": data.typeOfValue.boolean,
            "bookingdates": {
              "checkin": data.typeOfValue.string,
              "checkout": data.typeOfValue.string
            },
            additionalneeds: data.typeOfValue.string
          }
        }
      }
      """

    * def requestNull =
      """
      function(data){
        return {
          "firstname": data.nullData,
          "lastname": data.nullData,
          "totalprice": data.nullData,
          "depositpaid": data.depositpaid,
          "bookingdates": {
            "checkin": data.nullData,
            "checkout": data.nullData
          },
          additionalneeds: data.nullData
        }
      }
      """

    * def requestIncorrect =
    """
    function(data){
      return {
        "firstname": data.totalprice,
        "lastname": data.lastname,
        "totalprice": data.firstname,
        "depositpaid": data.depositpaid,
        "bookingdates": {
          "checkin": data.checkin,
          "checkout": data.checkout
        },
        additionalneeds: data.additionalneeds
      }
    }
    """

    * def requestDataT = requestTemplate(bookingData)
    * def responseDataT = responseTemplate(bookingData)
    * def responseSchemaData = responseSchema(bookingData)
    * def requestVoid = {}
    * def requestNullData = requestNull(bookingData)
    * def requestIncorretDataType = requestIncorrect(bookingData)

  Scenario: Verificar que tanto la response como la request contienen el atributo depositpaid como boolean
    * match requestTemplate(bookingData).depositpaid == "#boolean"
    * match responseTemplate(bookingData).booking.depositpaid == "#boolean"
    * match requestNull(bookingData).depositpaid == "#boolean"
    * match requestIncorrect(bookingData).depositpaid == "#boolean"