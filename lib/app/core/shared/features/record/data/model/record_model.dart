// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';

class RecordModel extends Equatable {
  final int id;
  final bool favorited;
  final AddressModel address;

  const RecordModel({
    required this.id,
    required this.favorited,
    required this.address,
  });

  RecordModel copyWith({
    int? id,
    bool? favorited,
    AddressModel? address,
  }) {
    return RecordModel(
      id: id ?? this.id,
      favorited: favorited ?? this.favorited,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'favorited': favorited ? 1 : 0,
      'address': address.toMap(),
    };
  }

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    return RecordModel(
      id: map['id'] as int,
      favorited: map['favorited'] == 1,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecordModel.fromJson(String source) => RecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, favorited, address];
}
