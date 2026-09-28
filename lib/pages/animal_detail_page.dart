import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../widgets/animal_image.dart';

class AnimalDetailPage extends StatelessWidget {
  const AnimalDetailPage({required this.animal, super.key});

  final Animal animal;

  String _formatNumber(num value) => value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toString();

  Widget _buildTag(BuildContext context, String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 17, color: const Color(0xFF24594D)),
      label: Text(label),
      backgroundColor: const Color(0xFFF1F3EC),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildStat(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE7E9E1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF24594D)),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: const Color(0xFF69736C)),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    // Susun seluruh data satwa: tipe, tinggi, berat, habitat, dan aktivitas.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tentang satwa',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          animal.type,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: const Color(0xFF69736C)),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _buildStat(
              context,
              icon: Icons.height,
              label: 'Tinggi',
              value: '${_formatNumber(animal.height)} cm',
            ),
            const SizedBox(width: 12),
            _buildStat(
              context,
              icon: Icons.monitor_weight_outlined,
              label: 'Berat',
              value: '${_formatNumber(animal.weight)} kg',
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          'Habitat',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 2,
          children: animal.habitat
              .map((place) => _buildTag(context, place, Icons.place_outlined))
              .toList(),
        ),
        const SizedBox(height: 22),
        Text(
          'Aktivitas',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 2,
          children: animal.activities
              .map((activity) => _buildTag(context, activity, Icons.bolt))
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar menyediakan tombol kembali otomatis ke halaman Home.
          SliverAppBar(
            pinned: true,
            expandedHeight: 390,
            title: Text(animal.name),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  AnimalImage(url: animal.image),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0x990D211A)],
                        stops: [0.5, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Text(
                      animal.name,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Batasi lebar dan susun informasi agar tetap rapi di layar lebar
          // maupun ponsel.
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 760) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildDetails(context)),
                            const SizedBox(width: 52),
                            Expanded(
                              child: Text(
                                'Setiap satwa memiliki cara unik untuk hidup dan beradaptasi di lingkungannya.',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: const Color(0xFF69736C),
                                      height: 1.6,
                                    ),
                              ),
                            ),
                          ],
                        );
                      }
                      return _buildDetails(context);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
