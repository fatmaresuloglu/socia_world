import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String coverImageUrl; // Dışarıdan gelecek kapak resmi

  // TEK BİR CONSTRUCTOR OLMALI
  const ProfilePage({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.coverImageUrl, // Bunu zorunlu yaptık
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // KAPAK FOTOĞRAFI
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // ARTIK BURASI DİNAMİK
                      image: NetworkImage(coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Text(
              name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            // Aksiyon Butonları
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Takip Et",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mail_outline,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 50, thickness: 1, indent: 20, endIndent: 20),

            // Galeri / İçerik Alanı
            const Column(
              children: [
                Icon(Icons.grid_on_rounded, size: 40, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "Bu kullanıcının henüz galerisi yok.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 40), // Alt kısımda nefes payı
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget'ını buraya eklemeyi unutma
  Widget _buildProfileStat(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
        ),
      ],
    );
  }
}
