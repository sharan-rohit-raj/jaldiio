/// ------------------------------------------------------------------------

/// [UserValue]

/// ------------------------------------------------------------------------

/// Description: User Value Model

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
///           2. date - String
///           3. phoneNum - int
///           4. familyID - String
///           5. admin - bool
///           6. joined - bool
///           7. uid - String
///           8. status - Strign

/// Output(s):

/// ------------------------------------------------------------------------

/// Error-Handling(s):

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th June, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

class UserValue {
  final String uid;
  final String name;
  final String status;
  final String date;
  final int phoneNum;
  final String familyID;
  final bool admin;
  final bool joined;

  UserValue(
      {this.uid,
      this.name,
      this.phoneNum,
      this.date,
      this.status,
      this.familyID,
      this.admin,
      this.joined});
}
