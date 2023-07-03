import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Graficzny interfejs użytkownika';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _imieController = TextEditingController();
  final _nazwiskoController = TextEditingController();
  final _poziomValueController = TextEditingController();
  int _poziom = 0;
  bool _isEnabled = false;
  String _imagePath = 'assets/images/user1.jpg';
  String? _firstNameError;
  String? _lastNameError;
  String? _poziomError;

  late FocusNode _imieFocusNode; //
  late FocusNode _nazwiskoFocusNode;//
  late FocusNode _poziomFocusNode;//

  @override
  void initState() {
    super.initState();
    _imieFocusNode = FocusNode(); //
    _nazwiskoFocusNode = FocusNode(); //
    _poziomFocusNode = FocusNode(); //
  }

  @override
  void dispose() {
    _imieController.dispose();
    _nazwiskoController.dispose();
    _poziomValueController.dispose();
    _imieFocusNode.dispose();
    _nazwiskoFocusNode.dispose();
    _poziomFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _validateFirstName(String value) {
      if (value.isEmpty) {
        setState(() {
          _firstNameError = 'To pole nie może być puste';
        });
      } else {
        setState(() {
          _firstNameError = null;
        });
      }
    }

    void _validateLastName(String value) {
      if (value.isEmpty) {
        setState(() {
          _lastNameError = 'To pole nie może być puste';
        });
      } else {
        setState(() {
          _lastNameError = null;
        });
      }
    }

    void _validatePoziom(String value) {
      if (value.isEmpty) {
        setState(() {
          _poziomError = 'To pole nie może być puste';
        });
      } else {
        int? poziom = int.tryParse(value);
        if (poziom == null || poziom < 0 || poziom > 100 || poziom % 4 != 0) {
          setState(() {
            _poziomError = 'Poziom musi być wartością z przedziału <0,100> podzielną przez 4';
          });
        } else {
          setState(() {
            _poziomError = null;
          });
        }
      }
    }

    void _showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: SnackBarAction(
            label: "OK",
            onPressed: () {},
          ),
        ),
      );
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(_imagePath),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Poziom: ${_poziomValueController.text}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _imieController,
              focusNode: _imieFocusNode,
              decoration: InputDecoration(
                labelText: 'Imię',
                errorText: _firstNameError,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'To pole nie może być puste';
                }
                return null;
              },
              onChanged: (value) {
                _validateFirstName(value);
              },
              onTap: () {
                if (_firstNameError != null) {
                  _showSnackBar(_firstNameError!);
                }
                setState(() {
                  _imieFocusNode.requestFocus();
                });
              },
              onEditingComplete: () {
                setState(() {
                  _imieFocusNode.unfocus();
                  _imieFocusNode.canRequestFocus = false;
                  _isEnabled = true;
                });
              },
            ),
            TextFormField(
              controller: _nazwiskoController,
              focusNode: _nazwiskoFocusNode,
              decoration: InputDecoration(
                labelText: 'Nazwisko',
                errorText: _lastNameError,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'To pole nie może być puste';
                }
                return null;
              },
              onChanged: (value) {
                _validateLastName(value);
              },
              onTap: () {
                if (_lastNameError != null) {
                  _showSnackBar(_lastNameError!);
                }
                setState(() {
                  _nazwiskoFocusNode.requestFocus();
                });
              },
              onEditingComplete: () {
                setState(() {
                  _nazwiskoFocusNode.unfocus();
                  _nazwiskoFocusNode.canRequestFocus = false;
                  _isEnabled = true;
                });
              },
            ),
            TextFormField(
              controller: _poziomValueController,
              focusNode: _poziomFocusNode,
              decoration: InputDecoration(
                labelText: 'Poziom',
                errorText: _poziomError,
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'To pole nie może być puste';
                }
                int? poziom = int.tryParse(value);
                if (poziom == null || poziom < 0 || poziom > 100 || poziom % 4 != 0) {
                  return 'Poziom musi być wartością z przedziału <0,100> podzielną przez 4';
                }
                return null;
              },
              onSaved: (value) {
                _poziom = int.parse(value!);
              },
              onChanged: (value) {
                setState(() {
                  _poziomValueController.text = value;
                });
                _validatePoziom(value);
              },
              onTap: () {
                if (_poziomError != null) {
                  _showSnackBar(_poziomError!);
                }
                setState(() {
                  _poziomFocusNode.requestFocus();
                });
              },
              onEditingComplete: () {
                setState(() {
                  _poziomFocusNode.unfocus();
                  _poziomFocusNode.canRequestFocus = false;
                  _isEnabled = true;
                });
              },
            ),
            Slider(
              value: double.tryParse(_poziomValueController.text) ?? 0,
              min: 0,
              max: 100,
              divisions: 25,
              label: _poziomValueController.text,
              onChanged: _isEnabled
                  ? (value) {
                setState(() {
                  _poziomValueController.text = value.round().toString();
                });
              }
                  : null,
            ),
            TextButton(
              child: const Text('Zapisz'),
              onPressed: _isEnabled
                  ? () {
                if (_formKey.currentState!.validate()) {
                  if (_firstNameError == null && _lastNameError == null && _poziomError == null) {
                    _formKey.currentState?.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          imie: _imieController.text,
                          nazwisko: _nazwiskoController.text,
                          poziom: _poziom,
                          imagePath: _imagePath,
                        ),
                      ),
                    );
                  } else {
                    _showSnackBar('Proszę poprawić błędy przed zapisaniem');
                  }
                }
              }
                  : null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEnabled = false;
            _imieFocusNode.canRequestFocus = true;
            _imieController.clear();
            _nazwiskoFocusNode.canRequestFocus = true;
            _nazwiskoController.clear();
            _poziomFocusNode.canRequestFocus = true;
            _poziomValueController.clear();
            _imieFocusNode.requestFocus();
          });
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}


class SecondScreen extends StatelessWidget {
  final String imie;
  final String nazwisko;
  final int poziom;
  final String imagePath;

  const SecondScreen(
      {
        required this.imie,
        required this.nazwisko,
        required this.poziom,
        required this.imagePath,
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dane'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 8),
            Text('Imię: $imie'),
            Text('Nazwisko: $nazwisko'),
            Text('Poziom: $poziom'),
            const SizedBox(height: 16),
            Image.asset(imagePath, height: 100, width: 100),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Edytuj dane'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}