import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream <String> get onAuthStateChanged  => _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid,);
  //email and pwd  signup
  Future<String> createUserWithEmailAndPassword(String email , String password) async{
     final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
     return currentUser.user.uid;

  }
  //siginwith emailandpwd
 Future<String>signInWithEmailAndPassword(String email , String password) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
 }
 //signout
signOut(){
    return _firebaseAuth.signOut();
}
}