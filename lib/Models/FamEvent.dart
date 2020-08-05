/// ------------------------------------------------------------------------

/// [FamEvent]

/// ------------------------------------------------------------------------

/// Description: FamEvent Model

/// Author(s): Sharan

/// Date Approved: 08-06-2020

/// Date Created: 10-06-2020

/// Approved By: Everyone

/// Reviewed By: Everyone

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. id - String
///           2. title - String
///           3. description - String
///           4. eventDate - String

/// Output(s):

/// ------------------------------------------------------------------------

/// Error-Handling(s):

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th June, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------
class EventModel {
  final String id;
  final String title;
  final String description;
  final String eventDate;

  EventModel({this.id, this.title, this.description, this.eventDate});
}
