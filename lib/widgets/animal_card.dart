import 'package:flutter/material.dart';

import '../models/animal.dart';
import 'animal_image.dart';

class AnimalCard extends StatelessWidget {
  const AnimalCard({required this.animal, required this.onTap, super.key});

  final Animal animal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      // Seluruh kartu dapat diketuk untuk membuka detail hewan.
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                // Foto hewan ditampilkan dari URL pada data satwa.
                child: AnimalImage(url: animal.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 13, 16, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama dan tipe hewan ditampilkan sebagai identitas satwa.
                  Text(
                    animal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF202B27),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    animal.type,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: colors.primary),
                  ),
                  const SizedBox(height: 11),
                  // Tampilkan setiap habitat hewan sebagai label.
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: animal.habitat
                        .map(
                          (place) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F3EC),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              place,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
