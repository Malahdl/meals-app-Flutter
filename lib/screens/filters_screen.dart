import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveChanges;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveChanges);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _GlutenFree = false;
  bool _LactoseFree = false;
  bool _Vegan = false;
  bool _Vegetarian = false;

  @override
  void initState() {
    _GlutenFree = widget.currentFilters['gluten']!;
    _LactoseFree = widget.currentFilters['lactose']!;
    _Vegan = widget.currentFilters['vegan']!;
    _Vegetarian = widget.currentFilters['vegetarian']!;

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      value: currentValue,
      subtitle: Text(description,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Filters'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _GlutenFree,
                    'lactose': _LactoseFree,
                    'vegan': _Vegan,
                    'vegetarian': _Vegetarian,
                  };
                  widget.saveChanges(selectedFilters);
                  Navigator.of(context).pushNamed('/');
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Adjust your meal selection!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile('Gluten-free',
                    'Only include Gluten-free meals.', _GlutenFree, (newValue) {
                  setState(() {
                    _GlutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free',
                    'Only include Lactose-free meals.',
                    _LactoseFree, (newValue) {
                  setState(() {
                    _LactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include Vegan meals.', _Vegan, (newValue) {
                  setState(() {
                    _Vegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only include Vegetarian meals.', _Vegetarian,
                    (newValue) {
                  setState(() {
                    _Vegetarian = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
