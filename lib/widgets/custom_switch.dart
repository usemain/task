import 'dart:math';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final double? width;
  final double? height;
  final Color? activeBgColor;
  final Color? activeColor;
  final ValueChanged<bool>? onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    this.width,
    this.height,
    this.activeBgColor,
    this.activeColor,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Color?> _bgColorAnimation;
  bool _switchActive = false;
  late Color _bgColor;
  late Color _activeBgColor;
  late Color _color;
  late Color _activeColor;

  double _width = 50.0;
  double _height = 30.0;
  double _minSize = 30.0;

  bool _isAnimating = false;
  final double _space = 6.0;
  bool _isStartAnimating = false;

  @override
  void initState() {
    _switchActive = widget.value;
    _bgColor = Color(0xFFE4E4E7);
    _color = Colors.white;
    _activeBgColor = widget.activeBgColor ?? Color.fromARGB(255, 0, 149, 255);
    _activeColor = widget.activeColor ?? Colors.white;

    if (widget.width != null && widget.height != null) {
      _width = widget.width!;
      _height = widget.height!;
    }
    _minSize = min(_width, _height) - _space;

    super.initState();
    runAnimation();
  }

  void runAnimation() {
    Color bgBeginColor;
    Color bgEndColor;

    Color beginColor;
    Color endColor;

    double beginP;
    double endP;

    if (_switchActive) {
      bgBeginColor = _activeBgColor;
      bgEndColor = _bgColor;

      beginColor = _activeColor;
      endColor = _color;

      beginP = _width - _minSize;
      endP = _space;
    } else {
      bgBeginColor = _bgColor;
      bgEndColor = _activeBgColor;

      beginColor = _color;
      endColor = _activeColor;

      beginP = _space;
      endP = _width - _minSize;
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _positionAnimation = Tween<double>(
      begin: beginP,
      end: endP,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _colorAnimation = ColorTween(
      begin: beginColor,
      end: endColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _bgColorAnimation = ColorTween(
      begin: bgBeginColor,
      end: bgEndColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isAnimating = false;
        _isStartAnimating = true;

        if (widget.onChanged != null) {
          widget.onChanged!(!_switchActive);
        }
      }
    });
  }

  void animationDispose() {
    _controller.dispose();
  }

  void onSwitchPressed() {
    if (_isAnimating) {
      return;
    }

    _isAnimating = true;

    if (_isStartAnimating) {
      _switchActive = !_switchActive;
    }
    runAnimation();
    _controller.forward();
  }

  @override
  void dispose() {
    animationDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = _minSize / 2.0;
    double bgRadius = _height / 2.0;

    return GestureDetector(
      onTap: () {
        onSwitchPressed();
      },
      child: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _bgColorAnimation.value,
                borderRadius: BorderRadius.circular(bgRadius),
              ),
            ),
            Positioned(
              left: _positionAnimation.value,
              child: Container(
                width: _minSize - 5,
                height: _minSize - 5,
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
