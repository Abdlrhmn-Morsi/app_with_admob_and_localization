import 'package:flutter/material.dart';
import 'app_localizations.dart';

extension TranslateX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}


