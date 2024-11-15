import 'dart:io';

import 'package:app_repositorio/utils.dart';
import 'package:flutter/material.dart';

class MainCardList extends StatefulWidget {
  final String name;
  final String description;
  final String image;
  const MainCardList({
    super.key,
    required this.image,
    required this.name,
    required this.description,
  });

  @override
  State<MainCardList> createState() => _MainCardListState();
}

class _MainCardListState extends State<MainCardList> {
  bool heart = false;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, minWidth: 300),
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 160,
                  height: 120,
                  color: Colors.grey,
                  child: Image.file(
                    File(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          widget.description.corte(80),
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() => heart = !heart);
                              },
                              icon: Icon(
                                heart ? Icons.favorite : Icons.favorite_outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (heart)
            const Positioned(
              top: 12,
              left: 12,
              child: Icon(Icons.bookmark),
            ),
        ],
      ),
    );
  }
}
