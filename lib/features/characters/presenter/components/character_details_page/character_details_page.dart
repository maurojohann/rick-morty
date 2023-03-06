import 'package:flutter/material.dart';

import 'package:pagination_challenge/features/characters/domain/entities/entities.dart';
import 'package:palette_generator/palette_generator.dart';

class CharacterDetailsPage extends StatefulWidget {
  final CharacterEntity character;
  const CharacterDetailsPage({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  var color = [Colors.white, Colors.white10];
  @override
  void initState() {
    super.initState();
    palletGenerator().then((value) {
      setState(() {
        color = value.colors.toList();
      });
    });
  }

  Future<PaletteGenerator> palletGenerator() {
    return PaletteGenerator.fromImageProvider(
      NetworkImage(widget.character.image),
      size: const Size(80, 80),
      maximumColorCount: 3,
    );
  }

  TextStyle get textStyleTable => const TextStyle(fontSize: 18, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(220.0),
          child: AppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.character.name,
                style: const TextStyle(fontSize: 24, color: Colors.black87),
              ),
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              background: Container(
                padding: const EdgeInsets.only(bottom: 60, top: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: color),
                ),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    widget.character.image,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Table(
            children: [
              TableRow(
                children: [
                  Text('Id:', style: textStyleTable),
                  Text(widget.character.id.toString(), style: textStyleTable),
                ],
              ),
              TableRow(
                children: [
                  Text('Espécie:', style: textStyleTable),
                  Text(widget.character.species, style: textStyleTable),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
