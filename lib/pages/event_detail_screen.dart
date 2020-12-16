import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_app/models/event.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/services/EventService.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                          child: FractionallySizedBox(
                            heightFactor: 0.25,
                            widthFactor: 1,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 20,
                                    child: InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 16),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: SvgPicture.asset(
                                            'assets/images/icon_back.svg',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 60,
                                  ),
                                  Expanded(
                                    flex: 20,
                                    child: InkResponse(
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () => null,
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(right: 16),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                                          child: SvgPicture.asset('assets/images/icon_notification_fill.svg'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
              child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
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
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: currentUsers.length + 1,
                                  itemBuilder: (context, index) {
                                    int length = currentUsers.length + 1;
                                    User currentUser;
                                    print('event index== list index==' + index.toString() + " __ " + length.toString());
                                    if (index < length - 1) {
                                      currentUser = currentUsers[index];
                                    } else {
                                      currentUser = null;
                                    }

                                    return ParticipantItem(
                                      currentUser: currentUser,
                                      index: index,
                                      length: length,
                                    );
                                  },
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
              child: currentEvent == null
                  ? Container()
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 50,
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 10,
                                    child: SvgPicture.asset('assets/images/icon_time.svg'),
                                  ),
                                  Spacer(
                                    flex: 5,
                                  ),
                                  Flexible(
                                    flex: 85,
                                    child: Text(
                                      DateFormat.jm().format(currentEvent.date) + ' - ' + DateFormat.jm().format(currentEvent.date.add(Duration(hours: 2))),
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 40,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    flex: 10,
                                    child: SvgPicture.asset(
                                      'assets/images/icon_calendar.svg',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 5,
                                  ),
                                  Flexible(
                                    flex: 85,
                                    child: Text(
                                      DateFormat.yMMMd().format(currentEvent.date),
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 10,
                          )
                        ],
                      ),
                    ),
            ),
            Expanded(
              flex: 20,
              child: currentEvent == null
                  ? Container()
                  : Container(
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        child: SingleChildScrollView(
                          child: Text(
                            currentEvent.description,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                  color: Theme.of(context).primaryColor,
                  child: currentEvent == null
                      ? LoadingProgress(
                          color: Colors.white,
                        )
                      : Stack(
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
                                            'Buy Ticket',
                                            style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 40,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            '\$' + currentEvent.price.toInt().toString(),
                                            style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
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

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: color == null ? null : new AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

class ParticipantItem extends StatelessWidget {
  const ParticipantItem({
    Key key,
    @required this.currentUser,
    @required this.index,
    @required this.length,
  }) : super(key: key);

  final User currentUser;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    print('event index==' + index.toString() + ' length==' + length.toString());
    if (length>1 && index == 0) {
      return Container(
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: CachedNetworkImage(
            imageUrl: currentUser.imageUrl,
          ),
        ),
      );
    } else if (index < length - 1) {
      return Container(
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: AlignPositioned(
            moveByChildWidth: index * (-0.2),
            child: CachedNetworkImage(
              imageUrl: currentUser.imageUrl,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: AlignPositioned(
            moveByChildWidth: index * (-0.2),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: DottedBorder(
                color: Colors.black,
                borderType: BorderType.Circle,
                strokeWidth: 3,
                dashPattern: [4],
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color(0xFFE8F2F9),
                    padding: EdgeInsets.all(14),
                    child: SvgPicture.asset('assets/images/icon_add.svg'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
