import 'dart:async';

import 'package:algo/view/reusable_ui/reusable_bar.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class CounterModel extends ChangeNotifier {
  List<int> _numbers = [];
  String _currentSortAlgo = 'bubble';
  double _sampleSize = 350; //320
  bool isSorteda = false;
  bool isSorting = false;
  int speed = 0;
  static int duration = 1000;
  List<int> get numbers => _numbers;
  int counter = 0;

  // ====== time  counter
  int _milliseconds = 0;
  late Timer _timer;
  bool _isRunning = false;

  int get milliseconds => _milliseconds;

  bool get isRunning => _isRunning;
  //===================================

  CounterModel(BuildContext context) {
    _generateNumbers(context);
  }

  List<Widget> buildBars(BuildContext context) {
    List<Widget> bars = [];

    for (int i = 0; i < numbers.length; i++) {
      final value = numbers[i];
      bars.add(
        Container(
          child: CustomPaint(
            painter: BarPainter(
                index: i + 1,
                value: value,
                width: MediaQuery.of(context).size.width / _sampleSize),
          ),
        ),
      );
    }

    return bars;
  }

  void setSortAlgo(String type) {
    _currentSortAlgo = type;
  }

  void _generateNumbers(BuildContext context) {
    _sampleSize = MediaQuery.of(context).size.width / 2;
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    notifyListeners(); // Notify listeners after updating the state
  }

  Duration _getDuration() {
    return Duration(microseconds: duration);
  }

  void bubbleSort() async {
    restartTimer();
    startTimer();
    for (int i = 0; i < _numbers.length; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
        await Future.delayed(_getDuration(), () {});
        notifyListeners();
      }
    }
    isSorteda = false;
    stopTimer();
  }

  void recursiveBubbleSort(int n) async {
    restartTimer();
    startTimer();
    if (n == 1) {
      return;
    }
    for (int i = 0; i < n - 1; i++) {
      if (_numbers[i] > _numbers[i + 1]) {
        int temp = _numbers[i];
        _numbers[i] = _numbers[i + 1];
        _numbers[i + 1] = temp;
      }
      await Future.delayed(_getDuration());
      notifyListeners();
    }
    recursiveBubbleSort(n - 1);
    isSorteda = false;
    stopTimer();
  }

  void selectionSort() async {
    restartTimer();
    startTimer();
    for (int i = 0; i < _numbers.length; i++) {
      for (int j = i + 1; j < _numbers.length; j++) {
        if (_numbers[i] > _numbers[j]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[i];
          _numbers[i] = temp;
        }

        await Future.delayed(_getDuration(), () {});

        notifyListeners();
      }
    }
    isSorteda = false;
    stopTimer();
  }

  void heapSort() async {
    restartTimer();
    startTimer();
    for (int i = _numbers.length ~/ 2; i >= 0; i--) {
      await heapify(_numbers, _numbers.length, i);
      notifyListeners();
    }
    for (int i = _numbers.length - 1; i >= 0; i--) {
      int temp = _numbers[0];
      _numbers[0] = _numbers[i];
      _numbers[i] = temp;
      await heapify(_numbers, i, 0);
      notifyListeners();
    }
    isSorteda = false;
    stopTimer();
  }

  heapify(List<int> arr, int n, int i) async {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;

    if (r < n && arr[r] > arr[largest]) largest = r;

    if (largest != i) {
      int temp = _numbers[i];
      _numbers[i] = _numbers[largest];
      _numbers[largest] = temp;
      heapify(arr, n, largest);
    }
    await Future.delayed(_getDuration());
  }

  void insertionSort() async {
    restartTimer();
    startTimer();
    for (int i = 1; i < _numbers.length; i++) {
      int temp = _numbers[i];
      int j = i - 1;
      while (j >= 0 && temp < _numbers[j]) {
        _numbers[j + 1] = _numbers[j];
        --j;
        await Future.delayed(_getDuration(), () {});

        notifyListeners();
      }
      _numbers[j + 1] = temp;
      await Future.delayed(_getDuration(), () {});

      notifyListeners();
    }
    isSorteda = false;
    stopTimer();
  }

  cf(int a, int b) {
    if (a < b) {
      return -1;
    } else if (a > b) {
      return 1;
    } else {
      return 0;
    }
  }

  void quickSort(int leftIndex, int rightIndex) async {
    restartTimer();
    startTimer();
    Future<int> _partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = _numbers[p];
      _numbers[p] = _numbers[right];
      _numbers[right] = temp;
      await Future.delayed(_getDuration(), () {});

      notifyListeners();
      isSorteda = false;

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (cf(_numbers[i], _numbers[right]) <= 0) {
          var temp = _numbers[i];
          _numbers[i] = _numbers[cursor];
          _numbers[cursor] = temp;
          cursor++;

          await Future.delayed(_getDuration(), () {});

          notifyListeners();
        }
      }

      temp = _numbers[right];
      _numbers[right] = _numbers[cursor];
      _numbers[cursor] = temp;

      await Future.delayed(_getDuration(), () {});

      notifyListeners();

      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await _partition(leftIndex, rightIndex);

      quickSort(leftIndex, p - 1);

      quickSort(p + 1, rightIndex);
    }
    isSorteda = false;
    stopTimer();
  }

  void mergeSort(int leftIndex, int rightIndex) async {
    restartTimer();
    startTimer();
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List<int> leftList =
          List<int>.filled(leftSize, 0); // Specify the type as int
      List<int> rightList =
          List<int>.filled(rightSize, 0); // Specify the type as int

      for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++)
        rightList[j] = _numbers[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          _numbers[k] = leftList[i];
          i++;
        } else {
          _numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(_getDuration(), () {});
        notifyListeners();

        k++;
      }

      while (i < leftSize) {
        _numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(_getDuration(), () {});
        notifyListeners();
      }

      while (j < rightSize) {
        _numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(_getDuration(), () {});
        notifyListeners();
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      mergeSort(leftIndex, middleIndex);
      mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(_getDuration(), () {});

      notifyListeners();

      await merge(leftIndex, middleIndex, rightIndex);
    }

    isSorteda = false;
    stopTimer();
  }

  void shellSort() async {
    restartTimer();
    startTimer();
    for (int gap = _numbers.length ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < _numbers.length; i += 1) {
        int temp = _numbers[i];
        int j;
        for (j = i; j >= gap && _numbers[j - gap] > temp; j -= gap)
          _numbers[j] = _numbers[j - gap];
        _numbers[j] = temp;
        await Future.delayed(_getDuration());
        notifyListeners();
      }
    }
    isSorteda = false;
    stopTimer();
  }

  int getNextGap(int gap) {
    gap = (gap * 10) ~/ 13;

    if (gap < 1) return 1;
    return gap;
  }

  void combSort() async {
    restartTimer();
    startTimer();
    int gap = _numbers.length;

    bool swapped = true;

    while (gap != 1 || swapped == true) {
      gap = getNextGap(gap);

      swapped = false;

      for (int i = 0; i < _numbers.length - gap; i++) {
        if (_numbers[i] > _numbers[i + gap]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + gap];
          _numbers[i + gap] = temp;
          swapped = true;
        }
        await Future.delayed(_getDuration());
        notifyListeners();
      }
    }
    isSorteda = false;
    stopTimer();
  }

  void pigeonHole() async {
    restartTimer();
    startTimer();
    int min = _numbers[0];
    int max = _numbers[0];
    int range, i, j, index;
    for (int a = 0; a < _numbers.length; a++) {
      if (_numbers[a] > max) max = _numbers[a];
      if (_numbers[a] < min) min = _numbers[a];
    }
    range = max - min + 1;
    List<int> phole = new List.generate(range, (i) => 0);

    for (i = 0; i < _numbers.length; i++) {
      phole[_numbers[i] - min]++;
    }

    index = 0;

    for (j = 0; j < range; j++) {
      while (phole[j]-- > 0) {
        _numbers[index++] = j + min;
        await Future.delayed(_getDuration());
        notifyListeners();
      }
    }
    isSorteda = false;
    stopTimer();
  }

  void cycleSort() async {
    restartTimer();
    startTimer();
    int writes = 0;
    for (int cycleStart = 0; cycleStart <= _numbers.length - 2; cycleStart++) {
      int item = _numbers[cycleStart];
      int pos = cycleStart;
      for (int i = cycleStart + 1; i < _numbers.length; i++) {
        if (_numbers[i] < item) pos++;
      }

      if (pos == cycleStart) {
        continue;
      }

      while (item == _numbers[pos]) {
        pos += 1;
      }

      if (pos != cycleStart) {
        int temp = item;
        item = _numbers[pos];
        _numbers[pos] = temp;
        writes++;
      }

      while (pos != cycleStart) {
        pos = cycleStart;
        for (int i = cycleStart + 1; i < _numbers.length; i++) {
          if (_numbers[i] < item) pos += 1;
        }

        while (item == _numbers[pos]) {
          pos += 1;
        }

        if (item != _numbers[pos]) {
          int temp = item;
          item = _numbers[pos];
          _numbers[pos] = temp;
          writes++;
        }
        await Future.delayed(_getDuration());
        notifyListeners();
      }
    }
    isSorteda = false;
    stopTimer();
  }

  void cocktailSort() async {
    restartTimer();
    startTimer();
    bool swapped = true;
    int start = 0;
    int end = _numbers.length;

    while (swapped == true) {
      swapped = false;
      for (int i = start; i < end - 1; ++i) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          swapped = true;
        }
        await Future.delayed(_getDuration());
        notifyListeners();
      }
      if (swapped == false) break;
      swapped = false;
      end = end - 1;
      for (int i = end - 1; i >= start; i--) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          swapped = true;
        }
        await Future.delayed(_getDuration());
        notifyListeners();
      }
      start = start + 1;
    }
    isSorteda = false;
    stopTimer();
  }

  void gnomeSort() async {
    restartTimer();
    startTimer();
    int index = 0;

    while (index < _numbers.length) {
      if (index == 0) index++;
      if (_numbers[index] >= _numbers[index - 1])
        index++;
      else {
        int temp = _numbers[index];
        _numbers[index] = _numbers[index - 1];
        _numbers[index - 1] = temp;

        index--;
      }
      await Future.delayed(_getDuration());
      notifyListeners();
    }
    isSorteda = false;
    stopTimer();
    return;
  }

  void stoogesort(int l, int h) async {
    restartTimer();
    startTimer();
    if (l >= h) return;

    if (_numbers[l] > _numbers[h]) {
      int temp = _numbers[l];
      _numbers[l] = _numbers[h];
      _numbers[h] = temp;
      await Future.delayed(_getDuration());
      notifyListeners();
    }

    if (h - l + 1 > 2) {
      int t = (h - l + 1) ~/ 3;
      stoogesort(l, h - t);
      stoogesort(l + t, h);
      stoogesort(l, h - t);
    }
    isSorteda = false;
    stopTimer();
  }

  void oddEvenSort() async {
    restartTimer();
    startTimer();
    bool isSorted = false;

    while (!isSorted) {
      isSorted = true;

      for (int i = 1; i <= _numbers.length - 2; i = i + 2) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(_getDuration());
          notifyListeners();
        }
      }

      for (int i = 0; i <= _numbers.length - 2; i = i + 2) {
        if (_numbers[i] > _numbers[i + 1]) {
          int temp = _numbers[i];
          _numbers[i] = _numbers[i + 1];
          _numbers[i + 1] = temp;
          isSorted = false;
          await Future.delayed(_getDuration());
          notifyListeners();
        }
      }
    }
    isSorteda = false;
    stopTimer();
    return;
  }

  String getTitle() {
    switch (_currentSortAlgo) {
      case "bubble":
        return "Bubble Sort";
      case "coctail":
        return "Coctail Sort";
      case "pigeonhole":
        return "Pigeonhole Sort";
      case "recursivebubble":
        return "Recursive Bubble Sort";
      case "heap":
        return "Heap Sort";
      case "selection":
        return "Selection Sort";
      case "insertion":
        return "Insertion Sort";
      case "quick":
        return "Quick Sort";
      case "merge":
        return "Merge Sort";
      case "shell":
        return "Shell Sort";
      case "comb":
        return "Comb Sort";
      case "cycle":
        return "Cycle Sort";
      case "gnome":
        return "Gnome Sort";
      case "stooge":
        return "Stooge Sort";
      case "oddeven":
        return "Odd Even Sort";

      default:
        return "Unknown Sort";
    }
  }

  void listOfalog(BuildContext context) {
    // Define your sort algorithms here
    List<SortAlgorithm> sortAlgorithms = [
      SortAlgorithm(name: "Bubble Sort", value: "bubble"),
      SortAlgorithm(name: "Recursive Bubble Sort", value: "recursivebubble"),
      SortAlgorithm(name: "Heap Sort", value: "heap"),
      SortAlgorithm(name: "Selection Sort", value: "selection"),
      SortAlgorithm(name: "Insertion Sort", value: "insertion"),
      SortAlgorithm(name: "Quick Sort", value: "quick"),
      SortAlgorithm(name: "Merge Sort", value: "merge"),
      SortAlgorithm(name: "Shell Sort", value: "shell"),
      SortAlgorithm(name: "Comb Sort", value: "comb"),
      SortAlgorithm(name: "Pigeonhole Sort", value: "pigeonhole"),
      SortAlgorithm(name: "Cycle Sort", value: "cycle"),
      SortAlgorithm(name: "Coctail Sort", value: "coctail"),
      SortAlgorithm(name: "Gnome Sort", value: "gnome"),
      SortAlgorithm(name: "Stooge Sort", value: "stooge"),
      SortAlgorithm(name: "Odd Even Sort", value: "oddeven"),
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: sortAlgorithms.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(sortAlgorithms[index].name),
              onTap: () {
                Navigator.pop(context);
                reset();
                setSortAlgo(sortAlgorithms[index].value);
                print(sortAlgorithms[index].value);
                Future.delayed(Duration(microseconds: 500));
                sort(context);
              },
            );
          },
        );
      },
    );
  }

  _changeSpeed() {
    if (speed >= 3) {
      speed = 0;
      duration = 1000;
    } else {
      speed++;
      duration = duration ~/ 2;
    }

    print(speed.toString() + " " + duration.toString());
  }

  void checkAndResetIfSorted() async {
    if (isSorteda) {
      reset();
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  void sort(BuildContext context) async {
    isSorting = true;

    checkAndResetIfSorted();

    Stopwatch stopwatch = new Stopwatch()..start();

    switch (_currentSortAlgo) {
      case "comb":
        combSort();
        break;
      case "coctail":
        cocktailSort();
        break;
      case "bubble":
        bubbleSort();
        break;
      case "pigeonhole":
        pigeonHole();
        break;
      case "shell":
        shellSort();
        break;
      case "recursivebubble":
        recursiveBubbleSort(_sampleSize.toInt() - 1);
        break;
      case "selection":
        selectionSort();
        break;
      case "cycle":
        cycleSort();
        break;
      case "heap":
        heapSort();
        break;
      case "insertion":
        insertionSort();
        break;
      case "gnome":
        gnomeSort();
        break;
      case "oddeven":
        oddEvenSort();
        break;
      case "stooge":
        stoogesort(0, _sampleSize.toInt() - 1);
        break;
      case "quick":
        quickSort(0, _sampleSize.toInt() - 1);
        break;
      case "merge":
        mergeSort(0, _sampleSize.toInt() - 1);
        break;
    }

    stopwatch.stop();

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Sorting completed in ${stopwatch.elapsed.inMilliseconds} ms.",
        ),
      ),
    );

    isSorting = false;
    isSorteda = true;
  }

  void reset() {
    isSorteda = false;
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(550));
    }
    notifyListeners();
  }

  // milisecond counter

  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) {
        _milliseconds++;
        notifyListeners();
      });
    }
  }

  void stopTimer() {
    if (_isRunning) {
      _isRunning = false;
      _timer.cancel();
    }
  }

  void restartTimer() {
    stopTimer();
    _milliseconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  //=============================================================
}

class SortAlgorithm {
  final String name;
  final String value;

  SortAlgorithm({required this.name, required this.value});
}
