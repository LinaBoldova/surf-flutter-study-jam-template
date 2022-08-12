import 'package:surf_study_jam/surf_study_jam.dart';

/// Basic model, representing chat user.
class ChatUserDto {
  /// User's name.
  ///
  /// May be `null`.
  final String? name;
  final int id;

  /// Constructor for [ChatUserDto].
  const ChatUserDto({
    required this.name,
    required this.id,
  });

  /// Factory-like constructor for converting DTO from [StudyJamClient].
  ChatUserDto.fromSJClient(SjUserDto sjUserDto) : name = sjUserDto.username, id = sjUserDto.id;

  @override
  String toString() => 'ChatUserDto(name: $name)';
}
