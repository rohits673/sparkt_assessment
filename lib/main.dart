import 'package:sparkt_assessment/model/country.dart';
import 'package:sparkt_assessment/model/user.dart';
import 'package:sparkt_assessment/page/country_page.dart';
import 'package:sparkt_assessment/page/user_page.dart';
import 'package:sparkt_assessment/provider/country_provider.dart';
import 'package:sparkt_assessment/provider/user_provider.dart';
import 'package:sparkt_assessment/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Select Users';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider<CountryProvider>(
            create: (_) => CountryProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: Colors.blueAccent,
          ),
          home: const MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user;
    Country? country;

    Widget buildUserDropdown(UserProvider data) {
      onTap() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserPage()),
        );
      }

      user = data.selectedUser;
      return buildDropDownPicker(
        title: "Select User",
        child: user == null
            ? buildListTile(title: "select user ", onTap: onTap)
            : buildListTile(
                title: user!.firstName,
                leading: AvatarWidget(imageUrl: user!.avatar),
                onTap: onTap,
              ),
      );
    }

    Widget buildCountryDropdown(CountryProvider data) {
      onTap() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CountryPage()),
        );
      }

      country = data.selectedCountry;
      return buildDropDownPicker(
        title: 'Select Country',
        child: country == null
            ? buildListTile(title: "select country", onTap: onTap)
            : buildListTile(
                title: country!.name,
                leading: AvatarWidget(imageUrl: country!.flag),
                onTap: onTap,
              ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserProvider>(
              builder: (context, data, child) => buildUserDropdown(data),
            ),
            const SizedBox(height: 24),
            Consumer<CountryProvider>(
              builder: (context, data, child) => buildCountryDropdown(data),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildListTile({
  required String title,
  required VoidCallback onTap,
  Widget? leading,
}) {
  return ListTile(
    onTap: onTap,
    leading: leading,
    title: Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: Colors.black, fontSize: 18),
    ),
    trailing: const Icon(Icons.arrow_drop_down, color: Colors.black),
  );
}

Widget buildDropDownPicker({
  required String title,
  required Widget child,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(margin: EdgeInsets.zero, child: child),
      ],
    );
