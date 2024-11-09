part of 'detail_bloc.dart';

@freezed
class DetailEvent with _$DetailEvent {
  const factory DetailEvent.started(String id) = _Started;

  const factory DetailEvent.pickImage() = _PickImage;

  const factory DetailEvent.clearImage() = _ClearImage;

  const factory DetailEvent.updateUser(
    String id,
    String name,
    String email,
  ) = _UpdateUser;
}
