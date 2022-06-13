import 'dart:convert';

import 'package:flutter/material.dart';

import 'app/form/enums/input_type.dart';
import 'app/form/interfaces/form.dart';
import 'app/form/models/form_item.dart';

class Place {
  int? id;
  String? name;

  Place({
    this.id,
    this.name,
  });

  @override
  String toString() => '$name';
}

class DeliveryModel implements FormInterface {
  String? recipient;
  String? address;
  Place? place;
  String? phone;
  DateTime? day;
  TimeOfDay? hour;

  DeliveryModel({
    this.recipient,
    this.address,
    this.place,
    this.phone,
    this.day,
    this.hour,
  });

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    final model = DeliveryModel();
    if (map['recipient'] != null) model.recipient = map['recipient'];
    if (map['address'] != null) model.address = map['address'];
    if (map['place'] != null) model.place = map['place'];
    if (map['phone'] != null) model.phone = map['phone'];
    if (map['day'] != null) model.day = map['day'];
    if (map['hour'] != null) model.hour = map['hour'];
    return model;
  }

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source));

  @override
  List<FormItem> toForm() {
    return [
      FormItem(
        label: 'Destinatário',
        key: 'recipient',
        value: recipient,
        type: InputType.text,
      ),
      FormItem(
        label: 'Endereço',
        key: 'address',
        value: address,
        type: InputType.textArea,
      ),
      FormItem(
        label: 'Local',
        key: 'place',
        value: [
          Place(id: 1, name: 'Paracatu'),
          Place(id: 2, name: 'Brasília'),
          Place(id: 3, name: 'Unaí'),
        ],
        type: InputType.multiSelection,
        items: [
          Place(id: 1, name: 'Paracatu'),
          Place(id: 2, name: 'Brasília'),
          Place(id: 3, name: 'Unaí'),
        ],
      ),
      FormItem(
        label: 'Telefone',
        key: 'phone',
        value: phone,
        type: InputType.text,
      ),
      FormItem(
        label: 'Data da entrega',
        key: 'day',
        value: day,
        type: InputType.date,
      ),
      FormItem(
        label: 'Horário',
        key: 'hour',
        value: hour,
        type: InputType.time,
      ),
    ];
  }
}
