import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

// ─────────────────────────────────────────────
//  GlassCard
//  Frosted-glass card with configurable border
//  tint used throughout all screens.
// ─────────────────────────────────────────────

class GlassCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double radius;

  const GlassCard({
    super.key,
    required this.child,
    this.borderColor,
    this.padding,
    this.radius = AppDimens.radiusCard,
  });

  @override
  Widget build(BuildContext context) {
    final cosmic = CosmicTheme.of(context);

    return Container(
      padding: padding ?? const EdgeInsets.all(AppDimens.paddingCard),
      decoration: BoxDecoration(
        color: cosmic.glassFill,
        border: Border.all(
          color: borderColor ?? cosmic.glassBorder,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: AppShadows.card,
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────
//  CosmicDateField
//  Tappable date-input row with icon & value.
//  Used on Calculator and Compare screens.
// ─────────────────────────────────────────────

class CosmicDateField extends StatelessWidget {
  final String label;
  final String value;           // formatted date string, e.g. "15 Mar 1992"
  final Color accentColor;
  final VoidCallback onTap;

  const CosmicDateField({
    super.key,
    required this.label,
    required this.value,
    this.accentColor = AppColors.starBlue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppText.fieldLabel.copyWith(
            color: accentColor.withOpacity(0.7),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Material(
          color: Colors.transparent,
          child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.radiusField),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.06),
              border: Border.all(color: accentColor.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(AppDimens.radiusField),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_rounded,
                    size: 16, color: accentColor.withOpacity(0.7)),
                const SizedBox(width: 10),
                Text(value, style: AppText.dateValue),
                const Spacer(),
                Icon(Icons.arrow_drop_down_rounded,
                    color: AppColors.textMuted.withOpacity(0.7)),
              ],
            ),
          ),
        ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  CosmicButton — Primary gradient CTA
// ─────────────────────────────────────────────

class CosmicButton extends StatelessWidget {
  final String label;
  final String? loadingLabel;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final IconData? icon;
  final bool isLoading;

  const CosmicButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loadingLabel,
    this.gradient = AppGradients.ctaBlue,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = !isLoading && onPressed != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppDimens.radiusButton),
        child: Ink(
          height: 48,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusButton),
            boxShadow: AppShadows.glowBlue(spread: 16, opacity: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.textOnCta,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  loadingLabel ?? 'Calculating…',
                  style: AppText.ctaButton,
                ),
              ] else ...[
                if (icon != null) ...[
                  Icon(icon, size: 16, color: AppColors.textOnCta),
                  const SizedBox(width: 8),
                ],
                Text(label, style: AppText.ctaButton),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  StatChip — small stat tile (days / months / hrs)
// ─────────────────────────────────────────────

class StatChip extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final Color borderColor;

  const StatChip({
    super.key,
    required this.value,
    required this.label,
    this.valueColor = AppColors.starBlue,
    // this.borderColor = AppColors.glassBorder,
    // starBlue.withOpacity(0.15)
    this.borderColor = const  Color(0xFF4FC3F7),
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.glassBlue,
          border: Border.all(color: borderColor, width: 0.8),
          borderRadius: BorderRadius.circular(AppDimens.radiusField),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: AppText.statValue.copyWith(color: valueColor),
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            Text(label.toUpperCase(), style: AppText.statLabel),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CosmicTag — coloured pill badge (member tags)
// ─────────────────────────────────────────────

class CosmicTag extends StatelessWidget {
  final String label;
  final Color color;

  const CosmicTag({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(AppDimens.radiusTag),
      ),
      child: Text(
        label,
        style: AppText.tagText.copyWith(color: color),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CosmicOrb — glowing circular icon container
// ─────────────────────────────────────────────

class CosmicOrb extends StatelessWidget {
  final Widget child;
  final double size;
  final Gradient gradient;
  final List<BoxShadow>? shadows;

  const CosmicOrb({
    super.key,
    required this.child,
    this.size = 44,
    this.gradient = AppGradients.orb,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient,
        boxShadow: shadows ?? AppShadows.glowBlue(spread: 14, opacity: 0.45),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

// ─────────────────────────────────────────────
//  ScreenHeader — icon orb + title + subtitle
// ─────────────────────────────────────────────

class ScreenHeader extends StatelessWidget {
  final Widget orb;
  final String title;
  final String subtitle;

  const ScreenHeader({
    super.key,
    required this.orb,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        orb,
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title.toUpperCase(), style: AppText.appBarTitle),
            const SizedBox(height: 2),
            Text(subtitle.toUpperCase(), style: AppText.screenLabel),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  CosmicDivider — horizontal spacer with glow
// ─────────────────────────────────────────────

class CosmicDivider extends StatelessWidget {
  final Color color;

  const CosmicDivider({super.key, this.color = const  Color(0xFF4FC3F7)});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: color);
  }
}