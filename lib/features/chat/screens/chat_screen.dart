import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_image_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_message_location_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/models/chat_user_local_dto.dart';
import 'package:surf_practice_chat_flutter/features/chat/repository/chat_repository.dart';
import 'dart:math' as math;
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as mapl;
import 'package:yandex_mapkit/yandex_mapkit.dart';


part 'chat_avatar.dart';
part 'chat_message.dart';
part 'chat_text_field.dart';
part 'chat_appbar.dart';
part 'chat_body.dart';

/// Main screen of chat app, containing messages.
class ChatScreen extends StatefulWidget {
  /// Repository for chat functionality.
  final IChatRepository chatRepository;

  /// Constructor for [ChatScreen].
  const ChatScreen({
    required this.chatRepository,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _nameEditingController = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();

  Iterable<ChatMessageDto> _currentMessages = [];
  @override
  void initState() {
    super.initState();
    _onUpdatePressed().then(
      (value) => WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollController.jumpTo(
          index: _currentMessages.length,
        ),
      ),
    );
  }



  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: _ChatAppBar(
          controller: _nameEditingController,
          onUpdatePressed: _onUpdatePressed,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _ChatBody(
              scrollController: _scrollController,
              messages: _currentMessages,
            ),
          ),
          _ChatTextField(onSendPressed: _onSendPressed),
        ],
      ),
    );
  }

  Future<void> _onUpdatePressed() async {
    final messages = await widget.chatRepository.getMessages();
    setState(() {
      _currentMessages = messages;
    });
  }

  Future<void> _onSendPressed(String messageText) async {
    final messages = await widget.chatRepository.sendMessage(messageText);
    setState(() {
      _currentMessages = messages;
    });
  }
}
