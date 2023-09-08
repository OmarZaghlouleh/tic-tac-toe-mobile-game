import 'dart:math';

class Player {
  static List<int> PlayerX = [];
  static List<int> PlayerO = [];

  static void playgame(int index, String currentplayer) {
    if (!PlayerX.contains(index) && !PlayerO.contains(index)) {
      if (currentplayer == 'X') {
        PlayerX.add(index);
      } else {
        PlayerO.add(index);
      }
    }
  }

  static void autoplay(String currentplayer) {
    //******Attacking *****//
    //Rows Checking
    if (PlayerO.containAll(0, 1) &&
        !PlayerX.contains(2) &&
        !PlayerO.contains(2) &&
        currentplayer == 'O')
      PlayerO.add(2);
    else if (PlayerO.containAll(1, 2) &&
        !PlayerX.contains(0) &&
        !PlayerO.contains(0) &&
        currentplayer == 'O')
      PlayerO.add(0);
    else if (PlayerO.containAll(0, 2) &&
        !PlayerX.contains(1) &&
        !PlayerO.contains(1) &&
        currentplayer == 'O')
      PlayerO.add(1);
    else if (PlayerO.containAll(0, 2) &&
        !PlayerX.contains(1) &&
        !PlayerO.contains(1) &&
        currentplayer == 'O')
      PlayerO.add(1);
    else if (PlayerO.containAll(3, 4) &&
        !PlayerX.contains(5) &&
        !PlayerO.contains(5) &&
        currentplayer == 'O')
      PlayerO.add(5);
    else if (PlayerO.containAll(4, 5) &&
        !PlayerX.contains(3) &&
        !PlayerO.contains(3) &&
        currentplayer == 'O')
      PlayerO.add(3);
    else if (PlayerO.containAll(3, 5) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerO.containAll(6, 7) &&
        !PlayerX.contains(8) &&
        !PlayerO.contains(8) &&
        currentplayer == 'O')
      PlayerO.add(8);
    else if (PlayerO.containAll(7, 8) &&
        !PlayerX.contains(6) &&
        !PlayerO.contains(6) &&
        currentplayer == 'O')
      PlayerO.add(6);
    else if (PlayerO.containAll(6, 8) &&
        !PlayerX.contains(7) &&
        !PlayerO.contains(7) &&
        currentplayer == 'O')
      PlayerO.add(7);

    //Columns Checking
    else if (PlayerO.containAll(0, 3) &&
        !PlayerX.contains(6) &&
        !PlayerO.contains(6) &&
        currentplayer == 'O')
      PlayerO.add(6);
    else if (PlayerO.containAll(3, 6) &&
        !PlayerX.contains(0) &&
        !PlayerO.contains(0) &&
        currentplayer == 'O')
      PlayerO.add(0);
    else if (PlayerO.containAll(0, 6) &&
        !PlayerX.contains(3) &&
        !PlayerO.contains(3) &&
        currentplayer == 'O')
      PlayerO.add(3);
    else if (PlayerO.containAll(1, 4) &&
        !PlayerX.contains(7) &&
        !PlayerO.contains(7) &&
        currentplayer == 'O')
      PlayerO.add(7);
    else if (PlayerO.containAll(4, 7) &&
        !PlayerX.contains(1) &&
        !PlayerO.contains(1) &&
        currentplayer == 'O')
      PlayerO.add(1);
    else if (PlayerO.containAll(1, 7) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerO.containAll(3, 5) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerO.containAll(2, 5) &&
        !PlayerX.contains(8) &&
        !PlayerO.contains(8) &&
        currentplayer == 'O')
      PlayerO.add(8);
    else if (PlayerO.containAll(5, 8) &&
        !PlayerX.contains(2) &&
        !PlayerO.contains(2) &&
        currentplayer == 'O')
      PlayerO.add(2);
    else if (PlayerO.containAll(2, 8) &&
        !PlayerX.contains(5) &&
        !PlayerO.contains(5) &&
        currentplayer == 'O')
      PlayerO.add(5);

    //Cross Checikng

    else if (PlayerO.containAll(0, 4) &&
        !PlayerX.contains(8) &&
        !PlayerO.contains(8) &&
        currentplayer == 'O')
      PlayerO.add(8);
    else if (PlayerO.containAll(4, 8) &&
        !PlayerX.contains(0) &&
        !PlayerO.contains(0) &&
        currentplayer == 'O')
      PlayerO.add(0);
    else if (PlayerO.containAll(0, 8) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerO.containAll(2, 4) &&
        !PlayerX.contains(6) &&
        !PlayerO.contains(6) &&
        currentplayer == 'O')
      PlayerO.add(6);
    else if (PlayerO.containAll(4, 6) &&
        !PlayerX.contains(2) &&
        !PlayerO.contains(2) &&
        currentplayer == 'O')
      PlayerO.add(3);
    else if (PlayerO.containAll(2, 6) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);

    //*****Defending*****//

    //Rows Checking
    else if (PlayerX.containAll(0, 1) &&
        !PlayerX.contains(2) &&
        !PlayerO.contains(2) &&
        currentplayer == 'O')
      PlayerO.add(2);
    else if (PlayerX.containAll(1, 2) &&
        !PlayerX.contains(0) &&
        !PlayerO.contains(0) &&
        currentplayer == 'O')
      PlayerO.add(0);
    else if (PlayerX.containAll(0, 2) &&
        !PlayerX.contains(1) &&
        !PlayerO.contains(1) &&
        currentplayer == 'O')
      PlayerO.add(1);
    else if (PlayerX.containAll(0, 2) &&
        !PlayerX.contains(1) &&
        !PlayerO.contains(1) &&
        currentplayer == 'O')
      PlayerO.add(1);
    else if (PlayerX.containAll(3, 4) &&
        !PlayerX.contains(5) &&
        !PlayerO.contains(5) &&
        currentplayer == 'O')
      PlayerO.add(5);
    else if (PlayerX.containAll(4, 5) &&
        !PlayerX.contains(3) &&
        !PlayerO.contains(3) &&
        currentplayer == 'O')
      PlayerO.add(3);
    else if (PlayerX.containAll(3, 5) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerX.containAll(6, 7) &&
        !PlayerX.contains(8) &&
        !PlayerO.contains(8) &&
        currentplayer == 'O')
      PlayerO.add(8);
    else if (PlayerX.containAll(7, 8) &&
        !PlayerX.contains(6) &&
        !PlayerO.contains(6) &&
        currentplayer == 'O')
      PlayerO.add(6);
    else if (PlayerX.containAll(6, 8) &&
        !PlayerX.contains(7) &&
        !PlayerO.contains(7) &&
        currentplayer == 'O')
      PlayerO.add(7);

    //Columns Checking
    else if (PlayerX.containAll(0, 3) &&
        !PlayerX.contains(6) &&
        !PlayerO.contains(6) &&
        currentplayer == 'O')
      PlayerO.add(6);
    else if (PlayerX.containAll(3, 6) &&
        !PlayerX.contains(0) &&
        !PlayerO.contains(0) &&
        currentplayer == 'O')
      PlayerO.add(0);
    else if (PlayerX.containAll(0, 6) &&
        !PlayerX.contains(3) &&
        !PlayerO.contains(3) &&
        currentplayer == 'O')
      PlayerO.add(3);
    else if (PlayerX.containAll(1, 4) &&
        !PlayerX.contains(7) &&
        !PlayerO.contains(7) &&
        currentplayer == 'O')
      PlayerO.add(7);
    else if (PlayerX.containAll(4, 7) &&
        !PlayerX.contains(1) &&
        !PlayerO.contains(1) &&
        currentplayer == 'O')
      PlayerO.add(1);
    else if (PlayerX.containAll(1, 7) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerX.containAll(3, 5) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerX.containAll(2, 5) &&
        !PlayerX.contains(8) &&
        !PlayerO.contains(8) &&
        currentplayer == 'O')
      PlayerO.add(8);
    else if (PlayerX.containAll(5, 8) &&
        !PlayerX.contains(2) &&
        !PlayerO.contains(2) &&
        currentplayer == 'O')
      PlayerO.add(2);
    else if (PlayerX.containAll(2, 8) &&
        !PlayerX.contains(5) &&
        !PlayerO.contains(5) &&
        currentplayer == 'O')
      PlayerO.add(5);

    //Cross Checking

    else if (PlayerX.containAll(0, 4) &&
        !PlayerX.contains(8) &&
        !PlayerO.contains(8) &&
        currentplayer == 'O')
      PlayerO.add(8);
    else if (PlayerX.containAll(4, 8) &&
        !PlayerX.contains(0) &&
        !PlayerO.contains(0) &&
        currentplayer == 'O')
      PlayerO.add(0);
    else if (PlayerX.containAll(0, 8) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else if (PlayerX.containAll(2, 4) &&
        !PlayerX.contains(6) &&
        !PlayerO.contains(6) &&
        currentplayer == 'O')
      PlayerO.add(6);
    else if (PlayerX.containAll(4, 6) &&
        !PlayerX.contains(2) &&
        !PlayerO.contains(2) &&
        currentplayer == 'O')
      PlayerO.add(3);
    else if (PlayerX.containAll(2, 6) &&
        !PlayerX.contains(4) &&
        !PlayerO.contains(4) &&
        currentplayer == 'O')
      PlayerO.add(4);
    else {
      Random random = Random();
      List<int> availableindex = [];
      for (int i = 0; i < 9; i++) {
        if (!PlayerO.contains(i) && !PlayerX.contains(i)) {
          availableindex.add(i);
        }
      }
      int randomindex = random.nextInt(availableindex.length);
      if (currentplayer == 'x') {
        PlayerX.add(availableindex[randomindex]);
      } else {
        PlayerO.add(availableindex[randomindex]);
      }
    }
  }

  static List<dynamic> checkwinner() {
    List<dynamic> results = ['', false];
    if (PlayerX.containAll(0, 1, 2) ||
        PlayerX.containAll(3, 4, 5) ||
        PlayerX.containAll(6, 7, 8) ||
        PlayerX.containAll(0, 3, 6) ||
        PlayerX.containAll(1, 4, 7) ||
        PlayerX.containAll(2, 5, 8) ||
        PlayerX.containAll(0, 4, 8) ||
        PlayerX.containAll(2, 4, 6)) {
      results[0] = 'X';
      results[1] = true;
    } else if (PlayerX.containAll(0, 1, 2) ||
        PlayerO.containAll(3, 4, 5) ||
        PlayerO.containAll(6, 7, 8) ||
        PlayerO.containAll(0, 3, 6) ||
        PlayerO.containAll(1, 4, 7) ||
        PlayerO.containAll(2, 5, 8) ||
        PlayerO.containAll(0, 4, 8) ||
        PlayerO.containAll(2, 4, 6)) {
      results[0] = 'O';
      results[1] = true;
    }
    return results;
  }
}

//ContainsAll Function (Extension)
extension containsAll on List {
  containAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}
