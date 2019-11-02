import 'package:flutter/material.dart';

final Map<String, IconData> icons = {
  "Gas": Icons.local_gas_station,
  "Food": Icons.restaurant,
  "Shopping": Icons.local_offer,
  "Grocceries": Icons.local_grocery_store,
  "Transportation": Icons.train,
  "Entertainment": Icons.local_movies,
  "Recurring": Icons.receipt,
  "Misc.": Icons.credit_card,
  "Gift Card": Icons.card_giftcard,
  "Pets": Icons.pets,
  "Print": Icons.print,
  "Shopping": Icons.shopping_cart,
  "Basket": Icons.shopping_basket,
  "Store": Icons.store,
  "Work": Icons.work,
  "Movie": Icons.movie,
  "Call": Icons.call,
  "Phone": Icons.stay_current_portrait,
  "Pencil": Icons.create,
  "Airplane": Icons.airplanemode_active,
  "Cloud": Icons.cloud,
  "Headset": Icons.headset,
  "Laptop": Icons.laptop,
  "Mouse": Icons.mouse,
  "Iphone": Icons.phone_iphone,
  "Android": Icons.phone_android,
  "Sim": Icons.sim_card,
  "Speaker": Icons.speaker,
  "Watch": Icons.watch,
  "Videogame": Icons.videogame_asset,
  "Router": Icons.router,
  "Tab;et": Icons.tablet_mac,
  "Camera Roll": Icons.camera_roll,
  "Camera": Icons.camera_alt,
  "Euro": Icons.euro_symbol,
  "Music": Icons.music_note,
  "Bicycle": Icons.directions_bike,
  "Fast Food": Icons.fastfood,
  "EV": Icons.ev_station,
  "Boat": Icons.directions_boat,
  "Bus": Icons.directions_bus,
  "Subway": Icons.directions_subway,
  "Hotel": Icons.hotel,
  "Dining": Icons.local_dining,
  "Cafe": Icons.local_cafe,
  "Bar": Icons.local_bar,
  "Car": Icons.directions_car,
  "Pizza": Icons.local_pizza,
  "Pharmacy": Icons.local_pharmacy,
  "Parking": Icons.local_parking,
  "Taxi": Icons.local_taxi,
  "Beach": Icons.beach_access,
  "Shuttle": Icons.airport_shuttle,
  "Casino": Icons.casino,
  "Pool": Icons.pool,
  "Fitness": Icons.fitness_center,
  "Baby": Icons.child_care,
  "Stroller": Icons.child_friendly,
  "Smoking": Icons.smoking_rooms,
  "Cake": Icons.cake,
  "Spa": Icons.spa
};

List<Map<String, dynamic>> getIconMapAsList() {
  List<Map<String, dynamic>> iconMapAsList = [];
  icons.forEach((key, value) {
    iconMapAsList.add({"name": key, "icon": value});
  });

  return iconMapAsList;
}
