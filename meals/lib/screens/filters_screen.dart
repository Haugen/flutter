import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  Widget _buildFilterListTile(
      String title, String subtitle, bool filter, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: filter,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildFilterListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) => setState(
                    () {
                      _glutenFree = newValue;
                    },
                  ),
                ),
                _buildFilterListTile(
                  'Laactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) => setState(
                    () {
                      _lactoseFree = newValue;
                    },
                  ),
                ),
                _buildFilterListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (newValue) => setState(
                    () {
                      _vegetarian = newValue;
                    },
                  ),
                ),
                _buildFilterListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (newValue) => setState(
                    () {
                      _vegan = newValue;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
