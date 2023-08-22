import 'package:flutter_test/flutter_test.dart';

import 'package:market_store/store.dart';

import '../example/AuthStore.dart';

void main() {
  test('adds one to input values', () {
    final authStore = AuthStore();



    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
