import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:webview/controller/home_controller.dart';
import 'package:webview/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common_scaffold.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  @override
  void initState() {
    super.initState();

    // Enable hybrid composition.
    MobileAds.instance.initialize().then((InitializationStatus status) {
      Provider.of<HomeController>(context, listen: false).loadAppOpenAd();
    });
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    Provider.of<HomeController>(context, listen: false).loadAd();
  }

  @override
  void dispose() {
    final controller = Provider.of<HomeController>(context, listen: false);
    controller.appOpenAd.dispose();
    controller.ad.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return CommonScaffold(
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.22,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: GridView.builder(
                  itemCount: controller.movieList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 200,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage(url: controller.movieLink[index]),
                            ));
                      },
                      child: GridTile(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 20,
                            color: Colors.black,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    controller.movieImage[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 185,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          // Replace 10.0 with your desired border radius value
                                          bottomRight: Radius.circular(
                                              10.0), // Replace 10.0 with your desired border radius value
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      controller.movieList[index].toUpperCase(),
                                      style: GoogleFonts.abyssinicaSil(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      /*const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),*/
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (controller.isAdLoaded)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: controller.ad.size.height.toDouble(),
                    child: AdWidget(ad: controller.ad),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
