import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  final BuildContext dialogContext;
  final String visitorName;
  final VoidCallback onDelete;
  const DeleteAlertDialog({
    super.key,
    required this.dialogContext,
    required this.visitorName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),

      title: Row(
        children: [
          const Expanded(
            child: Text(
              'ALERT',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      content: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            const TextSpan(text: 'Are you sure you want to delete '),
            TextSpan(
              text: visitorName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  onDelete();
                },
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Delete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(dialogContext),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
