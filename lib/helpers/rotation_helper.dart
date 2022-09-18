class RotationHelper {
  getRotationByIndex(int players, int index) {
    if (players == 2) {
      return [2, 0][index];
    }
    final list = List<int>.generate(players, (index) {
      if (index % 2 == 0) {
        if (players % 2 != 0 && index == players - 1) {
          return 0;
        }
        return 1;
      } else {
        return 3;
      }
    });

    return list[index];
  }
}
