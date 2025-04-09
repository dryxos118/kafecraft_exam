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

    if (exploitation == null || player == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'Ajouter un Champ${exploitation.fields.length >= 4 ? ' (15 DeeVee)' : ' (Gratuit)'}',
                ),
              ),
              const Spacer(),
              Chip(
                label: Text('${player.deeVee} deeVee'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: exploitation.fields.isEmpty
              ? const Center(child: Text('Aucune exploitation trouvée.'))
              : FieldList(fields: exploitation.fields),
        ),
      ],
    );
  }
}
