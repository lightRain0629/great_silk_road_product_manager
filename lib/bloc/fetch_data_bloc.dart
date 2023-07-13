import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../apiBYY/apiGetOrderProduct.dart';
import '../models/orderProductModel.dart';


part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  final ApiGetOrderProducts _productRepository;

  FetchDataBloc(this._productRepository) : super(FetchDataLoadingState()) {
    on<LoadProductEvent>((event, emit) async {
      emit(FetchDataLoadingState());
      try {
        final products = await ApiGetOrderProducts().getOrderedProdcuts();
        emit(FetchDataLoadedState(products));
      } catch (e) {
        emit(FetchDataErrorState(e.toString()));
      }
    });
  }
}
