import 'package:equatable/equatable.dart';

import 'pagination_info_entity.dart';

class ListResponse<T> extends Equatable {
  final List<T> listData;
  final PaginationInfoEntity paginationInfoEntity;

  const ListResponse(this.listData, this.paginationInfoEntity);

  @override
  List<Object> get props => [listData, paginationInfoEntity];
}
