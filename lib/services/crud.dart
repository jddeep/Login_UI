import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods{

  bool isLoggedIn(){
     if(FirebaseAuth.instance.currentUser() != null){
       return true;
     }else{
       return false;
     }
  }

Future<void> addData(playerData) async{
  if(isLoggedIn()){
     Firestore.instance.collection('CrudTest').add(playerData).catchError((e){
        print(e);
     });
  }else{
    print('Log in please');
  }
}

getData() async{
   return await Firestore.instance.collection('CrudTest').getDocuments();
}

}