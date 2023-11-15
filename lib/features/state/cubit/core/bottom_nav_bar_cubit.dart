import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarCubit extends Cubit<bool> {
  BottomNavBarCubit() : super(true);

  void changeState(bool state) {
    emit(state);
  }
}
