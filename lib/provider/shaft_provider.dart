// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/screen/shaft/shaft_view_model.dart';

/// shaftState を監視する
final shaftViewModelProvider = StateNotifierProvider(ShaftViewModel.new);
