class Validators {
  Validators._();

  static final Validators instance = Validators._();

  List<String> splitFirstNameAndLastName(String name) {
    List<String> nameList = [];
    List<String> parts = name.split(' ');

    String firstName = parts[0];
    String lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    nameList.add(firstName);
    nameList.add(lastName);

    return nameList;
  }
}
