import 'package:flutter/material.dart';

class AnimalImage extends StatelessWidget {
  const AnimalImage({required this.url, this.fit = BoxFit.cover, super.key});

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: const Color(0xFFE5E9DF),
        child: Center(
          child: Icon(
            Icons.pets_outlined,
            size: 42,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const ColoredBox(
          color: Color(0xFFE5E9DF),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
    );
  }
}
