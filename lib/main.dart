import 'package:flutter/material.dart';
import 'package:pagination_challenge/core/app/pagination_app.dart';

import 'core/di/global_dependece.dart';

void main() async {
  await GlobalDependencies().setup();
  runApp(App());
}
