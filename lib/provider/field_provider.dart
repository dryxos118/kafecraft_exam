import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kafecraft_exam/model/field.dart';
import 'package:kafecraft_exam/model/plant.dart';
import 'package:kafecraft_exam/model/cafe_type.dart';
import 'package:kafecraft_exam/provider/exploitation_provider.dart';

final selectedFieldProvider =
    StateNotifierProvider<SelectedFieldNotifier, Field?>(
  (ref) => SelectedFieldNotifier(ref),
);

class SelectedFieldNotifier extends StateNotifier<Field?> {
  final Ref ref;

  SelectedFieldNotifier(this.ref) : super(null);

  void setField(Field field) {
    state = field;
  }

  void clearField() {
    state = null;
  }

  Future<void> addPlant(int plantIndex, CafeType cafeType) async {
    if (state == null) return;

    Plant newPlant = Plant(
      cafeType: cafeType,
      plantedAt: DateTime.now(),
    );

    List<Plant> updatedPlants = List.from(state!.plants);
    updatedPlants[plantIndex] = newPlant;

    Field updatedField = state!.copyWith(plants: updatedPlants);
    state = updatedField;

    ref.read(exploitationProvider.notifier).updateField(updatedField);
  }

  Future<void> harvestPlant(int plantIndex) async {
    if (state == null) return;

    List<Plant> updatedPlants = List.from(state!.plants);
    updatedPlants[plantIndex] = Plant.empty();

    Field updatedField = state!.copyWith(plants: updatedPlants);
    state = updatedField;

    ref.read(exploitationProvider.notifier).updateField(updatedField);
  }
}
