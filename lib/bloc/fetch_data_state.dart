part of 'fetch_data_bloc.dart';

abstract class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

class FetchDataLoadingState extends FetchDataState {
  @override
  List<Object> get props => [];
}

class FetchDataLoadedState extends FetchDataState {
  final List<OrderProductModel> products;

  FetchDataLoadedState(this.products);
  @override
  List<Object> get props => [products];
}

class FetchDataErrorState extends FetchDataState {
  final String message;

  FetchDataErrorState(this.message);

  @override
  List<Object> get props => [message];
}
