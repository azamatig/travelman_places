
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_state.freezed.dart';

@freezed
abstract class UploadState with _$UploadState {
  const factory UploadState.initial() = _Initial;
  const factory UploadState.imgPicked(String path) = _ImgPicked;
  const factory UploadState.success(String url) = _Success;
  const factory UploadState.failed() = _Failed;
}
