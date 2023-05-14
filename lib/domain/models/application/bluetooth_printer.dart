// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';

class BluetoothPrinter {
  int? id;
  String? deviceName;
  String? address;
  String? port;
  String? vendorId;
  String? productId;
  bool? isBle;
  PrinterType typePrinter;
  bool? state;

  BluetoothPrinter({
    this.id,
    this.deviceName,
    this.address,
    this.port,
    this.state,
    this.vendorId,
    this.productId,
    this.typePrinter = PrinterType.bluetooth,
    this.isBle = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deviceName': deviceName,
      'address': address,
      'port': port,
      'vendorId': vendorId,
      'productId': productId,
      'isBle': isBle,
      'typePrinter': typePrinter.index,
      'state': state,
    };
  }

  factory BluetoothPrinter.fromMap(Map<String, dynamic> map) {
    return BluetoothPrinter(
      id: map['id'] != null ? map['id'] as int : null,
      deviceName: map['deviceName'] != null ? map['deviceName'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      port: map['port'] != null ? map['port'] as String : null,
      vendorId: map['vendorId'] != null ? map['vendorId'] as String : null,
      productId: map['productId'] != null ? map['productId'] as String : null,
      isBle: map['isBle'] != null ? map['isBle'] as bool : null,
      typePrinter: PrinterType.values[map['typePrinter'] as int],
      state: map['state'] != null ? map['state'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BluetoothPrinter.fromJson(String source) =>
      BluetoothPrinter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BluetoothPrinter(id: $id, deviceName: $deviceName, address: $address, port: $port, vendorId: $vendorId, productId: $productId, isBle: $isBle, typePrinter: $typePrinter, state: $state)';
  }

  @override
  bool operator ==(covariant BluetoothPrinter other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.deviceName == deviceName &&
        other.address == address &&
        other.port == port &&
        other.vendorId == vendorId &&
        other.productId == productId &&
        other.isBle == isBle &&
        other.typePrinter == typePrinter &&
        other.state == state;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deviceName.hashCode ^
        address.hashCode ^
        port.hashCode ^
        vendorId.hashCode ^
        productId.hashCode ^
        isBle.hashCode ^
        typePrinter.hashCode ^
        state.hashCode;
  }
}
