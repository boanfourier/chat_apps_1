import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String username;
  final String userImage;
  final String? message;
  final String? imageUrl;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.username,
    required this.userImage,
    required this.message,
    required this.imageUrl,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
          const SizedBox(width: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 200,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null)
                Image.network(
                  imageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              if (message != null)
                Text(
                  message!,
                  style: TextStyle(
                    color: isMe ? Colors.black : Colors.white,
                  ),
                ),
            ],
          ),
        ),
        if (isMe) ...[
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ],
      ],
    );
  }
}
