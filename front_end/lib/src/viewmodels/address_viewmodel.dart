import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:getgoods/src/constants/constants.dart';
import 'package:getgoods/src/models/district_model.dart';
import 'package:getgoods/src/models/province_model.dart';
import 'package:getgoods/src/models/sub_district_model.dart';

enum AddressState {
  loading,
  success,
  error,
}

class AddressViewModel {
  final Dio _dio = Dio();

  List<Province> provinces = [];
  List<District> districts = [];
  List<SubDistrict> subDistricts = [];
  AddressState state = AddressState.loading;

  Future<void> fetchProvinces() async {
    state = AddressState.loading;

    try {
      final response = await _dio
          .get('https://www.androidthai.in.th/flutter/getAllprovinces.php');
      // log(response.toString());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data); // Parsing string to JSON

        if (data is List) {
          final List<dynamic> responseProvinces = data;

          provinces = responseProvinces
              .map((province) => Province.fromJson(province))
              .toList();

          state = AddressState.success;
        } else {
          // If parsed data is not a list, set state to error
          state = AddressState.error;
        }
      } else {
        // If status code is not 200, set state to error
        state = AddressState.error;
      }
    } catch (e) {
      // If any exception occurs, set state to error
      state = AddressState.error;
      log('Exception while fetching provinces: $e');
    }
  }

  Future<void> fetchDistricts(String proviceId) async {
    state = AddressState.loading;

    try {
      final response = await _dio.get(
          'https://www.androidthai.in.th/flutter/getAmpByProvince.php?isAdd=true&province_id=$proviceId');
      log(response.toString());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data); // Parsing string to JSON

        if (data is List) {
          final List<dynamic> responseDistricts = data;

          districts = responseDistricts
              .map((province) => District.fromJson(province))
              .toList();

          state = AddressState.success;
        } else {
          // If parsed data is not a list, set state to error
          state = AddressState.error;
        }
      } else {
        // If status code is not 200, set state to error
        state = AddressState.error;
      }
    } catch (e) {
      // If any exception occurs, set state to error
      state = AddressState.error;
      log('Exception while fetching provinces: $e');
    }
  }

  Future<void> fetchSubDistricts(String districtId) async {
    state = AddressState.loading;

    try {
      final response = await _dio.get(
          'https://www.androidthai.in.th/flutter/getDistriceByAmphure.php?isAdd=true&amphure_id=$districtId');
      log(response.toString());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data); // Parsing string to JSON

        if (data is List) {
          final List<dynamic> responseSubDistricts = data;

          subDistricts = responseSubDistricts
              .map((province) => SubDistrict.fromJson(province))
              .toList();

          state = AddressState.success;
        } else {
          // If parsed data is not a list, set state to error
          state = AddressState.error;
        }
      } else {
        // If status code is not 200, set state to error
        state = AddressState.error;
      }
    } catch (e) {
      // If any exception occurs, set state to error
      state = AddressState.error;
      log('Exception while fetching provinces: $e');
    }
  }
}
