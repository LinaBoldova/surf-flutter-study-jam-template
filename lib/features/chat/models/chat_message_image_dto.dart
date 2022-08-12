import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_study_jam/surf_study_jam.dart';

import 'chat_user_dto.dart';

class ChatMessageImageDto extends ChatMessageDto {
  final List<String>? imageUrl;

  ChatMessageImageDto({
    required ChatUserDto chatUserDto,
    required String? message,
    required DateTime createdDateTime,
    required this.imageUrl,
  })
      : super(
      chatUserDto: chatUserDto,
      message: message,
      createdDateTime: createdDateTime);


  ChatMessageImageDto.fromSJClient({
  required SjMessageDto sjMessageDto,
  required SjUserDto sjUserDto,
    required List<String> images,
})  : imageUrl = images,
      super(
      createdDateTime: sjMessageDto.created,
      message: sjMessageDto.text,
      chatUserDto: ChatUserDto.fromSJClient(sjUserDto),
    );

@override
String toString() => 'ChatMessageImageDto(imageUrl: $imageUrl) extends ${super.toString()}';
}

