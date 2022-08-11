// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'provider/user-location-with-google-map.dart';

class Userlocation extends StatefulWidget {
  const Userlocation({Key? key}) : super(key: key);

  @override
  State<Userlocation> createState() => _UserlocationState();
}

class _UserlocationState extends State<Userlocation> {
  @override
  Widget build(BuildContext context) {
    // final provider =
    //     Provider.of<UserLocationWithGoogleMap>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "user current location status",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.18, vertical: size.height * 0.12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<UserLocationWithGoogleMap>(
                builder: (context, value, child) {
                  return Center(
                    child: ListTile(
                      title: Text("latitude:\t${value.getlat}",
                          textScaleFactor: 1.2),
                      subtitle: Text("\nlongitude:\t${value.getlon}",
                          textScaleFactor: 1.25),
                      leading: const Icon(Icons.location_on,
                          color: Color.fromARGB(219, 244, 67, 54), size: 35),
                      trailing: const Text(""),
                    ),
                  );
                },
              ),
              const Divider(color: Colors.grey, thickness: 0.8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // take user location to google map and add marker to it.
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoogleMapDeployment(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(onPrimary: Colors.black87),
                  child: const Text("Take Me To Google Map"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class GoogleMapDeployment extends StatelessWidget {
  GoogleMapDeployment({Key? key}) : super(key: key);
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markers(BuildContext context) {
    final loc = Provider.of<UserLocationWithGoogleMap>(context);
    return [
      Marker(
        markerId: const MarkerId("m1"),
        // icon: ,
        visible: true,
        position: LatLng(loc.getlat!, loc.getlon!),
        infoWindow: const InfoWindow(
            title: "My Location",
            snippet:
                "Hytabd Phase no.6 , street no.1 , sector no.f6 , house no.19"),
        draggable: true,
        // onDrag: (_) async {
        //   GoogleMapController controller = await _controller.future;
        //   controller.animateCamera(CameraUpdate.newCameraPosition(
        //       CameraPosition(
        //           target: LatLng(loc.getlat!, loc.getlon!), zoom: 20.56)));
        // },
      ),
    ];
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Show Me on Google Map",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: Stack(
          children: <Widget>[
            Consumer<UserLocationWithGoogleMap>(
              builder: (context, value, child) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(value.lat!, value.getlon!), zoom: 14.05),
                  markers: Set<Marker>.from(markers(context)),
                );
              },
            ),
          ],
        ));
  }
}
