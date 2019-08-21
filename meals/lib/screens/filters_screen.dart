import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> filters;
  final Function setFilters;

  FiltersScreen(this.filters, this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _lactoseFree;
  bool _vegetarian;
  bool _vegan;

  @override
  initState() {
    super.initState();

    _glutenFree = widget.filters['gluten'];
    _lactoseFree = widget.filters['lactose'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
  }

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.setFilters(
                {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                },
              );
            },
          ),
        ],
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
