import 'package:flutter/material.dart';

class LevelSelector extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final Function(int) onValueChanged;

  const LevelSelector({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.onValueChanged,
  });

  @override
  LevelSelectorState createState() => LevelSelectorState();
}

class LevelSelectorState extends State<LevelSelector> {
  late int selectedLevel;
  late ScrollController _scrollController;
  final double _itemWidth = 53.0;

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.initialValue;
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected(animate: false));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _changeLevel(int newLevel) {
    setState(() {
      selectedLevel = newLevel.clamp(widget.minValue, widget.maxValue);
    });
    widget.onValueChanged(selectedLevel);
    _scrollToSelected();
  }

  void _scrollToSelected({bool animate = true}) {
    if (!_scrollController.hasClients) return;

    final selectedIndex = selectedLevel - widget.minValue;
    final scrollViewWidth = _scrollController.position.viewportDimension;
    final maxScroll = _scrollController.position.maxScrollExtent;

    double targetScroll = (selectedIndex * _itemWidth) - (scrollViewWidth / 2) + (_itemWidth / 2);
    
    // Adjust for beginning and end of the list
    targetScroll = targetScroll.clamp(0.0, maxScroll);

    if (animate) {
      _scrollController.animateTo(
        targetScroll,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.jumpTo(targetScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Level',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold
          )
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => _changeLevel(selectedLevel - 1),
            ),
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    _changeLevel(selectedLevel + 1);
                  } else if (details.primaryVelocity! > 0) {
                    _changeLevel(selectedLevel - 1);
                  }
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    children: [
                      for (var i in List.generate(widget.maxValue - widget.minValue + 1, (index) => index + widget.minValue))
                        GestureDetector(
                          onTap: () => _changeLevel(i),
                          child: Container(
                            width: _itemWidth - 8, // Subtracting horizontal margin
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: i == selectedLevel ? const Color.fromARGB(200, 66, 43, 143) : Colors.transparent,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                '$i',
                                style: TextStyle(color: i == selectedLevel ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => _changeLevel(selectedLevel + 1),
            ),
          ],
        ),
      ],
    );
  }
}