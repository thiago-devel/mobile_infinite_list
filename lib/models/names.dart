import 'dart:math';

class Names {
  var _itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  String getRandomName() {
    return _getRandomNames()[0];
  }

  List<String> _getRandomNames() {
    return shuffle(_itemNames);
  }

  List<String> getRandomNames(int size) {
    if (size == null || size > (_itemNames.length - 1)) {
      print('Size [$size] is out of range!');
      return [];
    }

    var list = _getRandomNames().sublist(0, (size - 1));
    print(list);
    return list;
  }
}
