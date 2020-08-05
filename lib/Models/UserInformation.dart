/// ------------------------------------------------------------------------

/// [UserInformation]

/// ------------------------------------------------------------------------

/// Description: User Information Model

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
///           2. status - String
///           3. phoneNum - int
///           4. age - int

/// Output(s):

/// ------------------------------------------------------------------------

/// Error-Handling(s):

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th June, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

class UserInformation {
  final String name;
  final String status;
  final int age;
  final int phoneNum;

  UserInformation({this.name, this.phoneNum, this.age, this.status});
}
