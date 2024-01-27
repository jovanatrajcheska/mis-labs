import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'mis-lab-2',
      home: MyApp(),
    ),
  );
}

class Clothes {
  String type;
  String color;

  Clothes({required this.type, required this.color});
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Clothes> clothes = [];
  String currType = 'T-shirt';
  String currColor = 'Pink';
  String typeEdit = '';
  String colorEdit = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clothes App'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showAddClothesDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Add clothes',
                  style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 30),
            const Text('All clothes:',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            Expanded(
              child: ListView.builder(
                itemCount: clothes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${clothes[index].type} - ${clothes[index].color}',
                        style:
                        const TextStyle(color: Colors.blue, fontSize: 18)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditClothesDialog(index),
                          color: Colors.green,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteClothes(index),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddClothesDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add clothes'),
          content: Column(
            children: [
              _buildTypeDropdown(currType),
              _buildColorDropdown(currColor),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                _addClothes();
                Navigator.pop(context);
              },
              child: const Text('Confirm',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTypeDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currType) {
            currType = value!;
          } else if (currentValue == typeEdit) {
            typeEdit = value!;
          }
        });
      },
      items: ['T-shirt', 'Jeans', 'Jacket', 'Dress', 'Skirt', 'Cardigan']
          .map<DropdownMenuItem<String>>((String type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(type),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Type', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  Widget _buildColorDropdown(String currentValue) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      onChanged: (value) {
        setState(() {
          if (currentValue == currColor) {
            currColor = value!;
          } else if (currentValue == colorEdit) {
            colorEdit = value!;
          }
        });
      },
      items: ['Blue', 'Green', 'Purple', 'Pink', 'Black', 'White', 'Orange', 'Yellow']
          .map<DropdownMenuItem<String>>((String color) {
        return DropdownMenuItem<String>(
          value: color,
          child: Text(color),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: 'Select Color', labelStyle: TextStyle(color: Colors.blue)),
    );
  }

  void _addClothes() {
    if (currType.isNotEmpty && currColor.isNotEmpty) {
      setState(() {
        clothes.add(Clothes(type: currType, color: currColor));
      });
    }
  }

  void _showEditClothesDialog(int index) {
    typeEdit = clothes[index].type;
    colorEdit = clothes[index].color;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit clothes'),
          content: Column(
            children: [
              _buildTypeDropdown(typeEdit),
              _buildColorDropdown(colorEdit),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                _editClothes(index);
                Navigator.pop(context);
              },
              child: const Text('Save',
                  style: TextStyle(
                      backgroundColor: Colors.green, color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editClothes(int index) {
    if (typeEdit.isNotEmpty && colorEdit.isNotEmpty) {
      setState(() {
        clothes[index].type = typeEdit;
        clothes[index].color = colorEdit;
      });
    }
  }

  void _deleteClothes(int index) {
    setState(() {
      clothes.removeAt(index);
    });
  }
}