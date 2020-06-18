import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:iusefully/NewTask/NewTask_PageView.dart';

/*
  This file talks with Firestore and Google Services.
*/

class AuthService{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  Future<String> getCurrentID() async{
    return (await _auth.currentUser()).uid;
  }

  


  AuthService(){
    user = Observable(_auth.onAuthStateChanged);
    profile = user.switchMap((FirebaseUser u){
      if (u != null){
        return _db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
      }else{
        return Observable.just({});
      }
    });
  }

  
  

  Future<FirebaseUser> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    loading.add(false);

    checkExist() async{
      DocumentSnapshot ds = await _db.collection("users").document(user.uid).get();
      ds.exists ? print("exists") : authService.updateUserData(user);
    }
    checkExist();

    print("signed in " + user.displayName);
    return user;
  }



  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    return ref.setData({
      "uid": user.uid,
      "displayName": user.displayName,
      "titles": titles,
      "contents": contents,
      "rewards": rewards,

      "log_titles": log_titles,
      "log_rewards": log_rewards,
    });
  }

  void createNewTask(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    print("$titles $contents $rewards");
    return ref.setData({
      "titles": titles,
      "contents": contents,
      "rewards": rewards,
      "log_titles": log_titles,
      "log_rewards": log_rewards,
    }, merge: true);
  }

  void signOut() async {
    await _auth.signOut();
  }
}

final AuthService authService = AuthService();
