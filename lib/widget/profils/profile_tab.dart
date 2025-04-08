import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'profile_info.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Informations'),
              Tab(text: 'Derniere competition'),
            ],
            labelColor: Color(0xff00796b),
            indicatorColor: Color(0xff00796b),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ProfileInfo(),
                Center(
                  child: Text("En cours de dev"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
