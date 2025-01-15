import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'photo_event.dart';
part 'photo_state.dart';

@injectable
class PhotoViewModel extends Bloc<PhotoEvent, PhotoState> {
  PhotoViewModel() : super(PhotoInitial());
}
