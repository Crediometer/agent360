import 'package:flutter/material.dart';
import '../screens/notification_screen.dart';

class NotificationIconWithBadge extends StatelessWidget {
  final int unreadCount;
  final double iconSize;
  final Color iconColor;
  final VoidCallback? onTap;

  const NotificationIconWithBadge({
    super.key,
    this.unreadCount = 0,
    this.iconSize = 24,
    this.iconColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: iconSize + 12,
            width: iconSize + 12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.notifications, // ✅ filled bell icon
              size: iconSize,
              color: iconColor,
            ),
          ),
          if (unreadCount > 0)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
