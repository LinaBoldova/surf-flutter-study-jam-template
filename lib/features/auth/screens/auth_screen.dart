import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/features/auth/models/token_dto.dart';
import 'package:surf_practice_chat_flutter/features/auth/repository/auth_repository.dart';
import 'package:surf_practice_chat_flutter/features/auth/screens/custom_text_form_field.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'package:surf_practice_chat_flutter/features/chat/screens/chat_screen.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import '../../../locale_repository.dart';
import '../exceptions/auth_exception.dart';

/// Screen for authorization process.
///
/// Contains [IAuthRepository] to do so.
class AuthScreen extends StatefulWidget {
  /// Repository for auth implementation.
  final IAuthRepository authRepository;

  /// Constructor for [AuthScreen].
  const AuthScreen({
    required this.authRepository,
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<TokenDto?> getToken(BuildContext context) async {
    // check validation
    try {
      TokenDto token = await widget.authRepository.signIn(
          login: _loginController.text, password: _passwordController.text);
      LocaleRepository localeRepo = LocaleRepository();
      await localeRepo.writeTokenDto(token);
      if (kDebugMode) {
        print(token.token);
      }
      if (kDebugMode) {
        print(await localeRepo.getTokenDto());
      }
      return token;
    } on AuthException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error! Invalid login or password.'),
        ),
      );
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Got error : $error.'),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: const Color(0xff677DB7),
                    ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: _loginController,
                    label: "Логин",
                    icon: Icons.person,
                  ),
                  CustomTextFormField(
                    controller: _passwordController,
                    label: "Пароль",
                    icon: Icons.lock,
                    hideText: true,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff677DB7),
                      border: Border.all(
                        color: const Color(0xff677DB7),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width - 36,
                    child: TextButton(
                      onPressed: () => getToken(context).then(
                        (token) {
                          if (token != null) {
                            _pushToChat(context, token);
                          }
                        },
                      ),
                      child: const Text(
                        'ДАЛЕЕ',
                        style: TextStyle(
                          color: Color.fromRGBO(253, 253, 247, 1),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 70,
                    endIndent: 70,
                    thickness: 5.0,
                    color: Color(0xff677DB7),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pushToChat(BuildContext context, TokenDto token) {
    Navigator.push<ChatScreen>(
      context,
      MaterialPageRoute(
        builder: (_) {
          return ChatScreen(
            chatRepository: ChatRepository(
              StudyJamClient().getAuthorizedClient(token.token),
            ),
          );
        },
      ),
    );
  }
}
