import 'package:flutter/material.dart';
import 'buildPostCard.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ), // Nokta hatası düzeltildi
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0, // Daha modern görünüm için 0 yaptık
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
            icon: Icon(Icons.notifications, color: Colors.purple),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // Hikayeler Bölümü
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            height: 120, // İsimler de sığsın diye yüksekliği artırdık
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                const SizedBox(width: 10), // Başlangıç boşluğu
                buildStoryItem('Selçuk', 'https://picsum.photos/200'),
                buildStoryItem('Fatma', 'https://picsum.photos/201'),
                buildStoryItem('Ali', 'https://picsum.photos/202'),
                buildStoryItem('Zeynep', 'https://picsum.photos/203'),
                buildStoryItem('Hakan', 'https://picsum.photos/204'),
              ],
            ),
          ),

          // Buraya postlar veya diğer içerikler gelecek...
          SizedBox(height: 10),
          BuildPostCard(),
        ],
      ),
    );
  }

  // Hikaye widget'ını oluşturan fonksiyon (Daha temiz kod!)
  Widget buildStoryItem(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Stack(
            // Online göstergesini konumlandırmak için Stack en dışta kalsın
            children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Gölge Eklendi
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 118, 193, 230),
                      Colors.orange,
                    ],
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
              // Yeşil Çemberi Positioned ile Sabitliyoruz
              Positioned(
                bottom: 2, // Alt köşeye yakın
                right: 2, // Sağ köşeye yakın
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
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
