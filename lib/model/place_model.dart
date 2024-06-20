class _Geo {
  final double lat;
  final double lng;

  _Geo({
    required this.lat,
    required this.lng,
  });

  factory _Geo.fromJson(Map<String, dynamic> json) {
    return _Geo(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

// Model for _AddressJson
class _AddressJson {
  final _Geo geo;
  final String country;
  final String state;
  final String city;
  final String postalCode;
  final String street;
  final String streetNumber;
  final String formattedAddress;
  final String placeId;

  _AddressJson({
    required this.geo,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.street,
    required this.streetNumber,
    required this.formattedAddress,
    required this.placeId,
  });

  static List<Map<String, dynamic>> _getKeyValuePairs(
      List<dynamic> addressComponents) {
    List<Map<String, dynamic>> keyValuePairs = [];

    for (Map<String, dynamic> component in addressComponents) {
      String key = component['types'].first;
      if (!keyValuePairs.any((e) => e.containsKey(key))) {
        String value = component['long_name'];
        keyValuePairs.add({key: value});
      }
    }
    return keyValuePairs;
  }

  factory _AddressJson.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> _components =
    _getKeyValuePairs(json['address_components']);
    _Geo _geo = _Geo.fromJson(json['geometry']['location']);
    String? _country;
    String? _state;
    String? _city;
    String? _postalCode;
    String? _street;
    String? _streetNumber;
    String? _formattedAddress = json['formatted_address'];
    String? _placeId = json['place_id'];
    if (_components.any((c) => c.containsKey('country'))) {
      _country = _components.firstWhere((c) => c.containsKey('country'))['country'];
    }
    if (_components.any((c) => c.containsKey('administrative_area_level_1'))) {
      _state = _components.firstWhere((c) => c.containsKey('administrative_area_level_1'))['administrative_area_level_1'];
    }
    if (_components.any((c) => c.containsKey('locality'))) {
      _city = _components.firstWhere((c) => c.containsKey('locality'))['locality'];
    }
    if (_components.any((c) => c.containsKey('postal_code'))) {
      _postalCode = _components.firstWhere((c) => c.containsKey('postal_code'))['postal_code'];
    }
    if (_components.any((c) => c.containsKey('route'))) {
      _street = _components.firstWhere((c) => c.containsKey('route'))['route'];
    }
    if (_components.any((c) => c.containsKey('street_number'))) {
      _streetNumber = _components.firstWhere((c) => c.containsKey('street_number'))['street_number'];
    }
    return _AddressJson(
      geo: _geo,
      country: _country ?? '',
      state: _state ?? '',
      city: _city ?? '',
      postalCode: _postalCode ?? '',
      street: _street ?? '',
      streetNumber: _streetNumber ?? '',
      formattedAddress: _formattedAddress ?? '',
      placeId: _placeId ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geo': geo.toJson(),
      'country': country,
      'state': state,
      'city': city,
      'postal_code': postalCode,
      'street': street,
      'street_number': streetNumber,
      'formatted_address': formattedAddress,
      'place_id': placeId,
    };
  }
}

// Model for Place
class Place {
  final _AddressJson addressJson;
  final String placeId;

  Place({
    required this.addressJson,
    required this.placeId,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      addressJson: _AddressJson.fromJson(json),
      placeId: json['place_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_json': addressJson.toJson(),
      'place_id': placeId,
    };
  }
}
