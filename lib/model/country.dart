class Country {
  final String name;
  final String flag;

  Country({required this.name, required this.flag});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name']['common'],
        flag: json['flags']['png'],
      );
}
