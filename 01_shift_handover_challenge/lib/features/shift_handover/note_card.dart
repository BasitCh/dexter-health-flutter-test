// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';

class NoteCard extends StatelessWidget {
  final HandoverNote note;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NoteCard({Key? key, required this.note, this.onEdit, this.onDelete})
      : super(key: key);

  static const Map<NoteType, IconData> _iconMap = {
    NoteType.observation: Icons.visibility_outlined,
    NoteType.incident: Icons.warning_amber_rounded,
    NoteType.medication: Icons.medical_services_outlined,
    NoteType.task: Icons.check_circle_outline,
    NoteType.supplyRequest: Icons.shopping_cart_checkout_outlined,
  };

  static final Map<NoteType, Color> _colorMap = {
    NoteType.observation: Colors.blue.shade700,
    NoteType.incident: Colors.red.shade700,
    NoteType.medication: Colors.purple.shade700,
    NoteType.task: Colors.green.shade700,
    NoteType.supplyRequest: Colors.orange.shade700,
  };

  @override
  Widget build(BuildContext context) {
    final color = _colorMap[note.type] ?? Colors.grey;
    final icon = _iconMap[note.type] ?? Icons.help_outline;

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 4.0),
                  child: Icon(icon, color: color, size: 28),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(height: 1.4),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              note.type.name.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            DateFormat.jm().format(note.timestamp),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  tooltip: 'Edit',
                  splashRadius: 18,
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18),
                  tooltip: 'Delete',
                  splashRadius: 18,
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditNoteDialog extends StatefulWidget {
  final HandoverNote note;
  const EditNoteDialog({required this.note});
  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController textController;
  late NoteType selectedType;
  String? errorText;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.note.text);
    selectedType = widget.note.type;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Note text',
                errorText: errorText,
              ),
              onChanged: (_) {
                if (errorText != null) {
                  setState(() => errorText = null);
                }
              },
            ),
            const SizedBox(height: 12),
            DropdownButton<NoteType>(
              value: selectedType,
              isExpanded: true,
              onChanged: (NoteType? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedType = newValue;
                  });
                }
              },
              items: NoteType.values.map((NoteType type) {
                return DropdownMenuItem<NoteType>(
                  value: type,
                  child: Text(type.name.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isEmpty) {
                setState(() => errorText = 'Note text cannot be empty');
                return;
              }
              Navigator.pop(
                context,
                widget.note.copyWith(
                  text: textController.text.trim(),
                  type: selectedType,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
