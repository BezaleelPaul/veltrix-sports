import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

// iOS-style navigation bar
class IOSNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool largeTitle;

  const IOSNavBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.largeTitle = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(largeTitle ? 96 : 44);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(title),
      leading: leading,
      trailing: actions != null && actions!.isNotEmpty
          ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
          : null,
      border: const Border(
        bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
      ),
      backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
    );
  }
}

// iOS-style list section
class IOSListSection extends StatelessWidget {
  final String? header;
  final List<Widget> children;
  final Widget? footer;

  const IOSListSection({
    super.key,
    this.header,
    required this.children,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      header: header != null ? Text(header!) : null,
      footer: footer,
      children: children,
    );
  }
}

// iOS-style list tile
class IOSListTile extends StatelessWidget {
  final IconData leading;
  final Color leadingColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const IOSListTile({
    super.key,
    required this.leading,
    required this.leadingColor,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: leadingColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Icon(leading, color: AppColors.white, size: 18),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ?? const CupertinoListTileChevron(),
      onTap: onTap,
    );
  }
}

// iOS-style search bar
class IOSSearchBar extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const IOSSearchBar({
    super.key,
    this.placeholder = 'Search',
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: controller,
      placeholder: placeholder,
      onChanged: onChanged,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

// iOS-style segmented control
class IOSSegmentedControl extends StatelessWidget {
  final List<String> segments;
  final int selectedIndex;
  final ValueChanged<int> onValueChanged;

  const IOSSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<int>(
      groupValue: selectedIndex,
      onValueChanged: onValueChanged,
      children: {
        for (int i = 0; i < segments.length; i++)
          i: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(segments[i], style: const TextStyle(fontSize: 13)),
          ),
      },
      borderColor: AppColors.primary,
      selectedColor: AppColors.primary,
      unselectedColor: CupertinoColors.white,
      pressedColor: AppColors.primaryLight,
    );
  }
}

// iOS-style action sheet
void showIOSActionSheet(
  BuildContext context, {
  required String title,
  String? message,
  required List<IOSAction> actions,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(title),
      message: message != null ? Text(message) : null,
      actions: actions
          .map((action) => CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  action.onPressed();
                },
                isDestructiveAction: action.isDestructive,
                child: Text(action.label),
              ))
          .toList(),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    ),
  );
}

class IOSAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDestructive;

  const IOSAction({
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });
}

// iOS-style alert dialog
void showIOSAlertDialog(
  BuildContext context, {
  required String title,
  String? message,
  required String confirmText,
  String cancelText = 'Cancel',
  required VoidCallback onConfirm,
  bool isDestructive = false,
}) {
  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: message != null ? Text(message) : null,
      actions: [
        CupertinoDialogAction(
          child: Text(cancelText),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          isDestructiveAction: isDestructive,
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(confirmText),
        ),
      ],
    ),
  );
}

// iOS-style toast
void showIOSToast(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 48,
      right: 48,
      child: _IOSToastWidget(
        message: message,
        onDismiss: () => entry.remove(),
      ),
    ),
  );
  overlay.insert(entry);
}

class _IOSToastWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const _IOSToastWidget({required this.message, required this.onDismiss});

  @override
  State<_IOSToastWidget> createState() => _IOSToastWidgetState();
}

class _IOSToastWidgetState extends State<_IOSToastWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: AppColors.white, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              widget.message,
              style: const TextStyle(color: AppColors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
