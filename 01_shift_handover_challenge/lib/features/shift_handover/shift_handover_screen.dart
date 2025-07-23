// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift_handover_challenge/features/shift_handover/note_card.dart';
import 'package:shift_handover_challenge/application/shift_handover/shift_handover_bloc.dart';
import 'package:shift_handover_challenge/application/shift_handover/shift_handover_event.dart';
import 'package:shift_handover_challenge/application/shift_handover/shift_handover_state.dart';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';
import 'package:shift_handover_challenge/di.dart';

class ShiftHandoverScreen extends StatelessWidget {
  const ShiftHandoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShiftHandoverBloc(repository: sl()),
      child: const ShiftHandoverBody(),
    );
  }
}

class ShiftHandoverBody extends StatefulWidget {
  const ShiftHandoverBody({Key? key}) : super(key: key);

  @override
  State<ShiftHandoverBody> createState() => _ShiftHandoverBodyState();
}

class _ShiftHandoverBodyState extends State<ShiftHandoverBody> {
  bool _hasShownSubmitSuccess = false;
  @override
  void initState() {
    super.initState();
    // Dispatch initial load event
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ShiftHandoverBloc>()
          .add(const LoadShiftReport('current-user-id'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shift Handover Report'),
        elevation: 0,
        actions: [
          BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
            builder: (context, state) {
              if (state.isLoading && state.report == null) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh Report',
                onPressed: () {
                  context
                      .read<ShiftHandoverBloc>()
                      .add(const LoadShiftReport('current-user-id'));
                },
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ShiftHandoverBloc, ShiftHandoverState>(
        listener: (context, state) {
          if (state.error != null && state.errorContext == ErrorContext.load) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load report: ${state.error}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          // Show error only if submit fails and not due to note add
          if (state.error != null &&
              state.errorContext == ErrorContext.submit) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to submit report: ${state.error}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          // Show error if adding a note fails
          if (state.error != null && state.errorContext == ErrorContext.none) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to add note: ${state.error}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
          // Only show success message for report submission, not for note update/delete
          if (state.report?.isSubmitted == true &&
              state.errorContext == ErrorContext.none &&
              !_hasShownSubmitSuccess) {
            _hasShownSubmitSuccess = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Report submitted successfully!'),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
          // Reset flag if report is not submitted
          if (state.report?.isSubmitted != true) {
            _hasShownSubmitSuccess = false;
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.report == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.report == null) {
            return _ErrorState(onRetry: () {
              context
                  .read<ShiftHandoverBloc>()
                  .add(const LoadShiftReport('current-user-id'));
            });
          }

          final report = state.report!;

          return Column(
            children: [
              if (report.notes.isEmpty)
                const Expanded(child: _EmptyNotesSection())
              else
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: report.notes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final note = report.notes[index];
                      return NoteCard(
                        note: note,
                        onEdit: () async {
                          final updated = await showDialog<HandoverNote>(
                            context: context,
                            builder: (ctx) => EditNoteDialog(note: note),
                          );
                          if (updated != null) {
                            context
                                .read<ShiftHandoverBloc>()
                                .add(UpdateNote(updated));
                          }
                        },
                        onDelete: () {
                          context
                              .read<ShiftHandoverBloc>()
                              .add(DeleteNote(note.id));
                        },
                      );
                    },
                  ),
                ),
              const InputSection(),
            ],
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final VoidCallback onRetry;
  const _ErrorState({required this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Failed to load shift report.',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            onPressed: onRetry,
          )
        ],
      ),
    );
  }
}

class _EmptyNotesSection extends StatelessWidget {
  const _EmptyNotesSection();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No notes added yet.\nUse the form below to add the first note.',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.grey[600]),
      ),
    );
  }
}

class NotesListSection extends StatelessWidget {
  final List<HandoverNote> notes;
  const NotesListSection({Key? key, required this.notes}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: notes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return NoteCard(note: notes[index]);
      },
    );
  }
}

class InputSection extends StatefulWidget {
  const InputSection({Key? key}) : super(key: key);
  @override
  State<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  final TextEditingController textController = TextEditingController();
  NoteType selectedType = NoteType.observation;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Add a new note for the next shift...',
                  ),
                  onChanged: (value) {
                    context.read<ShiftHandoverBloc>().add(InputChanged(value));
                  },
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      context
                          .read<ShiftHandoverBloc>()
                          .add(AddNewNote(value.trim(), selectedType));
                      textController.clear();
                      context
                          .read<ShiftHandoverBloc>()
                          .add(const InputChanged(''));
                    }
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: const Color(0xFFBDBDBD)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<NoteType>(
                      value: selectedType,
                      isExpanded: true,
                      icon: const Icon(Icons.category_outlined),
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
              builder: (context, state) {
                final isButtonEnabled =
                    state.inputValue.trim().isNotEmpty && !state.isSubmitting;
                return ElevatedButton.icon(
                  icon: state.isSubmitting
                      ? const SizedBox.shrink()
                      : const Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          _showSubmitDialog(context);
                        }
                      : null,
                  label: state.isSubmitting
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ))
                      : const Text('Submit Final Report'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSubmitDialog(BuildContext context) {
    final summaryController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Finalize and Submit Report'),
        content: TextField(
          controller: summaryController,
          maxLines: 3,
          decoration:
              const InputDecoration(hintText: "Enter a brief shift summary..."),
          onSubmitted: (value) {
            _addPendingNoteAndSubmit(context, value);
            Navigator.pop(dialogContext);
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _addPendingNoteAndSubmit(context, summaryController.text);
              Navigator.pop(dialogContext);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _addPendingNoteAndSubmit(BuildContext context, String summary) {
    final inputSectionState =
        context.findAncestorStateOfType<_InputSectionState>();
    if (inputSectionState != null &&
        inputSectionState.textController.text.trim().isNotEmpty) {
      context.read<ShiftHandoverBloc>().add(
            AddNewNote(inputSectionState.textController.text.trim(),
                inputSectionState.selectedType),
          );
      inputSectionState.textController.clear();
      context.read<ShiftHandoverBloc>().add(const InputChanged(''));
    }
    context.read<ShiftHandoverBloc>().add(SubmitReport(summary));
  }
}
