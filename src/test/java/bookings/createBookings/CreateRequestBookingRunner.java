package bookings.createBookings;

import com.intuit.karate.junit5.Karate;

public class CreateRequestBookingRunner {

        @Karate.Test
        Karate CreateRequestBooking() {

            return Karate.run("classpath:bookings/createBookings/createRequestBooking.feature");

        }
}
