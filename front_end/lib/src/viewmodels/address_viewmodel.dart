import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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
  final String _baseUrl = 'https://www.androidthai.in.th/flutter';

  List<Province> provinces = [];
  List<District> districts = [];
  List<SubDistrict> subDistricts = [];
  AddressState state = AddressState.loading;

  Future<void> _fetchData(String url, Function onSuccess) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);

        if (data is List) {
          onSuccess(data);
          state = AddressState.success;
        } else {
          state = AddressState.error;
        }
      } else {
        state = AddressState.error;
      }
    } catch (e) {
      state = AddressState.error;
      log('Exception while fetching data: $e');
    }
  }

  void _onProvinceDataReceived(List<dynamic> data) {
    provinces = data.map((province) => Province.fromJson(province)).toList();
  }

  void _onDistrictDataReceived(List<dynamic> data) {
    districts = data.map((district) => District.fromJson(district)).toList();
  }

  void _onSubDistrictDataReceived(List<dynamic> data) {
    subDistricts =
        data.map((subDistrict) => SubDistrict.fromJson(subDistrict)).toList();
  }

  Future<void> fetchProvinces() async {
    state = AddressState.loading;
    await _fetchData(
      '$_baseUrl/getAllprovinces.php',
      _onProvinceDataReceived,
    );
  }

  Future<void> fetchDistricts(String provinceId) async {
    state = AddressState.loading;
    await _fetchData(
      '$_baseUrl/getAmpByProvince.php?isAdd=true&province_id=$provinceId',
      _onDistrictDataReceived,
    );
  }

  Future<void> fetchSubDistricts(String districtId) async {
    state = AddressState.loading;
    await _fetchData(
      '$_baseUrl/getDistriceByAmphure.php?isAdd=true&amphure_id=$districtId',
      _onSubDistrictDataReceived,
    );
  }
}
