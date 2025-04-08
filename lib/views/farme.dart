import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/provider/exploitation_provider.dart';
import 'package:kafecraft_exam/provider/player_provider.dart';
import 'package:kafecraft_exam/widget/farme/add_field_dialog.dart';
import 'package:kafecraft_exam/widget/farme/field_list.dart';

class Farme extends HookConsumerWidget {
  const Farme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exploitation = ref.watch(exploitationProvider);
    final player = ref.watch(playerNotifier);

    useEffect(() {
      Future.microtask(() {
        ref.read(exploitationProvider.notifier).initialize();
      });
      return null;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddFieldDialog(),
                  )
                },
                child: const Text('Ajouter un Champ (15 deeVee)'),
              ),
              const Spacer(),
              Chip(label: Text('${player!.deeVee} deeVee'))
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: exploitation == null || exploitation.fields.isEmpty
              ? const Center(child: Text('Aucune exploitation trouvée.'))
              : FieldList(fields: exploitation.fields),
        ),
      ],
    );
  }
}

class AddFieldBottomSheet {
  const AddFieldBottomSheet();
}
