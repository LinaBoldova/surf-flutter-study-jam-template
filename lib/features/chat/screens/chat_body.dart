part of 'chat_screen.dart';


class _ChatBody extends StatelessWidget {
  final Iterable<ChatMessageDto> messages;
  final ItemScrollController scrollController;


  _ChatBody({
    required this.messages,
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: scrollController,
      itemCount: messages.length,
      itemBuilder: (_, index) => _ChatMessage(
        chatData: messages.elementAt(index),
      ),
    );
  }
}

