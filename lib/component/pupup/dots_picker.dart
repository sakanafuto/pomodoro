// ignore_for_file: avoid_dynamic_calls

library dots_picker;

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:pomodoro/component/pupup/dot.dart';

import 'custom_popup.dart';

// ignore: depend_on_referenced_packages


class DotsPicker extends StatefulWidget {
  const DotsPicker({
    required this.dots,
    this.onSelected,
    this.selected = 0,
    this.exposureTime = 1,
    super.key,
  });

  final List<Dot> dots;
  final void Function(int)? onSelected;
  final int selected;
  final int exposureTime;

  @override
  State<DotsPicker> createState() => _DotsPickerState();
}

class _DotsPickerState extends State<DotsPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late CurvedAnimation _curve;
  int selected = 0;
  Timer? _timerReverse;
  OverlayEntry? _overlayEntry;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    _animController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);
    _animController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _timerReverse = Timer(
            Duration(seconds: widget.exposureTime),
            () => _animController.reverse(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    closePopUp();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: _globalKey,
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.dots.mapIndexed((i, dot) {
        return Flexible(
          child: GestureDetector(
            onTap: showPopUp,
            child: const Icon(
              Icons.help_outline,
              color: Colors.grey,
              size: 16,
            ),
          ),
        );
      }).toList(),
    );
  }

  void showPopUp() {
    _animController.reset();
    closePopUp();

    _overlayEntry = _overlayEntryBuilder();
    _animController.forward();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void closePopUp() {
    if (_timerReverse != null && _timerReverse!.isActive) {
      _timerReverse?.cancel();
    }

    if (isPopupOpen) {
      _overlayEntry?.remove();
    }
  }

  bool get isPopupOpen {
    if (_overlayEntry == null) {
      return false;
    }
    return _overlayEntry!.mounted;
  }

  OverlayEntry _overlayEntryBuilder() {
    final renderBox =
        _globalKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    const width = 240;
    var xcoord = 0.2;

    return OverlayEntry(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        if (position.dx < 100) {
          xcoord = 0.3;
        }
        if (position.dx + size.width > screenWidth - 100) {
          xcoord = 0.7;
        }

        return Positioned(
          top: position.dy + size.height - 5.0,
          left: ((0.5 - xcoord) * width) +
              position.dx -
              width / 2 +
              size.width / 2,
          width: width.toDouble(),
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              alignment: Alignment((xcoord - 0.5) * 2, -1),
              scale: _curve,
              child: CustomPopUp(
                xcoord: xcoord,
                color: widget.dots[selected].color,
                text: widget.dots[selected].name,
              ),
            ),
          ),
        );
      },
    );
  }
}
