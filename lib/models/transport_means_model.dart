class Driver {
  final String imagePath;
  final String firstName;
  final String lastName;
  final String checksum;
  final String licenseNo;
  final String licenseExpiry;

  const Driver({
    required this.firstName,
    required this.lastName,
    required this.imagePath,
    required this.checksum,
    required this.licenseNo,
    required this.licenseExpiry,
  });
}
