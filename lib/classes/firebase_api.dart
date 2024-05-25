import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAPI {
  static recuperarSenha(String email) async {
    return await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) => value)
        .onError((error, stackTrace) => error);
  }

  static Future<void> alterarSenha(String senha) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(senha);
  }

  static Future<void> alterarEmail(String email) async {
    await FirebaseAuth.instance.currentUser!.updateEmail(email);
  }

  static Future<void> alterarNome(String nome) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(nome);
  }

  static Future<void> alterarFoto(String foto) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(foto);
  }

  static Future<void> deletarConta() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> login(String email, String senha) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: senha,
        )
        .then((value) => value.user!.getIdToken());
  }

  static Future<void> cadastrar(String email, String senha) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }

  static Future<bool> isLogado() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<String?> getNome() async {
    return FirebaseAuth.instance.currentUser!.displayName;
  }

  static Future<String?> getFoto() async {
    return FirebaseAuth.instance.currentUser!.photoURL;
  }

  static Future<String?> getEmail() async {
    return FirebaseAuth.instance.currentUser!.email;
  }

  static Future<String?> getUID() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<String?> getToken() async {
    return FirebaseAuth.instance.currentUser!.getIdToken();
  }

  static Future<String?> getRefreshToken() async {
    return FirebaseAuth.instance.currentUser!.getIdToken(true);
  }
}
