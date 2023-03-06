import 'package:equatable/equatable.dart';

class PaginationInfoEntity extends Equatable {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  const PaginationInfoEntity({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  @override
  List<Object> get props => [count, pages];
}
