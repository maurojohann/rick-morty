import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

class CharacterModels extends Equatable {
  final int id;
  final String name;
  final String species;
  final String image;

  const CharacterModels(
    this.id,
    this.name,
    this.species,
    this.image,
  );

  CharacterModels copyWith({
    int? id,
    String? name,
    String? species,
    String? image,
  }) {
    return CharacterModels(
      id ?? this.id,
      name ?? this.name,
      species ?? this.species,
      image ?? this.image,
    );
  }

  factory CharacterModels.fromMap(Map<String, dynamic> map) {
    return CharacterModels(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['species'] ?? '',
      map['image'] ?? '',
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(id, name, species, image);
  }

  factory CharacterModels.fromJson(String source) => CharacterModels.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CharacterModels(id: $id, name: $name, species: $species, image: $image)';
  }

  @override
  List<Object> get props => [id, name, species, image];
}
