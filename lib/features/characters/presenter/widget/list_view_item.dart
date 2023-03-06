import 'package:flutter/material.dart';
import 'package:pagination_challenge/shared/routes/route_generator.dart';

import '../../domain/entities/entities.dart';

import '../components/components.dart';

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.DETAILS, arguments: character);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.network(
                character.image,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(character.name),
                Text(character.species),
              ],
            )
          ],
        ),
      ),
    );
  }
}
