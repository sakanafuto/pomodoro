// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:pomodoro/model/shaft/shaft_state.dart';
import 'package:pomodoro/screen/shaft/shaft_view_model.dart';

/// shaftState を監視する
final shaftViewModelProvider =
    NotifierProvider<ShaftViewModel, ShaftState>(ShaftViewModel.new);
