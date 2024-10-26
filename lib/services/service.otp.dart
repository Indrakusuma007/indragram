import 'dart:math';

import 'package:dio/dio.dart';

class ServiceOtp {
  final dio = Dio();

  Future sendOtp({required String noHp}) async {
    try {
      final otp = generateOTP();
      dio.options.headers['Authorization'] = '97hd9MDUrjtiQU4ZBB9J';

      var response = await dio.post(
        'https://api.fonnte.com/send',
        data: {
          'target': noHp,
          'message': 'Kode OTP *${otp.toString()}*. Jangan berikan kode OTP ke orang lain boss.',
          'countryCode': '62', // optional
        },
      );
      print(response.data);
      return otp;
    } catch (error) {
      if (error is DioException) {
        print('Error: ${error.response?.data ?? error.message}');
        throw '${error.response?.data ?? error.message}';
      } else {
        print('Unexpected error: $error');
        throw error.toString();
      }
    }
  }

  String generateOTP() {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(4, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
