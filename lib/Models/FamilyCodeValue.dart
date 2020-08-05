/// ------------------------------------------------------------------------

/// [FamilyCodeValue]

/// ------------------------------------------------------------------------

/// Description: Family Code Value Model

/// Author(s): Sharan

/// Date Approved: 08-06-2020

/// Date Created: 10-06-2020

/// Approved By: Everyone

/// Reviewed By: Everyone

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. familyID - String
///           2. uid - String
///           3. admin - bool

/// Output(s):

/// ------------------------------------------------------------------------

/// Error-Handling(s):

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th June, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

class FamilyCodeValue {
  final String familyID;
  final String uid;
  final bool admin;

  FamilyCodeValue({this.familyID, this.uid, this.admin});
}
