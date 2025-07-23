# Solution.md

## Issues Found

1. **Mutable Data Models**
   - Some models were not fully immutable or did not use Freezed.
2. **No Update/Delete for Notes**
   - Only add/read was implemented for notes; update and delete were missing.
3. **UI/UX Issues**
   - The submit button logic was unclear; note add and report submit were not clearly separated.
   - Edit/delete actions for notes were not present or not user-friendly.
   - Validation for empty notes was missing.
4. **State Management**
   - Some local state was used for input, not BLoC-driven.
   - Button enable/disable logic was not reactive.
5. **Testing**
   - Tests did not call DI setup, causing GetIt errors.
   - Widget tests did not match the current UI flow.
   - Default counter test was irrelevant.
6. **Error Handling**
   - No user feedback for note update/delete errors.
   - Success SnackBar was shown for all actions, not just report submission.

## Steps Taken to Fix

- Made all data models immutable using Freezed.
- Implemented full CRUD (add, update, delete) for notes in BLoC and UI.
- Added edit/delete icons to each note card, with dialogs for editing and confirmation for deleting.
- Refactored input section to use BLoC state for input value and validation.
- Submit button is now only enabled when input is non-empty, using BLoC state.
- Added validation to prevent empty notes from being added or edited.
- Only show success SnackBar for report submission, not for note update/delete.
- Updated widget/integration tests to:
  - Call DI setup in setUpAll.
  - Add notes by entering text and pressing Enter.
  - Match the current UI flow for editing, deleting, and submitting reports.
- Removed the default counter test.
- Added error handling and user feedback for all relevant actions.

## Additional Notes

- The service layer is in-memory only, as required.
- All business logic is in the BLoC, with UI as thin as possible.
- The codebase now follows Clean Architecture and DI best practices.
- All tests should now pass and reflect the real user flow.
- If you have further questions or want to see more documentation, let me know! 