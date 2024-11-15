import 'dart:io';

import 'package:app_repositorio/utils.dart';
import 'package:flutter/material.dart';

class MainCard extends StatefulWidget {
  final String name;
  final String description;
  final String image;
  const MainCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
  });

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  bool heart = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 350,
              child: Column(
                children: [
                  Container(
                    height: 200,
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
                          ),
                          Expanded(
                            child: Text(
                              widget.description.corte(100),
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                            ),
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
