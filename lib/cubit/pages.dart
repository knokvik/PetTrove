import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<int> {
  HomePageCubit() : super(0);  // Default to the first page (index 0)

  void updateIndex(int index) {
    emit(index);  
  }
}
