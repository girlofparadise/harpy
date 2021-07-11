import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harpy/components/components.dart';
import 'package:harpy/core/core.dart';
import 'package:harpy/harpy.dart';
import 'package:harpy/harpy_widgets/harpy_widgets.dart';
import 'package:harpy/misc/misc.dart';
import 'package:provider/provider.dart';

/// A card used to add a custom theme for the [ThemeSelectionScreen].
class AddCustomThemeCard extends StatelessWidget {
  const AddCustomThemeCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.watch<ThemeBloc>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: kDefaultBorderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          shape: kDefaultShapeBorder,
          leading: const Icon(CupertinoIcons.add),
          title: const Text('add custom theme'),
          trailing: Harpy.isFree ? const FlareIcon.shiningStar(size: 28) : null,
          onTap: () => _pushCustomTheme(
            context,
            bloc: bloc,
          ),
        ),
      ),
    );
  }
}

Future<void> _pushCustomTheme(
  BuildContext context, {
  required ThemeBloc bloc,
}) async {
  final systemBrightness = MediaQuery.platformBrightnessOf(context);

  // use the currently selected theme as a starting point for the custom theme
  final themeData = (systemBrightness == Brightness.light
          ? bloc.state.lightThemeData
          : bloc.state.darkThemeData)
      .copyWith(name: 'new theme');

  // use the next available custom theme id
  final themeId = bloc.state.customThemesData.length + 10;

  app<HarpyNavigator>().pushCustomTheme(
    themeData: themeData,
    themeId: themeId,
  );
}
