import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/items/popular_event_item.dart';
import 'package:event_app/models/event.dart';
import 'package:event_app/services/EventService.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';
  static final String TAG = 'TAGHOME';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  List<Event> events = [];
  Event firstNearEvent;

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
        });
      });

      eventService.firstNear().then((value) {
        setState(() {
          firstNearEvent = value;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    setupSystemSettings();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 10,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          child: SvgPicture.asset('assets/images/icon_notification_fill.svg'),
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
                        'Join with \nupcoming events.',
                        style: Theme.of(context).textTheme.headline4,
                      )),
                ),
              ),
              Expanded(
                flex: 13,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    heightFactor: 0.6,
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                      margin: EdgeInsets.all(0),
                      shadowColor: AppTheme.shadow.withOpacity(0.2),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 80,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 16),
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 20,
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                child: FractionallySizedBox(
                                  heightFactor: 0.9,
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Card(
                                      elevation: 0,
                                      color: Theme.of(context).primaryColor,
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: FractionallySizedBox(widthFactor: 0.45, child: SvgPicture.asset('assets/images/icon_filter.svg')),
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
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 44,
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
                                  'Popular',
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
                          margin: EdgeInsets.only(top: 32),
                          child: ListView.builder(
                            padding: EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: events.length,
                            itemBuilder: (ctx, index) {
                              Event currentEvent=events[index];
                              return PopularEventItem(currentEvent: currentEvent);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 24,
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
                                  'Near You',
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
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                            margin: EdgeInsets.all(16),
                            shadowColor: AppTheme.shadow.withOpacity(0.2),
                            child: firstNearEvent == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Stack(
                                    children: [
                                      Row(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl: firstNearEvent.imageUrl,
                                                placeholder: (ctx, url) => Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url, error) => Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 100,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              margin: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                                              child: Column(
                                                children: [
                                                  Expanded(flex: 10,child: Container(),),
                                                  Expanded(flex: 20,child: Container(child: Container(
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      alignment: Alignment.centerLeft,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          firstNearEvent.name,
                                                          style: Theme.of(context).textTheme.headline5,
                                                        ),
                                                      ),
                                                    ),
                                                  ),),),
                                                  Expanded(flex: 20,child: Container(child: Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    alignment: Alignment.centerLeft,
                                                    child: FittedBox(
                                                      child: Text(
                                                        firstNearEvent.address,
                                                        style: Theme.of(context).textTheme.bodyText2,
                                                      ),
                                                    ),
                                                  ),),),
                                                  Expanded(flex: 20,child: Container(),),
                                                  Expanded(flex: 20,child: Container(
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Container(
                                                            width: double.infinity,
                                                            height: double.infinity,
                                                            alignment: Alignment.centerLeft,
                                                            child: FittedBox(
                                                              fit: BoxFit.scaleDown,
                                                              child: Text(
                                                                DateFormat.yMMMd().format(firstNearEvent.date).toString(),
                                                                style: Theme.of(context).textTheme.bodyText1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                              height: double.infinity,
                                                              alignment: Alignment.centerRight,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: [
                                                                  Flexible(
                                                                    child: AspectRatio(
                                                                      aspectRatio: 1 / 1,
                                                                      child: AlignPositioned(
                                                                        moveByChildWidth: 0.8,
                                                                        child: SvgPicture.asset(
                                                                          'assets/images/user1.svg',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: AspectRatio(
                                                                      aspectRatio: 1 / 1,
                                                                      child: AlignPositioned(
                                                                        moveByChildWidth: 0.4,
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
                                                                        moveByChildWidth: 0.2,
                                                                        child: SvgPicture.asset(
                                                                          'assets/images/user3.svg',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: AspectRatio(
                                                                      aspectRatio: 1 / 1,
                                                                      child: Stack(
                                                                        alignment: Alignment.center,
                                                                        children: [
                                                                          SvgPicture.asset(
                                                                            'assets/images/icon_circle.svg',
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.all(3.0),
                                                                            child: FittedBox(
                                                                              child: Text(
                                                                                '1k+',
                                                                                style: Theme.of(context).textTheme.subtitle1,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),),
                                                  Expanded(flex: 10,child: Container(),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashFactory: InkRipple.splashFactory,
                                            splashColor: AppTheme.shadow.withOpacity(0.1),
                                            onTap: () => null,
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
            ],
          ),
        ),
      ),
    );
  }
}


void setupSystemSettings() {
  // this will change color of status bar and system navigation bar
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiLight);

  // this will prevent change oriontation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
