import 'dart:convert';

class PrinterDeviceModel {
  String? tipoImpressora;
  String? name;
  String? address;

  PrinterDeviceModel({
    this.tipoImpressora,
    this.name,
    this.address,
  });

  PrinterDeviceModel copyWith({
    String? tipoImpressora,
    String? name,
    String? address,
  }) {
    return PrinterDeviceModel(
      tipoImpressora: tipoImpressora ?? this.tipoImpressora,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (tipoImpressora != null) {
      result.addAll({'tipoImpressora': tipoImpressora});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (address != null) {
      result.addAll({'address': address});
    }

    return result;
  }

  factory PrinterDeviceModel.fromMap(Map<String, dynamic> map) {
    return PrinterDeviceModel(
      tipoImpressora: map['tipoImpressora'],
      name: map['name'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrinterDeviceModel.fromJson(String source) => PrinterDeviceModel.fromMap(json.decode(source));

  @override
  String toString() => 'PrinterDeviceModel(name: $name, address: $address)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrinterDeviceModel && other.name == name && other.address == address;
  }

  @override
  int get hashCode => name.hashCode ^ address.hashCode;
}
