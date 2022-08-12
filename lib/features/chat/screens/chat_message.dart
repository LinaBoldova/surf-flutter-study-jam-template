part of 'chat_screen.dart';

class _ChatMessage extends StatelessWidget {
  final ChatMessageDto chatData;

  bool isThisUser() {
    return chatData.chatUserDto is ChatUserLocalDto;
  }

  const _ChatMessage({
    required this.chatData,
    Key? key,
  }) : super(key: key);

  Widget showBubble() {
    return Bubble(
      padding: const BubbleEdges.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      radius: const Radius.circular(12.0),
      margin: const BubbleEdges.only(top: 10),
      alignment: isThisUser() ? Alignment.topRight : Alignment.topLeft,
      nip: isThisUser() ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: isThisUser() ? const Color(0xffEEC5D8) : const Color(0xffF5DDDD),
      child: Text(
        chatData.message ?? '',
        textAlign: isThisUser() ? TextAlign.right : TextAlign.left,
      ),
    );
  }

  double getCorrectLat(double coord) {
    return ((90.0 >= coord) & (coord >= -90.0)) ? coord : 0;
  }

  double getCorrectLng(double coord) {
    return ((180.0 >= coord) & (coord >= -180.0)) ? coord : 0;
  }

  Widget showMap(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: FlutterMap(
        options: MapOptions(
          allowPanning: false,
          center: LatLng(
            getCorrectLat(
                (chatData as ChatMessageGeolocationDto).location.latitude),
            getCorrectLng(
                (chatData as ChatMessageGeolocationDto).location.longitude),
          ),
          zoom: 16,
        ),
        layers: [
          TileLayerOptions(
            minZoom: 12.0,
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          CircleLayerOptions(
            circles: [
              CircleMarker(
                  point: LatLng(
                      getCorrectLat((chatData as ChatMessageGeolocationDto)
                          .location
                          .latitude),
                      getCorrectLng(
                        (chatData as ChatMessageGeolocationDto)
                            .location
                            .longitude,
                      )),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  borderStrokeWidth: 1,
                  borderColor:
                      Theme.of(context).colorScheme.primary.withOpacity(1),
                  useRadiusInMeter: true,
                  radius: 10 // 2000 meters | 2 km
                  ),
            ],
          )
        ],
      ),
    );
  }

  void showAvailableMaps(BuildContext context) async {
    final availableMaps = await mapl.MapLauncher.installedMaps;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Available maps:'),
                ),
                for (var map in availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(
                      coords: mapl.Coords(
                        (chatData as ChatMessageGeolocationDto)
                            .location
                            .latitude,
                        (chatData as ChatMessageGeolocationDto)
                            .location
                            .longitude,
                      ),
                      title: '',
                    ),
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: isThisUser()
          ? colorScheme.primary.withOpacity(.1)
          : Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isThisUser() ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isThisUser()) _ChatAvatar(userData: chatData.chatUserDto),
            if (!isThisUser()) const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: isThisUser()
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  showBubble(),
                  if ((chatData is ChatMessageGeolocationDto)) showMap(context),
                  if ((chatData is ChatMessageGeolocationDto))
                    GestureDetector(
                      child: Card(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Показать местоположение",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onTap: () => showAvailableMaps(context),
                    ),
                  // if ((chatData is ChatMessageImageDto) & ((chatData as ChatMessageImageDto).imageUrl != null))
                  //   GridView.builder(
                  //     itemCount:
                  //         (chatData as ChatMessageImageDto).imageUrl!.length,
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 5,
                  //     ),
                  //     itemBuilder: (_, int index) {
                  //       return GridTile(
                  //         child: SizedBox(
                  //           height: 30,
                  //           width: 30,
                  //           child: Image.network(
                  //             (chatData as ChatMessageImageDto).imageUrl![index],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                ],
              ),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Text(
              //       chatData.chatUserDto.name ?? '',
              //       style: const TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     const SizedBox(height: 4),
              //     Text(chatData.message ?? ''),
              //   ],
              // ),
            ),
            if (isThisUser()) const SizedBox(width: 16),
            if (isThisUser()) _ChatAvatar(userData: chatData.chatUserDto),
          ],
        ),
      ),
    );
  }
}
