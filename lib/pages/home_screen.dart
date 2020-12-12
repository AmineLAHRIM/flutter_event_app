import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 0),
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 0),
                          child: SvgPicture.asset(
                              'assets/images/icon_notification_fill.svg'),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radius)),
                      margin: EdgeInsets.all(0),
                      shadowColor: AppTheme.shadow.withOpacity(0.25),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(fontSize: 16),
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
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppTheme.radius)),
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: FractionallySizedBox(
                                                widthFactor: 0.45,
                                                child: SvgPicture.asset(
                                                    'assets/images/icon_filter.svg')),
                                          ),
                                          Positioned.fill(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                splashFactory:
                                                    InkRipple.splashFactory,
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
                        margin: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
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
                                heightFactor: 0.5,
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
                          margin: EdgeInsets.only(top: 32),
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 24,
                child: Container(
                  color: Colors.deepOrangeAccent,
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
