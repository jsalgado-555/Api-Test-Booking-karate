package bookings.auth;

import com.intuit.karate.junit5.Karate;

public class AuthentificationBookingRunner {

    @Karate.Test
    Karate AuthentificationBooking() {

        return Karate.run().relativeTo(getClass()).tags("~@ignore");

    }
}

