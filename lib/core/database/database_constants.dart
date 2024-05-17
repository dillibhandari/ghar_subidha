class UserTable {
  static const userTableName = "user";
  static const id = "user_id";
  static const fullname = "full name";
  static const email = "email";
  static const address = "address";
  static const password = "password";
}

class Facilities {
  static const facilityTableName = "facilities";
  static const id = "fac_id";
  static const title = "fac_title";
  static const image = "fac_image";
  static const cost = "cost";
  static const availableLocation = "location";
}

class Booking {
  static const bookingTableName = "booking";
  static const id = "booking_id";
  static const facId = "fac_id";
  static const userId = "user_id";
  static const time = "time";
}
