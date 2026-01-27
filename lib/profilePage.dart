import 'package:flutter/material.dart';

// 3. PROFİL SAYFASI
class ProfilePage extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProfilePage({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => print("bilgiler tıklandı"),
            icon: const Icon(Icons.more_vert, color: Colors.grey),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250,
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -15,
                left: 5,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                  child: CircleAvatar(
                    radius: 7.5,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ],
          ),

          Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "SociaWorld Kullanıcısı",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat("Takipçi", "1.2k"),
              _buildProfileStat("Takip", "350"),
              _buildProfileStat("Gönderi", "8"),
            ],
          ),
          const Divider(height: 40, thickness: 1),
          const Expanded(
            child: Center(
              child: Text(
                "Bu kullanıcının henüz galerisi yok.",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
