/// ------------------------------------------------------------------------

/// [Image Urls]

/// ------------------------------------------------------------------------

/// Description: Image Urls Model

/// Author(s): Sharan

/// Date Approved: 08-06-2020

/// Date Created: 10-06-2020

/// Approved By: Everyone

/// Reviewed By: Everyone

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. url - String
///           2. name - String
///           3. id - String
///           4. tags - List

/// Output(s):

/// ------------------------------------------------------------------------

/// Error-Handling(s):

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th June, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

class ImageUrls {
  final String url;
  final String name;
  final String id;
  List tags = new List();

  ImageUrls({this.url, this.name, this.id, this.tags});
}
