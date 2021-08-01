import 'package:buddy/user/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeSearchProvider with ChangeNotifier {
  final List<HomeSearchHelper> allUsersList = [];
  List<HomeSearchHelper> filteredList = [];
  List<String> tags = [];

  List<HomeSearchHelper> get suggestedUsers {
    return [...filteredList];
  }

  List<String> get allTags {
    return [...tags];
  }

  void removeTag(int index) {
    tags.removeAt(index);
    notifyListeners();
  }

  void setAllUsers(List<HomeSearchHelper> users) {
    allUsersList.clear();
    allUsersList.addAll(users);
    filteredList.clear();
    filteredList.addAll(users);
    notifyListeners();
  }

  void updateQuery(String query) {
    tags.clear();
    filteredList = allUsersList;
    final filters = query.trim().split(' ');
    tags = filters;

    filters.forEach((filter) {
      final newFilter = filteredList
          .where((element) => element.userModel.searchTag.contains(filter))
          .toList();
      filteredList = newFilter;
    });

    notifyListeners();
  }
}

//H://---( Here Model Class )---//
class HomeSearchHelper with ChangeNotifier {
  UserModel userModel;
  bool isPending;
  bool isFriend;

  HomeSearchHelper({
    required this.userModel,
    this.isPending = false,
    this.isFriend = false,
  });

  void toggleFriend() {
    isPending = true;
    notifyListeners();
  }
}
