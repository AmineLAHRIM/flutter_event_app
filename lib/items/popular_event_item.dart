import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/models/event.dart';
import 'package:event_app/pages/event_detail_screen.dart';
import 'package:event_app/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PopularEventItem extends StatelessWidget {
  const PopularEventItem({
    Key key,
    @required this.currentEvent,
  }) : super(key: key);

  final Event currentEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, bottom: 32),
      width: 180,
      height: double.infinity,
      child: Card(
        elevation: 10,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
        margin: EdgeInsets.all(0),
        shadowColor: AppTheme.shadow.withOpacity(0.2),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 60,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: currentEvent.imageUrl,
                          placeholder: (ctx, url) =>
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.bottomRight,
                        child: FractionallySizedBox(
                          widthFactor: 0.4,
                          heightFactor: 0.1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Theme
                                .of(context)
                                .primaryColor
                                .withOpacity(0.7),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                currentEvent.date.day.toString() + 'th ' + currentEvent.date.month.toString() + ',' + currentEvent.date.year.toString(),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 8, color: Colors.white.withOpacity(0.7)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                currentEvent.name,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              child: Text(
                                currentEvent.address,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText2,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 60,
                                  child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Row(
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
                                          Flexible(
                                            child: AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: AlignPositioned(
                                                moveByChildWidth: -0.8,
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
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .subtitle1,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Flexible(
                                  flex: 40,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      DateFormat.jm().format(currentEvent.date).toLowerCase(),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Container(),
                        ),
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
                  onTap: () {
                    Navigator.pushNamed(context, EventDetailScreen.routeName, arguments:currentEvent.id,);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
