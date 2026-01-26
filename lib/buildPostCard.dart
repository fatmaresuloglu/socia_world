import 'package:flutter/material.dart';

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

class BuildPostCard extends StatelessWidget {
  // Constructor: Dışarıdan post verilerini alır
  final PostModel post;

  const BuildPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ÜST KISIM (Profil Resmi ve İsim dinamik oldu)
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

                // AÇIKLAMA (Dinamik)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(post.description),
                ),

                // RESİM (Dinamik)
                Image.network(
                  post.postImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                // ALT BUTONLAR (Sayılar dinamik)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        Icons.favorite_border,
                        post.likeCount,
                        Colors.grey,
                        () {},
                      ),
                      _buildActionButton(
                        Icons.comment_outlined,
                        post.commentCount,
                        Colors.grey,
                        () {},
                      ),
                      _buildActionButton(
                        Icons.share_outlined,
                        '',
                        Colors.grey,
                        () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
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
