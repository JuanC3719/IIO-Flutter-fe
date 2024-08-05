/// Represents a place with essential details such as name, address, open status, and unique identifier.
class Place {
  // The name of the place (e.g., restaurant name)
  final String name;

  // The address of the place
  final String address;

  // A boolean indicating if the place is currently open
  final bool isOpen;

  // A unique identifier for the place
  final String placeId;

  /// Constructs a [Place] instance with the provided parameters.
  Place({
    required this.name,
    required this.address,
    required this.isOpen,
    required this.placeId,
  });

  /// Creates a [Place] instance from a JSON object.
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      // Extract the name from the JSON object, default to 'Unknown' if not present
      name: json['name'] ?? 'Unknown',
      
      // Extract the address from the JSON object, default to 'Unknown' if not present
      address: json['vicinity'] ?? 'Unknown',
      
      // Extract the open status from the JSON object, default to true if not present
      isOpen: json['isOpen'] ?? true,
      
      // Extract the place ID from the JSON object, default to 'Unknown' if not present
      placeId: json['place_id'] ?? 'Unknown',
    );
  }
}
