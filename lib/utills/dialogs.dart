import 'package:flutter/material.dart';
import 'package:recipesapp/utills/app_constants.dart';

// dialog widgets will be here..

class GenericDialog extends StatelessWidget {
  const GenericDialog({Key? key, required this.message, this.title})
      : super(key: key);
  final String message;
  final title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Dialog(
          insetPadding: EdgeInsets.all(30),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            child: Stack(
              alignment: Alignment.topCenter,
              // overflow: Overflow.visible,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 27),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 0.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ]),
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 14.0,
                    right: 14.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Alert",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                      ),
                      // SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          message,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffdec7ff)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Color(0xff6200EE)),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: 55.0,
                //   height: 55.0,
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     border: Border.all(width: 4.0, color: Colors.white),
                //     shape: BoxShape.circle,
                //     color: AppTheme.primarySwatchColor,
                //   ),
                //   child:
                //       // Image(image: AssetImage('assets/icons/donate.png')),
                //       Image.asset(
                //     'assets/icons/cancel.png',
                //     // height: 50.0,
                //     color: Colors.white,
                //     fit: BoxFit.contain,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
