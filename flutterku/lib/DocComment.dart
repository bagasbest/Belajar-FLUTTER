import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final UserProfile user = UserProfile(
    name: "Seo Dal-Mi",
    role: "CEO",
    photoUrl:
        "https://cdn.idntimes.com/content-images/community/2020/11/123119243-209479280612162-595516036712319994-n-121c150c3ca31357db71d7745a8120bf_600x400.jpg",
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Doc Comment Example"),
        ),
        body: Center(
          child: user,
        ),
      ),
    );
  }
}

/// class UserProfile digunakan untuk menampilkan profil user ke layar dengan indah
class UserProfile extends StatelessWidget {
  /// field ini digunakan untuk menyimpan nama user
  final String name;
  final String role;
  final String photoUrl;

  /// * [name] berisi nama user nilai defaultnya adalah `No name`.
  ///
  ///* [role] berisi jabatan user `No role`.
  ///
  ///* [photoUrl] berisi link foto user
  UserProfile({this.name = "No name", this.role = "No role", this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image(
            width: 200,
            height: 200,
            image: NetworkImage((photoUrl != null)
                ? photoUrl
                : "https://cdn.idntimes.com/content-images/community/2020/11/123119243-209479280612162-595516036712319994-n-121c150c3ca31357db71d7745a8120bf_600x400.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(role),
      ],
    );
  }
}
