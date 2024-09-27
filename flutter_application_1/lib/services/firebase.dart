// services/firebase.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
 
 // get Collection name codes From Firebase
 CollectionReference codes = FirebaseFirestore.instance.collection('codes');


 // Create a new document in the collection

    createCode(String code) async {
      print("mon code est $code");
      await codes.add({
      'code': code,  
      }).then((response) => print("ok"))
      .catchError((error) => print("erreur $error"));
    } 


    // Get all the documents in the collection

    Stream<QuerySnapshot> getCodes()  {

      final getCodes = codes.snapshots();
      print(getCodes);

      return getCodes;
     
    }
}