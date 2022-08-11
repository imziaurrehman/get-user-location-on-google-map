import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/provider/user-location-with-google-map.dart';
import 'package:googlemap/get-user-location.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final provider =
        Provider.of<UserLocationWithGoogleMap>(context, listen: false);
    provider.userLocationStatus();
    super.initState();
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    // final provider =
    //     Provider.of<UserLocationWithGoogleMap>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "google map",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.45,
              ),
              Consumer<UserLocationWithGoogleMap>(
                builder: (BuildContext context, UserLocationWithGoogleMap value,
                    Widget? child) {
                  return isloading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              setState(() {
                                isloading = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Userlocation(),
                                ),
                              );

                              await value.getuserloc().then((_) {
                                setState(() {
                                  isloading = false;
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                onPrimary: Colors.black87),
                            child: const Text("get user location"),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
