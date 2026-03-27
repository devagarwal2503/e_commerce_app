import 'package:flutter/material.dart';

void showModernToast(BuildContext context, String data, Color color) {
  // 1. Create the Overlay Entry
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _ToastWidget(
      onDismiss: () => overlayEntry.remove(),
      color: color,
      data: data,
    ),
  );

  // 2. Insert into the screen
  Overlay.of(context).insert(overlayEntry);
}

// 3. The Animated Widget
class _ToastWidget extends StatefulWidget {
  final VoidCallback onDismiss;
  final Color color;
  final String data;

  const _ToastWidget({
    required this.onDismiss,
    required this.color,
    required this.data,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Bouncy entrance from the bottom
    _offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, 2), // Start below screen
          end: const Offset(0, 0), // End at its position
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.elasticOut, // The "Playful" bouncy curve
          ),
        );

    _controller.forward();

    // Auto-dismiss after 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        await _controller.reverse();
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                widget.data,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
