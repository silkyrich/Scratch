import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../services/feedback_service.dart';

class FeedbackDialog extends StatefulWidget {
  final GlobalKey screenshotKey;
  final String? currentRoute;

  const FeedbackDialog({
    super.key,
    required this.screenshotKey,
    this.currentRoute,
  });

  static Future<void> show(BuildContext context, GlobalKey screenshotKey,
      {String? currentRoute}) {
    return showDialog(
      context: context,
      builder: (_) => FeedbackDialog(
        screenshotKey: screenshotKey,
        currentRoute: currentRoute,
      ),
    );
  }

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final _titleController = TextEditingController(text: 'App Feedback');
  final _descController = TextEditingController();
  Uint8List? _screenshot;
  bool _includeScreenshot = true;
  bool _submitting = false;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    _captureScreenshot();
  }

  Future<void> _captureScreenshot() async {
    final bytes = await FeedbackService.captureScreenshot(widget.screenshotKey);
    if (mounted) {
      setState(() => _screenshot = bytes);
    }
  }

  Future<void> _submit() async {
    if (_descController.text.trim().isEmpty) {
      setState(() => _statusMessage = 'Please describe your feedback.');
      return;
    }

    setState(() {
      _submitting = true;
      _statusMessage = null;
    });

    String? screenshotUrl;

    if (_includeScreenshot && _screenshot != null) {
      setState(() => _statusMessage = 'Uploading screenshot...');
      screenshotUrl = await FeedbackService.uploadToImgur(_screenshot!);
      if (screenshotUrl == null && mounted) {
        setState(
            () => _statusMessage = 'Screenshot upload failed. Submitting without it...');
      }
    }

    await FeedbackService.submitFeedback(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      screenshotUrl: screenshotUrl,
      currentRoute: widget.currentRoute,
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.feedback_outlined, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          const Text('Send Feedback'),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'What would you like to tell us?',
                  hintText: 'Describe a bug, suggest a feature, or share your thoughts...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                minLines: 3,
              ),
              const SizedBox(height: 12),
              if (_screenshot != null) ...[
                CheckboxListTile(
                  value: _includeScreenshot,
                  onChanged: (v) =>
                      setState(() => _includeScreenshot = v ?? true),
                  title: const Text('Include screenshot'),
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                if (_includeScreenshot)
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.memory(
                      _screenshot!,
                      fit: BoxFit.contain,
                    ),
                  ),
              ] else ...[
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Capturing screenshot...',
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
              if (_statusMessage != null) ...[
                const SizedBox(height: 8),
                Text(_statusMessage!,
                    style: TextStyle(
                        color: theme.colorScheme.error, fontSize: 12)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submitting ? null : _submit,
          icon: _submitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Icon(Icons.open_in_new, size: 16),
          label: Text(_submitting ? 'Submitting...' : 'Submit on GitHub'),
        ),
      ],
    );
  }
}
