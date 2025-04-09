import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/assembly_provider.dart';
import 'package:kafecraft_exam/widget/stock/assembly_card.dart';

class AssemblyTab extends HookConsumerWidget {
  const AssemblyTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assembliesAsync = ref.watch(assemblyStreamProvider);

    if (assembliesAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final assemblies = assembliesAsync.value;
    if (assemblies == null || assemblies.isEmpty) {
      return const Center(child: Text("Aucun assemblage pour le moment"));
    }

    final sortedAssemblies = [...assemblies]..sort((a, b) {
        return b.isRegister.toString().compareTo(a.isRegister.toString());
      });

    return ListView.builder(
      itemCount: sortedAssemblies.length,
      itemBuilder: (context, index) {
        return AssemblyCard(assembly: sortedAssemblies[index]);
      },
    );
  }
}
