import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyMaterialAppTwo extends StatelessWidget {
  const MyMaterialAppTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: App2());
  }
}

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  final _cntKey = TextEditingController();
  final _cntValue = TextEditingController();
  final _boxData = Hive.box('data');
  String hiveData = '';

  @override
  void initState() {
    super.initState();
    hiveData = _boxData.toMap().toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('App 1')),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Key:  '),
                  SizedBox(
                    width: 100,
                    child: TextField(controller: _cntKey),
                  ),
                  const SizedBox(width: 20),
                  const Text('Value:  '),
                  SizedBox(
                    width: 100,
                    child: TextField(controller: _cntValue),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _boxData.put(_cntKey.text, _cntValue.text);
                  setState(() {
                    _cntKey.text = '';
                    _cntValue.text = '';
                    hiveData = _boxData.toMap().toString();
                  });
                },
                child: const Text('Save to Hive'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _boxData.clear();
                  });
                },
                child: const Text('Clear Hive data'),
              ),
              const SizedBox(height: 20),
              const Text('Hive data:'),
              Text(hiveData),
            ],
          ),
        ),
      ),
    );
  }
}
