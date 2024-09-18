// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final int? id;
  final String cep;
  final String address;
  final String? number;
  final String? complement;
  final double latitude;
  final double longitude;

  const AddressModel({
    this.id,
    required this.cep,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.number,
    this.complement,
  });

  AddressModel copyWith({
    int? id,
    String? cep,
    String? address,
    String? number,
    String? complement,
    double? latitude,
    double? longitude,
  }) {
    return AddressModel(
      id: id ?? this.id,
      cep: cep ?? this.cep,
      address: address ?? this.address,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cep': cep,
      'address': address,
      'number': number,
      'complement': complement,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int?,
      cep: map['cep'] as String,
      address: map['address'] as String,
      number: map['number'] != null ? map['number'] as String : null,
      complement: map['complement'] != null ? map['complement'] as String : null,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      cep,
      address,
      number,
      complement,
      latitude,
      longitude,
    ];
  }
}
