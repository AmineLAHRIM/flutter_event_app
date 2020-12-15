import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/models/event.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/services/EventService.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatefulWidget {
  static final String routeName = '/event-detail';

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Event currentEvent;
  List<User> currentUsers = [];
  int id = -1;
  bool isLoading = true;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!isInit) {
      int id = ModalRoute.of(context).settings.arguments;
      print('id==' + id.toString());
      EventService eventService = Provider.of<EventService>(context);
      eventService.findById(id).then((value) {
        setState(() {
          currentEvent = value;
          currentUsers = currentEvent.users;
          print('id==currentEvent' + currentEvent.imageUrl.toString());
          isLoading = false;
        });
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiTrans);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 40,
              child: currentEvent == null
                  ? Container()
                  : Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: currentEvent.imageUrl,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          fit: BoxFit.cover,
                        ),
                        FractionallySizedBox(
                          heightFactor: 0.25,
                          widthFactor: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 20,
                                  child: SvgPicture.asset('assets/images/menu.svg'),
                                ),
                                Spacer(
                                  flex: 60,
                                ),
                                Flexible(
                                  flex: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                                    child: SvgPicture.asset('assets/images/icon_notification_fill.svg'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  heightFactor: 0.7,
                  widthFactor: 0.9,
                  child: currentEvent == null
                      ? Container()
                      : Column(
                          children: [
                            Expanded(
                              flex: 50,
                              child: Container(
                                width: double.infinity,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    currentEvent == null ? '' : currentEvent.name,
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 50,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: 0.6,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 20,
                                        child: SvgPicture.asset('assets/images/icon_localisation.svg'),
                                      ),
                                      Spacer(
                                        flex: 5,
                                      ),
                                      Flexible(
                                        flex: 75,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            currentEvent == null ? '' : currentEvent.address,
                                            style: Theme.of(context).textTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: currentUsers.length <= 0
                  ? Container()
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        heightFactor: 0.8,
                        child: Column(
                          children: [
                            Flexible(
                              flex: 50,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 16),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Paricipants',
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 50,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: 1 == 1
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: currentUsers.length,
                                        itemBuilder: (context, index) {
                                          User currentUser = currentUsers[index];
                                          return Container(
                                            height: double.infinity,
                                            child: index != 0
                                                ? AspectRatio(
                                                    aspectRatio: 1 / 1,
                                                    child: AlignPositioned(
                                                      moveByChildWidth: index * (-0.2),
                                                      child: CachedNetworkImage(
                                                        imageUrl: currentUser.imageUrl,
                                                      ),
                                                    ),
                                                  )
                                                : AspectRatio(
                                                    aspectRatio: 1 / 1,
                                                    child: CachedNetworkImage(
                                                      imageUrl: currentUser.imageUrl,
                                                    ),
                                                  ),
                                          );
                                        },
                                      )
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: SvgPicture.asset(
                                                'assets/images/user1.svg',
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: AlignPositioned(
                                                moveByChildWidth: -0.2,
                                                child: SvgPicture.asset(
                                                  'assets/images/user2.svg',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: AlignPositioned(
                                                moveByChildWidth: -0.4,
                                                child: SvgPicture.asset(
                                                  'assets/images/user3.svg',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Expanded(
              flex: 5,
              child: Container(),
            ),
            Expanded(
              flex: 20,
              child: Container(),
            ),
            Container(
              height: 55,
              width: double.infinity,
              child: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: FractionallySizedBox(
                          widthFactor: 0.45,
                          heightFactor: 0.38,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 60,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      'Get Started',
                                      style: Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 30,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: SvgPicture.asset(
                                      'assets/images/icon_next.svg',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashFactory: InkRipple.splashFactory,
                            onTap: () => null,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
