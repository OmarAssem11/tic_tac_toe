import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';
  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [int? z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void play(int index, String activePlayer) {
    if (activePlayer == 'X') {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  bool won(List<int> list) {
    if (list.containsAll(0, 1, 2) ||
        list.containsAll(3, 4, 5) ||
        list.containsAll(6, 7, 8) ||
        list.containsAll(0, 3, 6) ||
        list.containsAll(1, 4, 7) ||
        list.containsAll(2, 5, 8) ||
        list.containsAll(0, 4, 8) ||
        list.containsAll(2, 4, 6)) {
      return true;
    } else {
      return false;
    }
  }

  String checkWinner() {
    if (won(Player.playerX)) {
      return 'X';
    } else if (won(Player.playerO)) {
      return 'O';
    } else {
      return '';
    }
  }

  Future<void> autoPlay(String activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    for (int i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }
    //Attack
    //start & mid
    if (Player.playerO.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerO.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //start & end
    else if (Player.playerO.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerO.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerO.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerO.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
    }
    //end & mid
    else if (Player.playerO.containsAll(2, 1) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(5, 4) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerO.containsAll(8, 7) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerO.containsAll(6, 3) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(7, 4) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerO.containsAll(8, 5) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerO.containsAll(8, 4) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerO.containsAll(6, 4) && emptyCells.contains(2)) {
      index = 2;
    }
    //Defence
    //start & mid
    else if (Player.playerX.containsAll(0, 1) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsAll(3, 4) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsAll(6, 7) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(0, 3) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(1, 4) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(2, 5) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(0, 4) && emptyCells.contains(8)) {
      index = 8;
    } else if (Player.playerX.containsAll(2, 4) && emptyCells.contains(6)) {
      index = 6;
    }
    //start & end
    else if (Player.playerX.containsAll(0, 2) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsAll(3, 5) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(6, 8) && emptyCells.contains(7)) {
      index = 7;
    } else if (Player.playerX.containsAll(0, 6) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsAll(1, 7) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 8) && emptyCells.contains(5)) {
      index = 5;
    } else if (Player.playerX.containsAll(0, 8) && emptyCells.contains(4)) {
      index = 4;
    } else if (Player.playerX.containsAll(2, 6) && emptyCells.contains(4)) {
      index = 4;
    }
    //end & mid
    else if (Player.playerX.containsAll(2, 1) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(5, 4) && emptyCells.contains(3)) {
      index = 3;
    } else if (Player.playerX.containsAll(8, 7) && emptyCells.contains(6)) {
      index = 6;
    } else if (Player.playerX.containsAll(6, 3) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(7, 4) && emptyCells.contains(1)) {
      index = 1;
    } else if (Player.playerX.containsAll(8, 5) && emptyCells.contains(2)) {
      index = 2;
    } else if (Player.playerX.containsAll(8, 4) && emptyCells.contains(0)) {
      index = 0;
    } else if (Player.playerX.containsAll(6, 4) && emptyCells.contains(2)) {
      index = 2;
    }
    //first move
    else if (emptyCells.contains(4)) {
      index = 4;
    } else if (emptyCells.contains(0)) {
      index = 0;
    } else {
      var random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
    }
    play(index, activePlayer);
  }
}
