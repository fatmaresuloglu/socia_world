import 'package:flutter/material.dart';

// PostModel: Veri yapısını tanımlıyoruz
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

class MyHomePage extends StatelessWidget {
  // Gönderi listemiz (Buraya yeni ekleme yapman yeterli)
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
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
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
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.purple),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // 1. Bölüm: Hikayeler
          buildStoriesSection(),

          const SizedBox(height: 10),

          // 2. Bölüm: Dinamik Post Listesi
          // Spread operator (...) kullanarak listeyi ana ListView içine yayıyoruz
          ...posts.map((postItem) => BuildPostCard(post: postItem)).toList(),
        ],
      ),
    );
  }

  // Yatay Hikaye Listesi
  Widget buildStoriesSection() {
    return Container(
      height: 120,
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
          buildStoryItem('Selçuk', 'https://picsum.photos/200'),
          buildStoryItem('Fatma', 'https://picsum.photos/201'),
          buildStoryItem('Ali', 'https://picsum.photos/202'),
          buildStoryItem('Zeynep', 'https://picsum.photos/203'),
          buildStoryItem('Hakan', 'https://picsum.photos/204'),
        ],
      ),
    );
  }

  // Hikaye Balonu Widget'ı
  Widget buildStoryItem(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                width: 75,
                height: 75,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

// BuildPostCard Widget'ı (Dinamik ve Tıklanabilir)
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
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
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
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionButton(
                      Icons.favorite_border,
                      post.likeCount,
                      Colors.grey,
                      () => print("Beğen"),
                    ),
                    _buildActionButton(
                      Icons.comment_outlined,
                      post.commentCount,
                      Colors.grey,
                      () => print("Yorum"),
                    ),
                    _buildActionButton(
                      Icons.share_outlined,
                      '',
                      Colors.grey,
                      () => print("Paylaş"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ],
        ),
      ),
    );
  }
}
