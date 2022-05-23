import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:med_app/constants/colors.dart';
import 'package:med_app/models/users.dart';

class SearchController extends GetxController {
  final Rx<List<Users>> _searchUsers = Rx<List<Users>>([]);
  List<Users> get searchUsers => _searchUsers.value;

  searchUser(String typedUser) async {
    _searchUsers.bindStream(
      firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot snaps) {
          List<Users> retval = [];
          for (var elements in snaps.docs) {
            retval.add(Users.fromSnap(elements));
          }
          return retval;
        },
      ),
    );
  }
}
