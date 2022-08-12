import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';

class LocaleRepository {


  Future<void> writeTokenDto(TokenDto tokenDto) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('TokenDto', tokenDto.token);

  }

  Future<String> getTokenDto() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('TokenDto') ?? '';
  }
 }