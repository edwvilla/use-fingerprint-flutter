import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fingerprint test'),
          centerTitle: true,
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _localAuth = LocalAuthentication();

  String canCheckBiometricsResult = '';

  String authenticateResult = '';

  List<BiometricType> availableBiometrics = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          shrinkWrap: true,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  canCheckBiometricsResult = await _localAuth.canCheckBiometrics
                      .then((value) => value.toString());

                  setState(() {});
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) => Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e.toString()),
                              ),
                            ),
                          ));
                }
              },
              child: Text('Can check biometrics'),
            ),
            Text(canCheckBiometricsResult),
            ElevatedButton(
              onPressed: () async {
                try {
                  authenticateResult = await _localAuth
                      .authenticate(
                          localizedReason: 'Autenticate para ingresar')
                      .then((value) => value.toString());
                  setState(() {});
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) => Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e.toString()),
                              ),
                            ),
                          ));
                }
              },
              child: Text('Authenticate'),
            ),
            Text(authenticateResult),
            ElevatedButton(
              onPressed: () async {
                try {
                  availableBiometrics =
                      await _localAuth.getAvailableBiometrics();
                  setState(() {});
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) => Center(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(e.toString()),
                              ),
                            ),
                          ));
                }
              },
              child: Text('Available biometrics'),
            ),
            ...availableBiometrics
                .map((biometricType) => Text(biometricType.toString())),
          ],
        ),
      ),
    );
  }
}
