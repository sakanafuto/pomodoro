// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/repository/pomo_repository.dart';

final pomoRepositoryProvider =
    Provider<PomoRepositoryImpl>(PomoRepositoryImpl.new);

class PomoRepositoryImpl implements PomoRepository {
  PomoRepositoryImpl(this._ref);

  // ignore: unused_field
  final Ref _ref;

  // @override
  // Future<void> save(PomoInfo pomoInfo) async {
  //   final pomo = Pomo(
  //     name: pomoInfo.name,
  //     minute: pomoInfo.minute,
  //     caption: pomoInfo.caption,
  //   );
  //   final box = Boxes.getPomos();
  //   await box.add(pomo);
  // }

  // @override
  // void delete(Pomo pomo) {
  //   pomo.delete();
  // }
}
