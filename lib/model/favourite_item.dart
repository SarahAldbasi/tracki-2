// class FavoriteItem {
//   final String name; // Truck's name
//   final String logoPath; // Path to the truck's logo image
//   final int rating; // Truck's rating out of 5 stars

//   // Constructor for initializing the fields
//   FavoriteItem({
//     required this.name,
//     required this.logoPath,
//     required this.rating,
//   });

//   // Optional: Method to convert the object to a map (e.g., for saving to Firebase)
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'logoPath': logoPath,
//       'rating': rating,
//     };
//   }

//   // Optional: Method to create an object from a map (e.g., for fetching from Firebase)
//   factory FavoriteItem.fromMap(Map<String, dynamic> map) {
//     return FavoriteItem(
//       name: map['name'],
//       logoPath: map['logoPath'],
//       rating: map['rating'],
//     );
//   }
// }
