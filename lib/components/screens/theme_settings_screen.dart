import 'package:flutter/material.dart';
import 'package:harpy/components/widgets/shared/scaffolds.dart';
import 'package:harpy/components/widgets/theme/theme_card.dart';
import 'package:harpy/core/misc/harpy_theme.dart';
import 'package:harpy/models/settings_model.dart';
import 'package:harpy/models/theme_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeSettingsScreen extends StatelessWidget {
  Widget _buildPreview() {
    return Container(); // todo
  }

  @override
  Widget build(BuildContext context) {
    return HarpyScaffold(
      title: "Theme",
      body: ScopedModelDescendant<SettingsModel>(
        builder: (context, _, model) {
          return ScopedModelDescendant<ThemeModel>(
            builder: (context, _, model) {
              return ThemeSelection();
            },
          );
        },
      ),
    );
  }
}

/// Builds the [ThemeCard]s for selecting a different [HarpyTheme].
class ThemeSelection extends StatelessWidget {
  final List<HarpyTheme> _harpyThemes = [
    HarpyTheme.light(),
    HarpyTheme.dark(),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.addAll(_harpyThemes.map((harpyTheme) {
      return ThemeCard(
        harpyTheme: harpyTheme,
        id: _harpyThemes.indexOf(harpyTheme),
      );
    }).toList());

    children.add(AddCustomThemeCard());

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: children,
        ),
      ),
    );
  }
}
