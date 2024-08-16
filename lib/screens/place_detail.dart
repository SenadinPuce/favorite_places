import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:favorite_places/screens/map.dart';
import 'package:favorite_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: FlutterMap(
                        options: MapOptions(
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.none,
                          ),
                          initialCenter: LatLng(
                            place.location.latitude,
                            place.location.longitude,
                          ),
                          initialZoom: 16.0,
                          onTap: (tapPosition, point) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MapScreen(
                                  location: place.location,
                                  isSelecting: false,
                                ),
                              ),
                            );
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          MarkerLayer(markers: [
                            Marker(
                              point: LatLng(
                                place.location.latitude,
                                place.location.longitude,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                size: 30,
                                color: Colors.red,
                              ),
                            ),
                          ])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
