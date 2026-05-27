import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:age_calculator/l10n/app_localizations.dart';
import 'package:age_calculator/core/theme/app_theme.dart';
import 'package:age_calculator/core/theme/theme_provider.dart';
import 'package:age_calculator/core/utils/locale_provider.dart';
import 'widgets/common/cosmic_background.dart';
import 'widgets/common/cosmic_widgets.dart';

// ─────────────────────────────────────────────
//  SettingsView
//  App preferences: language and theme.
// ─────────────────────────────────────────────

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cosmic = CosmicTheme.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final themeProvider = context.watch<AppThemeProvider>();

    return CosmicBackground(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDimens.paddingPage,
                  AppDimens.paddingPage,
                  AppDimens.paddingPage,
                  AppDimens.gapXl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenHeader(
                      orb: CosmicOrb(
                        size: 44,
                        gradient: AppGradients.ctaLavender,
                        shadows: AppShadows.glowLavender(spread: 14),
                        child: const Icon(
                          Icons.settings_rounded,
                          size: 22,
                          color: Colors.white,
                        ),
                      ),
                      title: l10n.settings,
                      subtitle: l10n.settingsSubtitle,
                    ),
                    const SizedBox(height: AppDimens.gapXl),

                    // ── Language section ─────────────────────
                    Text(
                      l10n.language,
                      style: AppText.sectionTitle.copyWith(
                        color: cosmic.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapSm),
                    _LanguageSelector(
                      current: localeProvider.locale,
                      onSelected: localeProvider.setLocale,
                    ),
                    const SizedBox(height: AppDimens.gapXl),

                    // ── Theme section ────────────────────────
                    Text(
                      l10n.theme,
                      style: AppText.sectionTitle.copyWith(
                        color: cosmic.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimens.gapSm),
                    _ThemeTile(
                      label: l10n.darkMode,
                      value: themeProvider.isDarkMode,
                      onChanged: themeProvider.setDarkMode,
                    ),
                  ],
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(
                bottom: AppDimens.navBarHeight + AppDimens.paddingPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final Locale current;
  final ValueChanged<Locale> onSelected;

  const _LanguageSelector({
    required this.current,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cosmic = CosmicTheme.of(context);

    return GlassCard(
      child: Column(
        children: LocaleProvider.supportedLocales.map((locale) {
          final code = locale.languageCode;
          final selected = current.languageCode == code;
          final name = LocaleProvider.localeNames[code] ?? code;

          return ListTile(
            dense: true,
            title: Text(
              name,
              style: TextStyle(
                color: selected ? AppColors.starBlue : cosmic.textPrimary,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            trailing: selected
                ? const Icon(Icons.check_rounded, color: AppColors.starBlue)
                : null,
            onTap: () => onSelected(locale),
          );
        }).toList(),
      ),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ThemeTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cosmic = CosmicTheme.of(context);

    return GlassCard(
      child: SwitchListTile(
        title: Text(
          label,
          style: TextStyle(color: cosmic.textPrimary),
        ),
        value: value,
        activeTrackColor: AppColors.starBlue.withValues(alpha: 0.4),
        activeThumbColor: AppColors.starBlue,
        onChanged: onChanged,
      ),
    );
  }
}
