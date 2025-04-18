import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terox_ai/bloc/product_event.dart';
import 'package:terox_ai/bloc/product_state.dart';
import 'package:terox_ai/data/model/diagnosis_model.dart';
import 'package:terox_ai/data/status.dart';
import 'package:terox_ai/data/universal_data.dart';
import 'package:terox_ai/repository/image_repo.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepo imageRepo;

  ImageBloc({required this.imageRepo})
    : super(
        ImageState(
          diagnosisModel: DiagnosisModel(result: ''),
          status: FormStatus.pure,
          statusText: '',
        ),
      ) {
    on<ImageEvent>((event, emit) {});
    on<PureImageEvent>(pureImage);
    on<GetImageEvent>(getImage);
  }

  Future<void> getImage(
    GetImageEvent getImageEvent,
    Emitter<ImageState> emit,
  ) async {
    emit(state.copyWith(statusText: 'Loading', status: FormStatus.loading));
    debugPrint('Add product bloc');
    UniversalData data = await imageRepo.getImage(getImageEvent.file);
    if (data.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: 'Ma\'lumot muvaffaqiyatli yuklandi',
          diagnosisModel: DiagnosisModel.fromJson(data.data),
        ),
      );
    } else {
      emit(state.copyWith(status: FormStatus.failure, statusText: data.error));
      pureImage(PureImageEvent(), emit);
    }
  }

  pureImage(PureImageEvent event, Emitter<ImageState> emit) {
    emit(
      state.copyWith(
        statusText: 'Pure',
        status: FormStatus.pure,
        diagnosisModel: DiagnosisModel(result: ''),
      ),
    );
  }
}
