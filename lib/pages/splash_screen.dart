import 'package:event_app/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  static final String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/images/splash_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 0.6,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 20,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  flex: 50,
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 0,
                                      margin: EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(AppTheme.radius)),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: SvgPicture.asset(
                                            'assets/images/icon_logo.svg'),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 50,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'eventis',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .copyWith(
                                              fontSize: 36,
                                              color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 40,
                                  child: Text(
                                    'Create & find \nevents in one place!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                Flexible(flex: 10, child: Container()),
                                Flexible(
                                  flex: 40,
                                  child: Text(
                                    'Lorem ipsum dolor sit amet, consetetur sadips elitr, sed diam nonumy eirmod tempor invidut labore et dolore magna.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: Card(
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppTheme.radius)),
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
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
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
                                                    'assets/images/icon_next.svg',),
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
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
