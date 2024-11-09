import 'package:base_flutter_bloc/core/domain/usecase/auth/user_update_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/domain/usecase/auth/get_user_use_case.dart';
import '../../../../core/model/data/remote/request/auth/user_update_request.dart';
import '../../../../core/model/data/remote/response/auth/user_model.dart';
import '../../../../core/utils/common/helper.dart';
import '../../../utils/crop_image/crop_aspect_ratio.dart';

part 'detail_event.dart';

part 'detail_state.dart';

part 'detail_bloc.freezed.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetUserUseCase getUserUseCase;
  final UserUpdateUseCase userUpdateUseCase;

  DetailBloc({
    required this.getUserUseCase,
    required this.userUpdateUseCase,
  }) : super(DetailState.initial()) {
    on<DetailEvent>(_onEvent);
  }

  Future<void> _onEvent(DetailEvent event, Emitter<DetailState> emit) async {
    await event.when(
      started: (id) => _onStarted(event, emit, id),
      pickImage: () => _onPickImage(event, emit),
      clearImage: () => _onClearImage(event, emit),
      updateUser: (String id, String name, String email) =>
          _onUpdateUser(event, emit, id, name, email),
    );
  }

  Future<void> _onStarted(
    DetailEvent event,
    Emitter<DetailState> emit,
    String id,
  ) async {
    emit(DetailState.userDataLoading());
    final result = await getUserUseCase(id);
    result.when(
      success: (data) {
        emit(DetailState.userDataSuccess(data));
      },
      failed: (e) {
        emit(DetailState.userDataFailed(e));
      },
    );
  }

  Future<void> _onPickImage(
    DetailEvent event,
    Emitter<DetailState> emit,
  ) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );

    if (croppedFile == null) return;

    emit(state.copyWith(croppedFile: croppedFile));
  }

  Future<void> _onClearImage(
      DetailEvent event, Emitter<DetailState> emit) async {
    emit(state.copyWith(croppedFile: null));
  }

  Future<void> _onUpdateUser(
    DetailEvent event,
    Emitter<DetailState> emit,
    String id,
    String name,
    String email,
  ) async {
    final request = UserUpdateRequest(
      id: id,
      name: name,
      email: email,
      imagePath: state.croppedFile?.path,
    );

    final result = await userUpdateUseCase(
      request
    );

    result.when(
      success: (data) {
        emit(state.copyWith(isSuccessUpdateUser: true));
      },
      failed: (e) {
        emit(state.copyWith(isSuccessUpdateUser: false, errorUpdateUser: e));
      },
    );

  }
}
