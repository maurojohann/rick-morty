abstract class  UseCase<Param, Output> {
  Future<Output> call([Param param]);
}
