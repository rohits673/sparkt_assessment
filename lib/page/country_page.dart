import 'package:sparkt_assessment/model/country.dart';
import 'package:sparkt_assessment/provider/country_provider.dart';
import 'package:sparkt_assessment/widget/country_listtile_widget.dart';
import 'package:sparkt_assessment/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryPage extends StatefulWidget {
  final List<Country> countries;

  const CountryPage({Key? key, this.countries = const []}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String text = '';
  List<Country> selectedCountries = [];

  @override
  void initState() {
    super.initState();
    selectedCountries = widget.countries;
  }

  bool containsSearchText(Country country) {
    final name = country.name;
    final textLower = text.toLowerCase();
    final countryLower = name.toLowerCase();

    return countryLower.contains(textLower);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context);
    final countries = provider.countries.where(containsSearchText).toList();

    Future refreshData() async {
      provider.setCountries([]);
      setState(() {
        provider.loadCountries().then((countries) {
          provider.setCountries(countries);
        });
      });
    }

    return Scaffold(
      appBar: buildAppBar() as PreferredSizeWidget,
      body: Column(
        children: <Widget>[
          Expanded(
              child: countries.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: refreshData,
                      child: ListView.builder(
                          itemCount: countries.length,
                          itemBuilder: (BuildContext context, int index) {
                            final isSelected =
                                selectedCountries.contains(countries[index]);
                            String tag = "";
                            if (index < countries.length) {
                              if (!(index < 1) &&
                                  countries[index - 1].name[0] ==
                                      countries[index].name[0]) {
                                tag = "";
                              } else {
                                tag = countries[index].name[0];
                              }
                            }

                            return Column(children: [
                              (!(index < 1) &&
                                      countries[index - 1].name[0] ==
                                          countries[index].name[0])
                                  ? Container()
                                  : Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 20, 0, 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        tag,
                                        style: const TextStyle(fontSize: 25),
                                      )),
                              CountryListTileWidget(
                                country: countries[index],
                                isSelected: isSelected,
                                onSelectedCountry: selectCountry,
                              ),
                            ]);
                          }))
                  : Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator())),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    const label = 'Country';
    return AppBar(
      title: const Text('Select $label'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SearchWidget(
          text: text,
          onChanged: (text) => setState(() => this.text = text),
          hintText: 'Search $label',
        ),
      ),
    );
  }

  void selectCountry(Country country) {
    Navigator.pop(context, country);
  }
}
