import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsuarios () async {
   List usuarios = [];

   CollectionReference collectionReferenceUsuarios = db.collection('usuarios');

  QuerySnapshot queryUsuarios = await collectionReferenceUsuarios.get();

  queryUsuarios.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final person ={
      "uid": documento.id,
      "nombre": data['nombre'],
      "email": data['email'],
      "nocuenta": data['nocuenta'],
    };

    usuarios.add(person);
  });
    return usuarios;
}

Future<void> agregarUsuario(String nNombre, String nEmail, String nCuenta) async {
  //CollectionReference collectionReferenceUsuarios = db.collection('usuarios');

  await db.collection('usuarios').add({
    'nombre': nNombre,
    'email': nEmail,
    'nocuenta': nCuenta,
  });
}

//Future para editar usuario
Future<void> editUsuario(String uid, String eNombre, String eMail, String eCuenta) async {
  await db.collection('usuarios').doc(uid).set({"nombre": eNombre, "email": eMail, "nocuenta": eCuenta});
}

Future<void> deleteUsuario(String uid) async {
  await db.collection('usuarios').doc(uid).delete();
}




