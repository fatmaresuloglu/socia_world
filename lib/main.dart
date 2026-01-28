import 'package:flutter/material.dart';
import 'profilePage.dart';

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
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    children: <Widget>[
                      notification("kamil gönderiyi beğendi", "3 dk önce"),
                      notification("Ayşe yorum yaptı", "36 dk önce"),
                      notification("Ali seni takip etti", "1 saat önce"),
                    ],
                  );
                },
              );
            },
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
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.purple[300],
        child: Icon(Icons.add_a_photo, color: Colors.white),
      ),
    );
  }

  Padding notification(String message, String timeAgo) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(message, style: TextStyle(fontSize: 15)),
          Text(timeAgo),
        ],
      ),
    );
  }

  Widget buildStoriesSection(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.symmetric(vertical: 10),
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
              builder: (context) => ProfilePage(
                name: name,
                imageUrl: imageUrl,
                coverImageUrl: imageUrl,
              ),
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
