// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {
  group('login test', () {
    FlutterDriver driver;

    //TODO: Move this methods to a future class that encapsulate framework actions
    Future<void> tap(SerializableFinder element) async {
      await driver.tap(element);
    }

    Future<void> type(SerializableFinder element, String text) async {
      await tap(element);
      await driver.enterText(text);
    }

    SerializableFinder findByKey(String key) {
      return find.byValueKey(key);
    }

    Future<String> getText(SerializableFinder element) async {
      return driver.getText(element);
    }

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        //await driver.close();
      }
    });

    //TODO: Use screen objects :)
    test('should login with valid credentials', () async {

      SerializableFinder emailInput = findByKey("email_input");
      SerializableFinder passwordInput = findByKey("password_input");
      await type(emailInput, "hej@hej.dk");
      await type(passwordInput, "hejmeddig");

      SerializableFinder loginButton = findByKey("login_button");
      await tap(loginButton);
    });
  });
}