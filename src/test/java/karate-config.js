function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    url_Booking: 'https://restful-booker.herokuapp.com'
  }
 /* if (env == 'dev') {
    config.url_Booking = 'https://restful-booker-dev.herokuapp.com'
  } else if (env == 'qa') {
    config.url_Booking = 'https://restful-booker.herokuapp.com'
   }*/
  return config;
}