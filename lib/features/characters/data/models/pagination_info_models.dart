import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/entities.dart';

class PaginationInfoModels extends Equatable {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const PaginationInfoModels(this.count, this.pages, this.next, this.prev);

  factory PaginationInfoModels.fromMap(Map<String, dynamic> map) {
    return PaginationInfoModels(
      map['count']?.toInt() ?? 0,
      map['pages']?.toInt() ?? 0,
      map['next'],
      map['prev'],
    );
  }

  PaginationInfoEntity toEntity() {
    return PaginationInfoEntity(
      count: count,
      pages: pages,
      next: next,
      prev: prev,
    );
  }

  factory PaginationInfoModels.fromJson(String source) => PaginationInfoModels.fromMap(
        json.decode(source),
      );

  @override
  String toString() {
    return 'ListResponseModels(count: $count, pages: $pages, next: $next, prev: $prev)';
  }

  @override
  List<Object> get props => [count, pages];
}
