import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final String hours;

  final List<String>? avatars;

  const TaskItem({
    super.key,
    required this.title,
    required this.hours,
    this.avatars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.flag_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(hours),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          if (avatars != null && avatars!.isNotEmpty)
            SizedBox(
              width: 120, // You can adjust this depending on how many avatars
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: List.generate(avatars!.length>4? 4:avatars!.length, (index) {
                        return Positioned(
                          left: index * 22.0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 17,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(avatars![index]),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  if (avatars!.length > 4)
                    Text('+${avatars!.length - 4}',
                        style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}