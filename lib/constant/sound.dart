import 'dart:io';

import 'package:soundpool/soundpool.dart';

final pool = Soundpool.fromOptions(
  options: const SoundpoolOptions(
    maxStreams: 5,
  ),
);

bool isIos = Platform.isIOS;
