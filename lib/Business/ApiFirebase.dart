// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:taxis_app/Business/Provider/TaxiProvider.dart';
// import 'package:taxis_app/Models/TaxiModel.dart';  
// class ApiFirebase{

//    consultaTaxis(TaxiProvider taxiProvider){
//     List<TaxiModel> listaTaxis = [];
//     FirebaseFirestore.instance
//     .collection('taxis')
//     .snapshots().listen((querySnapshot) {
//       print("""
//       ================================================================
//       """); 
//       querySnapshot.docs.forEach((doc) {
//       print("""
//       ##########
//       """); 

//       TaxiModel taxiModel = TaxiModel.fromJson(doc.data());

//       print(doc.data());
//       listaTaxis.add(taxiModel);
//       }); 
//       taxiProvider.listaTaxis = listaTaxis;
//       // return listaOrderFinalModel;
//     }).onError((c){
//       print("ERROR $c");
//       // return listaOrderFinalModel;
//     });
//   }

// }