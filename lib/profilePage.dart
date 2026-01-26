import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProfilePage({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Profil Detayları Buraya Gelecek",
            style: TextStyle(color: Colors.grey),
          ),
          const Divider(),
          // Buraya kişinin eski postlarını ekleyebilirsin
        ],
      ),
    );
  }
}
