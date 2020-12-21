import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppHelper {
  RateAppHelper._();

  static final _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    appStoreIdentifier: 'com.',
    minLaunches: 10,
  );
  static Future<void> init(BuildContext context) async {
    if (kIsWeb) return;
    await _rateMyApp.init();

    if (_rateMyApp.shouldOpenDialog) await showRating(context);
  }

  static Future<void> showRating(BuildContext context) async {
    if (kIsWeb) return;
    try {
      await _rateMyApp.launchNativeReviewDialog();
    } catch (e) {
      print('------launchNativeReviewDialog $e');
    }
    await _rateMyApp.showStarRateDialog(
      context,
      actionsBuilder: (_, stars) => [
        FlatButton(child: Text('Cancel'), onPressed: Modular.to.pop),
        FlatButton(
          child: Text('OK'),
          onPressed: () async {
            if (stars > 4) {
              try {
                await _rateMyApp.launchStore();
                await _rateMyApp
                    .callEvent(RateMyAppEventType.rateButtonPressed);
              } catch (e) {
                print('-----launchStore $e');
              }
            }
          },
        ),
      ],
      starRatingOptions:
          StarRatingOptions(allowHalfRating: true, initialRating: 5),
      title: 'Rate US',
      message:
          'You like this app ? Then take a little bit of your time to leave a rating :',
      ignoreNativeDialog: true,
      onDismissed: () =>
          _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }
}
