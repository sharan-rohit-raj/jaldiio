/// ------------------------------------------------------------------------

/// [Contact]

/// ------------------------------------------------------------------------

/// Description: Contact Model

/// Author(s): Sharan

/// Date Approved: 08-06-2020

/// Date Created: 10-06-2020

/// Approved By: Everyone

/// Reviewed By: Everyone

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. name - String
///           2. emaild - String
///           3. phNo - int
///           4. joined - bool
///           5. uid - String
///           6. photoURL - String

/// Output(s):

/// ------------------------------------------------------------------------

/// Error-Handling(s):

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th June, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

class Contact {
  final String name;
  final String emaild;
  final int phNo;
  final bool joined;
  final String uid;
  final String photoURL;

  Contact(
      {this.name,
      this.emaild,
      this.phNo,
      this.joined,
      this.uid,
      this.photoURL});
}
