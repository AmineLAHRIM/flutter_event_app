import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/models/event.dart';
import 'package:event_app/pages/event_detail_screen.dart';
import 'package:event_app/services/EventService.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventHomeScreen extends StatefulWidget {
  static final String routeName = '/event-home';

  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  List<Event> events = [];
  List<DateTime> dates = [];
  var _isInit = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      EventService eventService = Provider.of<EventService>(context);
      eventService.findAll().then((value) {
        setState(() {
          events = value;
          events = value.where((element) => element.near == true).toList();
        });
      });
      setState(() {
        dates = eventService.allDates();
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void onSelectedDate(DateTime currentDateTime) {
    setState(() {
      selectedDateTime = currentDateTime;
    });
    EventService eventService = Provider.of<EventService>(context);
    eventService.findAll().then((value) {
      setState(() {
        events = value;
        events = value.where((element) => element.near == true && isSameDay(element.date)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiLight);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 20,
                        child: InkResponse(
                          splashFactory: InkRipple.splashFactory,
                          onTap: () => null,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 16),
                            child: SvgPicture.asset('assets/images/menu.svg'),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          child: FittedBox(
                            child: Text(
                              'Event',
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
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
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Discover with \nupcoming events.',
                        style: Theme.of(context).textTheme.headline3,
                      )),
                ),
              ),
              Expanded(
                flex: 15,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (context, index) {
                        DateTime currentDateTime = dates[index];
                        return DateItem(
                          currentDateTime: currentDateTime,
                          onSelectDateTime: ()=> onSelectedDate(currentDateTime),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 57,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 80,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Near',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 20,
                              child: FractionallySizedBox(
                                heightFactor: 0.7,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'See all',
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 100,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          margin: EdgeInsets.only(top: 16),
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 0),
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              print('event home==' + events.length.toString());
                              Event currentEvent = events[index];
                              return NearEventItem(currentEvent: currentEvent);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 10,child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 25,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/images/icon_home_fill.svg'),
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
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/images/icon_calendar.svg'),
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
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/images/icon_ticket.svg'),
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
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: SvgPicture.asset('assets/images/icon_settings.svg'),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

DateTime selectedDateTime;

class DateItem extends StatelessWidget {
  const DateItem({
    Key key,
    @required this.currentDateTime,
    @required this.onSelectDateTime,
  }) : super(key: key);

  final DateTime currentDateTime;
  final Function onSelectDateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Card(
          elevation: 0,
          color: isSameDay(currentDateTime) ? Theme.of(context).primaryColor : Colors.white,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isSameDay(currentDateTime)
                ? BorderSide.none
                : BorderSide(
                    width: 1.5,
                    color: AppTheme.borderCard,
                  ),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: FractionallySizedBox(
                  heightFactor: 0.7,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 50,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            DateFormat.E().format(currentDateTime),
                            style: isSameDay(currentDateTime) ? Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white) : Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            currentDateTime.day.toString(),
                            style: isSameDay(currentDateTime) ? Theme.of(context).textTheme.headline4.copyWith(color: Colors.white) : Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashFactory: InkRipple.splashFactory,
                    onTap: onSelectDateTime,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isSameDay(DateTime dateTime) {
  if(selectedDateTime==null){
    return false;
  }
  return selectedDateTime.year == dateTime.year && selectedDateTime.month == dateTime.month && selectedDateTime.day == dateTime.day;
}

class NearEventItem extends StatelessWidget {
  const NearEventItem({
    Key key,
    @required this.currentEvent,
  }) : super(key: key);

  final Event currentEvent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.infinity,
          height: 120,
          child: Stack(
            children: [
              Row(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 5,
                    child: Card(
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radius),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: currentEvent.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                  Expanded(
                    flex: 65,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: [
                            Spacer(
                              flex: 10,
                            ),
                            Expanded(
                              flex: 20,
                              child: Container(
                                child: Container(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        currentEvent.name,
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  heightFactor: 1,
                                  child: Text(
                                    currentEvent.address,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 5,
                            ),
                            Expanded(
                              flex: 25,
                              child: Container(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      DateFormat.jm().format(currentEvent.date) + ' - ' + DateFormat.jm().format(currentEvent.date.add(Duration(hours: 2))),
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(
                              flex: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashFactory: InkRipple.splashFactory,
                    splashColor: AppTheme.shadow.withOpacity(0.1),
                    onTap: () {
                      Navigator.pushNamed(context, EventDetailScreen.routeName,arguments: currentEvent.id);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
