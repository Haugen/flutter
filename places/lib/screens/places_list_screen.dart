import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<GreatPlaces>(
              child: Center(
                child: Text('No places yet. Start adding some.'),
              ),
              builder: (ctx, greatPlaces, child) {
                if (greatPlaces.items.isEmpty) return child;

                return ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(greatPlaces.items[i].image),
                      ),
                      title: Text(greatPlaces.items[i].title),
                      onTap: () {
                        // Go to detail page.
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
