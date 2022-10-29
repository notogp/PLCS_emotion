class User {
  //fields
  final int id;
  final String name;
  final String surname;
  final String user_type;
  final String usr;
  final String pwd;
  final String card_id;

  //constructor
  const User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.user_type,
      required this.usr,
      required this.pwd,
      required this.card_id});

  //fromJson() method where we get later our
  //json inside the http response and we want
  //to convert it to User data
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        user_type: json["user_type"],
        usr: json["usr"],
        pwd: json["pwd"],
        card_id: json["card_id"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'user_type': user_type,
        'usr': usr,
        'pwd': pwd,
        'card_id': card_id,
      };
}

class Customer {
  //fields
  final int id;
  final String name;
  final String website;

  //constructor
  const Customer({required this.id, required this.name, required this.website});

  //fromJson() method where we get later our
  //json inside the http response and we want
  //to convert it to User data
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["website_name"],
        website: json["website_address"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'website_name': name,
        'website_address': website,
      };
}

class Item {
  //fields
  final int id;
  final String bike_id;
  final String card_id;
  final String category;
  final String description;

  //constructor
  const Item(
      {required this.id,
      required this.bike_id,
      required this.card_id,
      required this.category,
      required this.description});

  //fromJson() method where we get later our
  //json inside the http response and we want
  //to convert it to User data
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        bike_id: json["bike_id"],
        card_id: json["card_id"],
        category: json["category"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'bike_id': bike_id,
        'card_id': card_id,
        'category': category,
        'description': description,
      };
}
