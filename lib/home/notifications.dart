import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> _notifications = [];
  NotificationFilter _currentFilter = NotificationFilter.all;
  bool _showUnreadOnly = false;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    setState(() {
      _notifications = [
        NotificationItem(
          id: '1',
          title: 'Workout Reminder',
          message: 'Your evening HIIT session starts in 30 minutes',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          type: NotificationType.reminder,
          isRead: false,
          icon: Iconsax.clock,
          iconColor: Colors.blue,
        ),
        NotificationItem(
          id: '2',
          title: 'Achievement Unlocked!',
          message: 'You completed 7 consecutive workout days. Keep it up!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          type: NotificationType.achievement,
          isRead: false,
          icon: Iconsax.award,
          iconColor: Colors.amber,
        ),
        NotificationItem(
          id: '3',
          title: 'New Workout Available',
          message: 'Check out our new "Morning Yoga Flow" routine',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          type: NotificationType.newContent,
          isRead: true,
          icon: Iconsax.activity,
          iconColor: Colors.green,
        ),
        NotificationItem(
          id: '4',
          title: 'Weekly Progress Report',
          message: 'You burned 3,500 calories this week. Great job!',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          type: NotificationType.progress,
          isRead: true,
          icon: Iconsax.chart,
          iconColor: Colors.purple,
        ),
        NotificationItem(
          id: '6',
          title: 'Meal Plan Updated',
          message: 'Your weekly meal plan has been optimized',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          type: NotificationType.system,
          isRead: true,
          icon: Iconsax.cake,
          iconColor: Colors.orange,
        ),
        NotificationItem(
          id: '7',
          title: 'Water Intake Reminder',
          message: 'Time to hydrate! Drink a glass of water',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          type: NotificationType.reminder,
          isRead: true,
          icon: Iconsax.drop,
          iconColor: Colors.lightBlue,
        ),
        NotificationItem(
          id: '8',
          title: 'Goal Reached!',
          message: 'Congratulations! You reached your monthly step goal',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          type: NotificationType.achievement,
          isRead: true,
          icon: Iconsax.star,
          iconColor: Colors.deepPurple,
        ),
      ];
    });
  }

  void _markAsRead(String id) {
    setState(() {
      _notifications = _notifications.map((notification) {
        if (notification.id == id) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();
    });
  }

  void _markAllAsRead() {
    setState(() {
      _notifications = _notifications.map((notification) {
        return notification.copyWith(isRead: true);
      }).toList();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((notification) => notification.id == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // TODO: Implement undo functionality
          },
        ),
      ),
    );
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text(
          'Are you sure you want to clear all notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  List<NotificationItem> get _filteredNotifications {
    List<NotificationItem> filtered = _notifications;

    if (_showUnreadOnly) {
      filtered = filtered.where((n) => !n.isRead).toList();
    }

    if (_currentFilter != NotificationFilter.all) {
      filtered = filtered.where((n) {
        switch (_currentFilter) {
          case NotificationFilter.reminders:
            return n.type == NotificationType.reminder;
          case NotificationFilter.achievements:
            return n.type == NotificationType.achievement;
          case NotificationFilter.system:
            return n.type == NotificationType.system;
          default:
            return true;
        }
      }).toList();
    }

    return filtered;
  }

  int get _unreadCount {
    return _notifications.where((n) => !n.isRead).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (_unreadCount > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                radius: 12,
                child: Text(
                  '$_unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          IconButton(
            onPressed: _markAllAsRead,
            icon: const Icon(Iconsax.tick_circle),
            tooltip: 'Mark all as read',
          ),
          IconButton(
            onPressed: _clearAll,
            icon: const Icon(Iconsax.trash),
            tooltip: 'Clear all',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          _buildFilterChips(),

          // Toggle Switch
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Iconsax.eye, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Show unread only',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Switch(
                  value: _showUnreadOnly,
                  onChanged: (value) {
                    setState(() {
                      _showUnreadOnly = value;
                    });
                  },
                  activeThumbColor: Colors.deepPurple,
                ),
              ],
            ),
          ),

          // Notifications List
          Expanded(
            child: _filteredNotifications.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _filteredNotifications.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final notification = _filteredNotifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: NotificationFilter.values.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_getFilterLabel(filter)),
              selected: _currentFilter == filter,
              onSelected: (selected) {
                setState(() {
                  _currentFilter = selected ? filter : NotificationFilter.all;
                });
              },
              backgroundColor: Colors.grey[100],
              selectedColor: Colors.deepPurple.withValues(alpha: 0.1),
              checkmarkColor: Colors.deepPurple,
              labelStyle: TextStyle(
                color: _currentFilter == filter
                    ? Colors.deepPurple
                    : Colors.grey[700],
                fontWeight: _currentFilter == filter
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
              side: BorderSide(
                color: _currentFilter == filter
                    ? Colors.deepPurple
                    : Colors.grey[300]!,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getFilterLabel(NotificationFilter filter) {
    switch (filter) {
      case NotificationFilter.all:
        return 'All';
      case NotificationFilter.reminders:
        return 'Reminders';
      case NotificationFilter.achievements:
        return 'Achievements';
      case NotificationFilter.system:
        return 'System';
    }
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    final timeAgo = _getTimeAgo(notification.timestamp);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Iconsax.trash, color: Colors.white, size: 24),
      ),
      onDismissed: (direction) => _deleteNotification(notification.id),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: notification.iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification.icon,
            color: notification.iconColor,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: TextStyle(
                  fontWeight: notification.isRead
                      ? FontWeight.normal
                      : FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Iconsax.clock, size: 12, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  timeAgo,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getTypeColor(
                      notification.type,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getTypeLabel(notification.type),
                    style: TextStyle(
                      fontSize: 10,
                      color: _getTypeColor(notification.type),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          if (!notification.isRead) {
            _markAsRead(notification.id);
          }
          // TODO: Navigate to notification detail or perform action
        },
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () => _markAsRead(notification.id),
              child: const Row(
                children: [
                  Icon(Iconsax.tick_circle, size: 20),
                  SizedBox(width: 8),
                  Text('Mark as read'),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () => _deleteNotification(notification.id),
              child: const Row(
                children: [
                  Icon(Iconsax.trash, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          icon: const Icon(Iconsax.more),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.notification,
              size: 60,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Notifications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            _currentFilter == NotificationFilter.all
                ? 'You\'re all caught up!'
                : 'No ${_getFilterLabel(_currentFilter).toLowerCase()} notifications',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadNotifications,
            icon: const Icon(Iconsax.refresh),
            label: const Text('Refresh Notifications'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(timestamp);
    }
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.reminder:
        return Colors.blue;
      case NotificationType.achievement:
        return Colors.amber;
      case NotificationType.newContent:
        return Colors.green;
      case NotificationType.progress:
        return Colors.purple;
      case NotificationType.system:
        return Colors.orange;
    }
  }

  String _getTypeLabel(NotificationType type) {
    switch (type) {
      case NotificationType.reminder:
        return 'Reminder';
      case NotificationType.achievement:
        return 'Achievement';
      case NotificationType.newContent:
        return 'New';
      case NotificationType.progress:
        return 'Progress';
      case NotificationType.system:
        return 'System';
    }
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    required this.isRead,
    required this.icon,
    required this.iconColor,
  });

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    NotificationType? type,
    bool? isRead,
    IconData? icon,
    Color? iconColor,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
    );
  }
}

enum NotificationType { reminder, achievement, newContent, progress, system }

enum NotificationFilter { all, reminders, achievements, system }
