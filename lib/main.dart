import 'package:flutter/material.dart';

// 1. VERİ MODELİ
class PostModel {
  final String userName;
  final String userImage;
  final String timeAgo;
  final String description;
  final String postImage;
  final String likeCount;
  final String commentCount;

  PostModel({
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.description,
    required this.postImage,
    required this.likeCount,
    required this.commentCount,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SociaWorld',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

// 2. ANA SAYFA
class MyHomePage extends StatelessWidget {
  final List<PostModel> posts = [
    PostModel(
      userName: "Selçuk",
      userImage: "https://picsum.photos/id/1/200",
      timeAgo: "5 dk önce",
      description: "Bugün hava harika, yeni kodlar yazılıyor! 🚀",
      postImage: "https://picsum.photos/id/10/400/250",
      likeCount: "1.2k",
      commentCount: "45",
    ),
    PostModel(
      userName: "Ayşe",
      userImage: "https://picsum.photos/id/64/200",
      timeAgo: "1 saat önce",
      description: "Favori kahvem ve kitabım... ☕📚",
      postImage: "https://picsum.photos/id/1060/400/250",
      likeCount: "850",
      commentCount: "12",
    ),
    PostModel(
      userName: "Hakan",
      userImage: "https://picsum.photos/id/91/200",
      timeAgo: "3 saat önce",
      description: "Flutter ile UI geliştirmek gerçekten keyifli.",
      postImage: "https://picsum.photos/id/3/400/250",
      likeCount: "2.1k",
      commentCount: "89",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // İSTEDİĞİN APPBAR BURADA
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          onPressed: () => print("Menü tıklandı"),
          icon: Icon(Icons.menu, color: Colors.grey[600]),
        ),
        title: Text(
          'SociaWorld',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => print("Bildirimler tıklandı"),
            icon: const Icon(Icons.notifications, color: Colors.purple),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          buildStoriesSection(context),
          const SizedBox(height: 10),
          ...posts.map((postItem) => BuildPostCard(post: postItem)).toList(),
        ],
      ),
    );
  }

  Widget buildStoriesSection(BuildContext context) {
    return Container(
      height: 125,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(width: 10),
          buildStoryItem(context, 'Selçuk', 'https://picsum.photos/id/1/200'),
          buildStoryItem(context, 'Fatma', 'https://picsum.photos/id/102/200'),
          buildStoryItem(context, 'Ali', 'https://picsum.photos/id/103/200'),
          buildStoryItem(context, 'Zeynep', 'https://picsum.photos/id/104/200'),
          buildStoryItem(context, 'Hakan', 'https://picsum.photos/id/91/200'),
        ],
      ),
    );
  }

  Widget buildStoryItem(BuildContext context, String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(name: name, imageUrl: imageUrl),
            ),
          );
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.orange],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. PROFİL SAYFASI
class ProfilePage extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProfilePage({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(radius: 60, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 15),
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

// 4. POST KARTI
class BuildPostCard extends StatelessWidget {
  final PostModel post;
  const BuildPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(post.userImage),
              ),
              title: Text(
                post.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(post.timeAgo),
              trailing: const Icon(Icons.more_vert),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(post.description),
            ),
            Image.network(
              post.postImage,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(Icons.favorite_border, post.likeCount),
                  _buildActionButton(Icons.comment_outlined, post.commentCount),
                  _buildActionButton(Icons.share_outlined, ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 24),
            if (label.isNotEmpty) ...[const SizedBox(width: 5), Text(label)],
          ],
        ),
      ),
    );
  }
}
