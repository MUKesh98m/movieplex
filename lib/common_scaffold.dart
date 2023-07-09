import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview/apppreference.dart';
import 'package:webview/constant.dart';
import 'package:webview/home_screen.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({Key? key, required this.body}) : super(key: key);
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        drawer: Drawer(
          child: Container(
            color:
                Colors.black, // Set the background color of the drawer content
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black87, // Set the color of the drawer header
                  ),
                  accountName: Text(AppString.name,
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.white,
                      )),
                  accountEmail: Text(AppString.email,
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.white,
                      )),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(AppString.home,
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.white,
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyWebView(),
                        ));
                  },
                ),
                ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    title: Text(AppString.rateApp,
                        style: GoogleFonts.abyssinicaSil(
                          color: Colors.white,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                      final dialog = RatingDialog(
                        starSize: 35,

                        initialRating: 1.0,
                        // your app's name?
                        title: Text(AppString.ratingDialog,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.abyssinicaSil(
                              color: Colors.white,
                            )),

                        message: const Text(
                          AppString.ratingDisc,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),

                        image: const FlutterLogo(size: 100),
                        submitButtonText: AppString.submit,

                        commentHint: AppString.comment,
                        onCancelled: () {},
                        onSubmitted: (response) {
                          // TODO: add your own logic
                          if (response.rating < 3.0) {
                          } else {}
                        },
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        barrierDismissible:
                            true, // set to false if you want to force a rating
                        builder: (context) => dialog,
                      );
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  title: Text(AppString.share,
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.white,
                      )),
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.gameloft.android.ANMP.GloftA8HM',
                        subject: 'Share MoviePlex App');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                  title: Text(
                      '${AppString.version}${AppPreference.getString(AppString.buildNumber)}',
                      style: GoogleFonts.abyssinicaSil(
                        color: Colors.white,
                      )),
                  onTap: () {
                    // Add your settings functionality here
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(AppString.appName,
              style:
                  GoogleFonts.abyssinicaSil(color: Colors.white, fontSize: 30)),

        ),
        body: body);
  }
}
