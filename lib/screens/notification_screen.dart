import 'package:agent360/widgets/notification_icon_with_badge.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Your password has been changed successfully',
        'time': '12:34 AM',
        'date': 'Today',
        'icon': Icons.lock_open_rounded,
        'unread': true,
        'avatar': null,
      },
      {
        'title': 'You changed your user name',
        'time': '12:34 AM',
        'date': 'Today',
        'icon': null,
        'unread': false,
        'avatar': 'https://randomuser.me/api/portraits/men/75.jpg',
      },
      {
        'title': 'Your password has been changed successfully',
        'time': '12:34 AM',
        'date': 'Yesterday',
        'icon': Icons.lock_open_rounded,
        'unread': false,
        'avatar': null,
      },
      {
        'title': 'Your password has been changed successfully',
        'time': '08 May 2023, 12:34 AM',
        'date': 'Last week',
        'icon': Icons.lock_open_rounded,
        'unread': false,
        'avatar': null,
      },
      {
        'title': 'You do have an update',
        'time': '10 May 2023, 12:34 AM',
        'date': 'Last week',
        'icon': Icons.system_update_alt_rounded,
        'unread': false,
        'avatar': null,
      },
    ];

    final grouped = <String, List<Map<String, dynamic>>>{};
    for (var notif in notifications) {
      grouped.putIfAbsent(notif['date'] as String, () => []).add(notif);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
 
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const Text(
            'All notifications',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          const Text.rich(
            TextSpan(
              text: 'You have ',
              children: [
                TextSpan(
                  text: '1 unread notification',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          for (final date in grouped.keys) ...[
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...grouped[date]!.map(
              (notif) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    notif['avatar'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(notif['avatar']),
                            radius: 16,
                          )
                        : Icon(notif['icon'], size: 24, color: Colors.black),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (notif['unread'])
                                const Padding(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 8,
                                  ),
                                ),
                              Flexible(
                                child: Text(
                                  notif['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notif['time'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
