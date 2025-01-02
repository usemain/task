import 'package:flutter/material.dart';
import 'package:usemain/shares/colors.dart';
import 'dart:math';

// 自定义进度环组件
class ProgressCircle extends StatefulWidget {
  final double width; // 控件的宽度
  final String title; // 进度环的标题
  final double titleSize; // 标题的字体大小
  final bool titleShow; // 是否显示标题
  final FontWeight fontWeight; // 进度文本的字体粗细
  final Color titleColor; // 标题的颜色
  final String textType; // 进度文本的类型（例如"%"）
  final double fontSize; // 进度文本的字体大小
  final double radius; // 圆的半径
  final double strokeWidth; // 圆环的宽度
  final StrokeCap strokeLinecap; // 圆环的两端端点的形状(默认圆角)
  final double progress; // 当前进度值（0-100）
  final Color progressColor; // 进度文本的颜色
  final Color progressStartColor; // 进度起始颜色
  final Color progressEndColor; // 进度结束颜色
  final Color backgroundColor; // 背景圆环的颜色
  final bool animate; // 是否使用进度环动画效果

  const ProgressCircle({
    super.key,
    this.width = 160,
    this.title = '已完成',
    this.fontSize = 19,
    this.titleSize = 12,
    this.titleShow = true,
    this.fontWeight = FontWeight.bold,
    this.progressColor = commonColor,
    this.titleColor = commonColor,
    this.textType = '%',
    this.radius = 70,
    this.strokeWidth = 20,
    this.strokeLinecap = StrokeCap.round,
    this.progress = 0,
    this.progressStartColor = commonDetultColor,
    this.progressEndColor = commonColor,
    this.backgroundColor = const Color(0xfff3f3f3),
    this.animate = true,
  });

  @override
  State<ProgressCircle> createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // 初始化动画
    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // 如果需要动画，则开始动画
    if (widget.animate) {
      _controller.forward();
    } else {
      // 否则直接设置进度
      _controller.value = widget.progress / 100;
    }
  }

  @override
  void didUpdateWidget(covariant ProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 如果进度变化，则更新动画
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ));

      if (widget.animate) {
        _controller.forward(from: 0);
      } else {
        _controller.value = widget.progress / 100;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景圆环
          CustomPaint(
            size: Size(widget.width, widget.width),
            painter: _BackgroundCirclePainter(
              centerX: widget.width / 2,
              centerY: widget.width / 2,
              radius: widget.radius,
              strokeWidth: widget.strokeWidth,
              backgroundColor: widget.backgroundColor,
            ),
          ),
          // 进度动画圆环
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.width, widget.width),
                painter: _ProgressCirclePainter(
                  centerX: widget.width / 2,
                  centerY: widget.width / 2,
                  radius: widget.radius,
                  strokeWidth: widget.strokeWidth,
                  strokeLinecap: widget.strokeLinecap,
                  progress: _animation.value,
                  startColor: widget.progressStartColor,
                  endColor: widget.progressEndColor,
                ),
              );
            },
          ),
          // 中间的进度文本和标题
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.progress.toStringAsFixed(2)}${widget.textType}',
                style: TextStyle(
                  color: widget.progressColor,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                ),
              ),
              if (widget.titleShow)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: widget.titleSize,
                      color: widget.titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}

// 背景圆环绘制器
class _BackgroundCirclePainter extends CustomPainter {
  final double centerX; // 圆心的X坐标
  final double centerY; // 圆心的Y坐标
  final double radius; // 圆的半径
  final double strokeWidth; // 圆环的宽度
  final Color backgroundColor; // 圆环的颜色

  _BackgroundCirclePainter({
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.strokeWidth,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // 绘制圆环
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 进度圆环绘制器
class _ProgressCirclePainter extends CustomPainter {
  final double centerX; // 圆心的X坐标
  final double centerY; // 圆心的Y坐标
  final double radius; // 圆的半径
  final double strokeWidth; // 圆环的宽度
  final StrokeCap strokeLinecap; // 圆环的端点形状
  final double progress; // 当前进度值（0-100）
  final Color startColor; // 进度起始颜色
  final Color endColor; // 进度结束颜色

  _ProgressCirclePainter({
    required this.centerX,
    required this.centerY,
    required this.radius,
    required this.strokeWidth,
    required this.strokeLinecap,
    required this.progress,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: radius,
    );

    // 创建渐变色圆环
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [startColor, endColor],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        tileMode: TileMode.clamp,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeLinecap;

    // 进度环的起始角度
    const startAngle = -pi / 2;
    // 进度环的扫描角度
    final sweepAngle = 2 * pi * (progress / 100);

    // 绘制进度圆环
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
