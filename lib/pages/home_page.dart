import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../models/animals_data.dart';
import '../widgets/animal_card.dart';
import 'animal_detail_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedType = 'Semua';

  List<String> get _types => [
    'Semua',
    ...dummyAnimals.map((animal) => animal.type).toSet(),
  ];

  List<Animal> get _visibleAnimals {
    return dummyAnimals.where((animal) {
      final matchesType =
          _selectedType == 'Semua' || animal.type == _selectedType;
      final query = _searchQuery.toLowerCase();
      final matchesSearch =
          animal.name.toLowerCase().contains(query) ||
          animal.type.toLowerCase().contains(query) ||
          animal.habitat.any((place) => place.toLowerCase().contains(query));
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openAnimal(Animal animal) {
    // Ketika satwa dipilih, buka halaman detail dengan membawa data satwanya.
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => AnimalDetailPage(animal: animal)),
    );
  }

  void _logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animals = _visibleAnimals;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.eco_outlined, color: Color(0xFF24594D)),
            const SizedBox(width: 9),
            Text(
              'Fauna Atlas',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1240),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Koleksi satwa',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${dummyAnimals.length} penghuni dari beragam habitat',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: const Color(0xFF69736C)),
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: _searchController,
                            onChanged: (value) =>
                                setState(() => _searchQuery = value.trim()),
                            decoration: InputDecoration(
                              hintText: 'Cari nama, tipe, atau habitat',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchQuery.isEmpty
                                  ? null
                                  : IconButton(
                                      tooltip: 'Hapus pencarian',
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() => _searchQuery = '');
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _types.map((type) {
                                final selected = _selectedType == type;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(type),
                                    selected: selected,
                                    onSelected: (_) =>
                                        setState(() => _selectedType = type),
                                    selectedColor: const Color(0xFFDCE9DF),
                                    side: BorderSide(
                                      color: selected
                                          ? const Color(0xFF24594D)
                                          : const Color(0xFFE1E5DC),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${animals.length} satwa ditampilkan',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: const Color(0xFF69736C)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (animals.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('Tidak ada satwa yang cocok.')),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  sliver: SliverLayoutBuilder(
                    builder: (context, sliverConstraints) {
                      final availableWidth = sliverConstraints.crossAxisExtent;
                      final contentWidth = availableWidth > 1280
                          ? 1240.0
                          : availableWidth;
                      final crossAxisCount = contentWidth >= 1050
                          ? 3
                          : contentWidth >= 650
                          ? 2
                          : 1;

                      // Tampilkan daftar hewan dalam grid yang jumlah kolomnya
                      // menyesuaikan lebar layar desktop maupun ponsel.
                      return SliverGrid.builder(
                        itemCount: animals.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisExtent: 340,
                          crossAxisSpacing: 18,
                          mainAxisSpacing: 18,
                        ),
                        itemBuilder: (context, index) => AnimalCard(
                          animal: animals[index],
                          onTap: () => _openAnimal(animals[index]),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
