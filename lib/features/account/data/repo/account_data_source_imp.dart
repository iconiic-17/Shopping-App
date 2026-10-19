import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/api_helpers.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/features/account/data/model/item_dto.dart';
import 'package:shopping_app/features/account/domain/entities/item_entity.dart';
import 'package:shopping_app/features/account/domain/repo/account_data_source_interface.dart';

@Injectable(as: AccountDataSourceInterface)
class AccountDataSourceImp implements AccountDataSourceInterface {
  AccountDataSourceImp(this._dio);

  final Dio _dio;

  @override
  Future<ResultApi<UserProfileEntity>> getUserProfile() async {
    try {
      final response = await _dio.get(ApiConstants.getUserData);
      final dto = UserProfileDto.fromJson(response.data);
      return Success(dto.toEntity());
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<UserProfileEntity>> updateUserProfile(
    UpdateProfileParams params,
  ) async {
    try {
      // 1. Upload new image if provided
      if (params.imagePath != null && params.imagePath!.trim().isNotEmpty) {
        final file = File(params.imagePath!);
        if (await file.exists()) {
          final fileName = params.imagePath!.split('/').last;
          final formData = FormData.fromMap({
            'file': await MultipartFile.fromFile(
              params.imagePath!,
              filename: fileName,
            ),
          });
          await _dio.post(
            ApiConstants.uploadImage,
            data: formData,
          );
        }
      }

      // 2. Update profile text details (POST /portfoilo/editUserData)
      final map = <String, dynamic>{};
      if (params.name != null && params.name!.trim().isNotEmpty) {
        map['name'] = params.name!.trim();
      }
      if (params.phone != null && params.phone!.trim().isNotEmpty) {
        map['phone'] = params.phone!.trim();
      }
      if (params.address != null && params.address!.trim().isNotEmpty) {
        map['address'] = params.address!.trim();
      }
      if (params.password != null && params.password!.trim().isNotEmpty) {
        map['password'] = params.password!.trim();
      }

      if (map.isNotEmpty) {
        await _dio.post(
          ApiConstants.editUserData,
          data: map,
        );
      }

      // 3. Return fresh profile from server
      return await getUserProfile();
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> uploadProfileImage(String filePath) async {
    try {
      final file = await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );
      final formData = FormData.fromMap({'file': file});

      final response = await _dio.post(
        ApiConstants.uploadImage,
        data: formData,
      );

      final data = response.data;
      if (data is Map) {
        final img = (data['image'] ?? data['url'] ?? data['data'] ?? '')
            .toString();
        if (img.isNotEmpty) return Success(img);
      }
      return Success(filePath);
    } on DioException catch (e) {
      return Error(dioErrorMessage(e));
    } catch (e) {
      return Error(e.toString());
    }
  }
}
