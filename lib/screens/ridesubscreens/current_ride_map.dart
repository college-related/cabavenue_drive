// ignore_for_file: depend_on_referenced_packages

import 'package:cabavenue_drive/providers/ride_request_provider.dart';
// import 'package:cabavenue_drive/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart' as vector_theme;

class CurrentRideMapScreen extends StatefulWidget {
  const CurrentRideMapScreen({Key? key}) : super(key: key);

  @override
  State<CurrentRideMapScreen> createState() => _CurrentRideMapScreenState();
}

class _CurrentRideMapScreenState extends State<CurrentRideMapScreen> {
  double initialDestinationContainerPosition = 540.0;

  final MapController _mapController = MapController();
  LocationData? currentLocation;

  // final NotificationService _notificationService = NotificationService();
  dynamic sourceLocation;
  // dynamic destinationLocation;
  List drivers = [];
  String price = '';

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      _mapController.move(LatLng(newLoc.latitude!, newLoc.longitude!), 18);
    });
    setState(() {});
  }

  void getInitialLocation() async {
    currentLocation = await Location().getLocation();
  }

  @override
  void initState() {
    super.initState();

    getInitialLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  VectorTileProvider _cachingTileProvider(String urlTemplate) {
    return MemoryCacheVectorTileProvider(
      delegate: NetworkVectorTileProvider(
        urlTemplate: urlTemplate,
        maximumZoom: 14,
      ),
      maxSizeBytes: 1024 * 1024 * 2,
    );
  }

  _mapTheme(BuildContext context) {
    return vector_theme.ProvidedThemes.lightTheme();
  }

  String _urlTemplate() {
    // return 'https://api.maptiler.com/tiles/v3-4326/tiles.json?key=x0zt2WeTRQEvX2oFs7PX';
    return 'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=ed923bf6-7a17-4cec-aada-832cdb4050e7';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RideRequestProvider>(
      builder: (context, value, child) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            zoom: 18,
            center: LatLng(
              currentLocation?.latitude ?? 28.2624061,
              currentLocation?.longitude ?? 83.9687894,
            ),
            plugins: [VectorMapTilesPlugin()],
          ),
          layers: [
            VectorTileLayerOptions(
                theme: _mapTheme(context),
                tileProviders: TileProviders({
                  'openmaptiles': _cachingTileProvider(_urlTemplate()),
                })),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 20.0,
                  height: 20.0,
                  point: LatLng(
                    currentLocation?.latitude ?? 28.2624061,
                    currentLocation?.longitude ?? 83.9687894,
                  ),
                  builder: (ctx) => Icon(
                    Iconsax.direct_up5,
                    size: 22,
                    color: Colors.purple[600],
                    shadows: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 8,
                        blurRadius: 10,
                        offset: const Offset(2, 5),
                      ),
                    ],
                  ),
                ),
                value.getRideRequestListData[value.rideIndex ?? 0]
                            .destination !=
                        null
                    ? Marker(
                        width: 20.0,
                        height: 20.0,
                        point: LatLng(
                          value.getRideRequestListData[value.rideIndex ?? 0]
                              .destination['latitude'],
                          value.getRideRequestListData[value.rideIndex ?? 0]
                              .destination['longitude'],
                        ),
                        builder: (ctx) => Icon(
                          Iconsax.gps5,
                          size: 22,
                          color: Colors.red[600],
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 8,
                              blurRadius: 10,
                              offset: const Offset(2, 5),
                            ),
                          ],
                        ),
                      )
                    : Marker(
                        width: 0.0,
                        height: 0.0,
                        point: LatLng(
                          28.223877,
                          83.987730,
                        ),
                        builder: (ctx) => Icon(
                          Iconsax.gps5,
                          size: 0,
                          color: Colors.black,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 8,
                              blurRadius: 10,
                              offset: const Offset(2, 5),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
