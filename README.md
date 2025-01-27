# Proyecto Final: Karate Framework API Testing

## Descripción

Este proyecto final tiene como objetivo demostrar los conocimientos adquiridos durante el curso de Automatización de Pruebas Módulo 2, específicamente sobre la automatización de pruebas de APIs utilizando el framework **Karate**.

Se han diseñado y ejecutado pruebas para la **API RestfulBooker**. El conjunto de pruebas incluye acciones como la creación, obtención, modificación y eliminación de reservas, así como la autenticación.

## Detalles de la API

- **Base URL:** [https://restful-booker.herokuapp.com](https://restful-booker.herokuapp.com)
- **API:** RestfulBooker

## Estructura del Proyecto

```bash
src/
├── test/
│   └── java/
│       └── bookings/
│           ├── auth/
│           │   ├── AuthentificationBookingRunner.java
│           │   └── authentification.feature
│           ├── createBookings/
│           │   ├── CreateRequestBookingRunner.java
│           │   └── createRequestBooking.feature
│           ├── deleteBookings/
│           │   ├── DeleteBookingsRunner.java
│           │   └── deleteBookings.feature
│           ├── getBookings/
│           │   ├── GetAllBookingsRunner.java
│           │   └── getAllBookings.feature
│           ├── tools/
│           │   ├── GenerateTestDataRunner.java
│           │   ├── dataGenerator.feature
│           │   └── fakerDataGenerator.feature
│           └── updateBookings/
│               ├── ModifyBookingRunner.java
│               └── modifyBooking.feature
│   ├── RunnerParallelTest.java
│   ├── karate-config.js
│   ├── logback-test.xml
├── .gitignore
├── README.md
└── pom.xml
```
## Funcionalidades Implementadas

### 1. Autenticación de Reservas
- **AuthentificationBookingRunner.java**: Ejecuta las pruebas relacionadas con la autenticación para la API.
- **authentification.feature**: Define las pruebas para autenticar usuarios.

### 2. Creación de Reservas
- **CreateRequestBookingRunner.java**: Ejecuta las pruebas para crear nuevas reservas.
- **createRequestBooking.feature**: Define las pruebas para la creación de reservas.

### 3. Eliminación de Reservas
- **DeleteBookingsRunner.java**: Ejecuta las pruebas para eliminar reservas existentes.
- **deleteBookings.feature**: Define las pruebas para la eliminación de reservas.

### 4. Obtención de Reservas
- **GetAllBookingsRunner.java**: Ejecuta las pruebas para obtener las reservas existentes.
- **getAllBookings.feature**: Define las pruebas para obtener todas las reservas.

### 5. Generación de Datos de Prueba
- **GenerateTestDataRunner.java**: Ejecuta las pruebas para generar datos de prueba.
- **dataGenerator.feature**: Define las pruebas para generar datos aleatorios.
- **fakerDataGenerator.feature**: Utiliza Faker para generar datos aleatorios.

### 6. Modificación de Reservas
- **ModifyBookingRunner.java**: Ejecuta las pruebas para modificar una reserva existente.
- **modifyBooking.feature**: Define las pruebas para modificar reservas.

### 7. Ejecución Paralela de Pruebas
- **RunnerParallelTest.java**: Configura la ejecución paralela de las pruebas.

### Ejecución de las Pruebas:
- Todas las pruebas se pueden ejecutar a través del runner `RunnerParallelTest.java`, en la consola a utilizando la línea de comando `mvn clean test`.
