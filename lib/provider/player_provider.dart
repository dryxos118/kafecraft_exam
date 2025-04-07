import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/player.dart';
import 'package:kafecraft_exam/provider/firebase_auth_provider.dart';

final playerNotifier = StateNotifierProvider<PlayerNotifier, Player?>(
    (ref) => PlayerNotifier(ref));

class PlayerNotifier extends StateNotifier<Player?> {
  Ref ref;
  PlayerNotifier(this.ref) : super(null);

  Future<bool> registerInFirebase(
      String email, String password, String firstName, String lastName) async {
    await ref
        .read(firebaseNotifier.notifier)
        .register(email: email, password: password)
        .then((value) async {
      if (value != null && value.user != null) {
        final user = Player(
            email: value.user!.email,
            firstName: firstName,
            lastName: lastName,
            id: value.user!.uid);
        await createNewUser(user);
      }
    });
    return false;
  }

  Future<void> createNewUser(Player user) async {
    try {
      var test = await FirebaseFirestore.instance
          .collection('users')
          .add(user.toMap());
      state = user.copyWith(id: test.id);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> loginInFirebase(String email, String password) async {
    try {
      final userCredential = await ref
          .read(firebaseNotifier.notifier)
          .login(email: email, password: password);
      if (userCredential != null && userCredential.user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where("email", isEqualTo: email)
            .get();
        state = Player.fromMap(snapshot.docs.first.data());
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> logoutFromFirebase() async {
    try {
      await ref.read(firebaseNotifier.notifier).logout();
      state = null;
      return true;
    } catch (error) {
      print(error);
    }
    return false;
  }
}
