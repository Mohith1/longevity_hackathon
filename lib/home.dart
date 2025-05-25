// lib/home.dart

import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; // REMOVED Google Fonts import
import 'profile.dart'; // Navigate to ProfileScreen on tap
import 'community.dart'; // Navigate to CommunityScreen

// Placeholder for SleepActivityChart if not defined elsewhere
class SleepActivityChart extends StatelessWidget {
  final Color color;
  const SleepActivityChart({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Sleep & Activity Chart Placeholder',
        style: TextStyle(color: Colors.grey.shade700, fontSize: 12), // Using default font
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressAnim;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _progressAnim = Tween<double>(begin: 0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CommunityScreen()),
      );
    }
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TopBar(onProfileTap: _navigateToProfile),
              const SizedBox(height: 24),
              const DailyRecommendationCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Your Flex Summary', context),
              const SizedBox(height: 16),
              InfoCard(
                child: Column(
                  children: [
                    FlexSummarySection(animation: _progressAnim),
                    const SizedBox(height: 8),
                    Text(
                      'Joint Flexibility Score',
                      style: TextStyle( // Using default font
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Current Points', context),
              const SizedBox(height: 16),
              InfoCard(
                child: PointsSection(animation: _progressAnim, primary: colorScheme.primary),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Overall InflammAGE Score', context),
              const SizedBox(height: 16),
              InfoCard(
                child: SizedBox(
                  height: 180,
                  child: InflammAgeGauge(score: 24.6, color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Lifestyle Factors', context),
              Text(
                'Sleep & Activity Levels Over Time',
                style: TextStyle(color: Colors.grey[600], fontSize: 14), // Using default font
              ),
              const SizedBox(height: 16),
              InfoCard(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Row(
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Sleep Quality (%)',
                                style: TextStyle(color: Colors.grey.shade700, fontSize: 12), // Using default font
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: SleepActivityChart(color: colorScheme.primary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 12), // Using default font
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey.shade500,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12), // Using default font
        unselectedLabelStyle: const TextStyle(fontSize: 12), // Using default font
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Library'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle( // Using default font
        fontSize: 20,
        fontWeight: FontWeight.w600, // Semibold
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.85),
        letterSpacing: 0.5, // Adds a bit of "tech" feel
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const InfoCard({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class TopBar extends StatelessWidget {
  final VoidCallback onProfileTap;
  const TopBar({Key? key, required this.onProfileTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final String greeting;
    if (hour < 12) {
      greeting = 'Good Morning! Flex Freaks';
    } else if (hour < 18) {
      greeting = 'Good Afternoon! Flex Freaks';
    } else {
      greeting = 'Good Evening! Flex Freaks';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded( // Allow text to take available space and wrap if needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle( // Using default font
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Ready to flex your day?",
                style: TextStyle( // Using default font
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16), // Add some spacing before the avatar
        GestureDetector(
          onTap: onProfileTap,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.person_outline,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class DailyRecommendationCard extends StatelessWidget {
  const DailyRecommendationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
            Theme.of(context).colorScheme.primary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.task_alt_outlined, color: Colors.white, size: 38),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Daily Recommendation',
                  style: TextStyle( // Using default font
                    fontSize: 14,
                    fontWeight: FontWeight.w500, // Medium weight
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Perform 10 squats for every 3 hours',
                  style: TextStyle( // Using default font
                    fontSize: 17, // Slightly larger for emphasis
                    fontWeight: FontWeight.w600, // Semibold
                    color: Colors.white,
                    height: 1.3, // Line height
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FlexSummarySection extends StatelessWidget {
  final Animation<double> animation;
  const FlexSummarySection({Key? key, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Center(
      child: SizedBox(
        width: 160,
        height: 160,
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return CustomPaint(
              painter: _RingPainter(progress: animation.value, color: primary),
              child: Center(
                child: Text(
                  '${(animation.value * 100).round()}%',
                  style: TextStyle( // Using default font
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  _RingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 16.0;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.progress != progress || old.color != color;
}

class PointsSection extends StatelessWidget {
  final Animation<double> animation;
  final Color primary;
  const PointsSection({Key? key, required this.animation, required this.primary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 14,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(7),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return FractionallySizedBox(
                  widthFactor: animation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primary.withOpacity(0.7), primary],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                return Text(
                  '${(animation.value * 100).round()} PTS',
                  style: TextStyle( // Using default font
                      fontWeight: FontWeight.w600, fontSize: 16, color: primary),
                );
              },
            ),
            Text(
              'Goal: 100 PTS',
              style: TextStyle( // Using default font
                  fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),
      ],
    );
  }
}

class InflammAgeGauge extends StatelessWidget {
  final double score;
  final Color color;
  const InflammAgeGauge({Key? key, required this.score, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: _InflammAgePainter(score: score, color: color, maxScore: 100.0),
      );
    });
  }
}

class _InflammAgePainter extends CustomPainter {
  final double score;
  final Color color;
  final double maxScore;

  _InflammAgePainter({required this.score, required this.color, this.maxScore = 100.0});

  @override
  void paint(Canvas canvas, Size size) {
    final gaugeHeight = size.height * 0.75;
    final textOffsetY = size.height * 0.05;

    final strokeWidth = 18.0;
    final center = Offset(size.width / 2, gaugeHeight);
    final radius = min(size.width / 2 - strokeWidth / 2, gaugeHeight - strokeWidth / 2);

    const startAngle = pi;
    const sweepAngleTotal = pi;

    final clampedScore = score.clamp(0.0, maxScore);
    final progress = clampedScore / maxScore;
    final sweepAngleProgress = progress * sweepAngleTotal;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngleTotal,
      false,
      backgroundPaint,
    );

    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngleProgress,
      false,
      foregroundPaint,
    );

    final scoreTextSpan = TextSpan(
      children: [
        TextSpan(
          text: score.toStringAsFixed(1),
          style: TextStyle( // Using default font
            color: color,
            fontSize: min(radius * 0.4, 36.0),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: ' / ${maxScore.toInt()}',
          style: TextStyle( // Using default font
            color: Colors.grey.shade600,
            fontSize: min(radius * 0.2, 18.0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
    final scoreTextPainter = TextPainter(
      text: scoreTextSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);
    final scoreTextOffset = Offset(
      (size.width - scoreTextPainter.width) / 2,
      center.dy - radius * 0.5 - scoreTextPainter.height / 2,
    );
    scoreTextPainter.paint(canvas, scoreTextOffset);

    final lowerBetterTextPainter = TextPainter(
      text: TextSpan(
        text: 'Lower is Better',
        style: TextStyle(color: Colors.grey.shade700, fontSize: min(radius * 0.15, 12.0)), // Using default font
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    lowerBetterTextPainter.paint(
        canvas, Offset((size.width - lowerBetterTextPainter.width) / 2, center.dy + textOffsetY));

    final labelStyle = TextStyle(color: Colors.grey.shade600, fontSize: min(radius * 0.12, 10.0)); // Using default font

    for (int i = 0; i <= 4; i++) {
      final tickProgress = i / 4.0;
      final angle = startAngle + tickProgress * sweepAngleTotal;
      final tickLabel = (tickProgress * maxScore).toInt().toString();
      final tickLabelPainter = TextPainter(
        text: TextSpan(text: tickLabel, style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      if (i == 0 || i == 2 || i == 4) {
         final painterX = center.dx + (radius * 1.15) * cos(angle) - (tickLabelPainter.width / 2);
         final painterYAdjusted = (i==2)
            ? (center.dy - radius - tickLabelPainter.height - strokeWidth/2 - 5) // Top middle
            : (center.dy - tickLabelPainter.height - 8); // Sides

         if (i==2) {
             tickLabelPainter.paint(canvas, Offset(center.dx - tickLabelPainter.width/2, painterYAdjusted));
         } else {
            tickLabelPainter.paint(canvas, Offset(painterX, painterYAdjusted));
         }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _InflammAgePainter old) =>
      old.score != score || old.color != color || old.maxScore != maxScore;
}
