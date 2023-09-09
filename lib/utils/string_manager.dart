class StringManager {
  static const String name = "Name";
  static const String password = "Password";
  static const String somethingWentWrong = "Something went wrong";
  static const String passwordLengthError =
      "Password length cannot be less than 6";
  static const String register = "Register";
  static const String multiplayer = "Multiplayer";
  static const String vsPlayer = "VS Player";
  static const String vsComputer = "VS Computer";
  static const String email = "Email";
  static const String emptyFieldsMessage =
      "Please fill all the required fields [Email , Password]";
  static const String successfullyRegistered = "Successfully registered";
  static const String player = "Player";
  static const String playerName = "Player name";
  static const String searchForPlayer = "Search for player";
  static const String search = "Search";
  static const String cannotCreateMatch = "Can't create a match right now.";
  static const String inviteAPlayer = "Invite a player";
  static const String acceptAnInvite = "Accept an invitation";
  static const String matchId = "Match ID";
  static const String waitingForAnotherPlayer = "Waiting for another player";

  //Functions
  static String duplicatedName({required String name}) {
    return "$name is already taken.";
  }

  static String playerNotfound({required String name}) {
    return "Player $name was not found";
  }

  static String matchIdMessage({required int id}) {
    return "Match ID: $id.";
  }
}
