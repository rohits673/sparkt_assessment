import 'package:sparkt_assessment/model/country.dart';
import 'package:sparkt_assessment/model/user.dart';

class UserUtils {
  static int ascendingSort(User c1, User c2) =>
      c1.firstName.compareTo(c2.firstName);
}

class CountryUtils {
  static int ascendingSort(Country c1, Country c2) =>
      c1.name.compareTo(c2.name);
}
