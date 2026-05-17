import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/common/cosmic_background.dart';
import '../widgets/common/cosmic_widgets.dart';
import '../widgets/compare/date_timeline_widget.dart';

// ─────────────────────────────────────────────
//  CompareView
//  Two date pickers + difference result panel.
//  Accent: teal (#26C6DA) for From, lavender for To.
// ─────────────────────────────────────────────

class CompareView extends StatefulWidget {
  const CompareView({super.key});

  @override
  State<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends State<CompareView> {
  String _fromDate = '01 Jan 1992';
  String _toDate = '30 Apr 2026';
  bool _hasResult = true;

  void _pickFrom() => setState(() {}); // Phase 2: date picker
  void _pickTo()   => setState(() {}); // Phase 2: date picker

  @override
  Widget build(BuildContext context) {
    return CosmicBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.paddingPage,
            AppDimens.paddingPage,
            AppDimens.paddingPage,
            AppDimens.paddingPage + AppDimens.navBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────
              ScreenHeader(
                orb: CosmicOrb(
                  size: 44,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF26C6DA), Color(0xFF4FC3F7)],
                  ),
                  shadows: [
                    BoxShadow(
                      color: AppColors.tealAccent.withOpacity(0.45),
                      blurRadius: 14,
                    ),
                  ],
                  child: const Icon(
                    Icons.compare_arrows_rounded,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                title: 'Date Compare',
                subtitle: 'Measure time between dates',
              ),
              const SizedBox(height: AppDimens.gapXl),

              // ── Input card ───────────────────────────────
              GlassCard(
                borderColor: AppColors.tealAccent.withOpacity(0.2),
                child: Column(
                  children: [
                    // From
                    CosmicDateField(
                      label: 'From Date',
                      value: _fromDate,
                      accentColor: AppColors.tealAccent,
                      onTap: _pickFrom,
                    ),
                    const SizedBox(height: AppDimens.gapMd),

                    // Swap divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.glassBorderWeak,
                            thickness: 0.8,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppColors.starBlue.withOpacity(0.07),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.glassBorder),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.swap_vert_rounded,
                            size: 18,
                            color: AppColors.starBlue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Divider(
                            color: AppColors.glassBorderWeak,
                            thickness: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.gapMd),

                    // To
                    CosmicDateField(
                      label: 'To Date',
                      value: _toDate,
                      accentColor: AppColors.lavender,
                      onTap: _pickTo,
                    ),
                    const SizedBox(height: AppDimens.gapMd),

                    CosmicButton(
                      label: '⇄  CALCULATE DIFFERENCE',
                      onPressed: () => setState(() => _hasResult = true),
                      gradient: AppGradients.ctaTeal,
                    ),
                  ],
                ),
              ),

              // ── Result card ──────────────────────────────
              if (_hasResult) ...[
                const SizedBox(height: AppDimens.gapMd),
                GlassCard(
                  borderColor: AppColors.tealAccent.withOpacity(0.2),
                  child: Column(
                    children: [
                      const DateTimeline(
                        fromDay: '1',
                        fromMonthYear: 'Jan 1992',
                        toDay: '30',
                        toMonthYear: 'Apr 2026',
                      ),
                      const SizedBox(height: AppDimens.gapLg),
                      const DiffDisplay(years: 34, months: 3, days: 29),
                      const SizedBox(height: AppDimens.gapLg),

                      // Extra stats row
                      Row(
                        children: const [
                          StatChip(
                            value: '12,512',
                            label: 'Total Days',
                            valueColor: AppColors.tealAccent,
                            borderColor:
                                Color(0x3026C6DA), // teal 18%
                          ),
                          SizedBox(width: 8),
                          StatChip(
                            value: '411',
                            label: 'Months',
                            valueColor: AppColors.lavender,
                            borderColor:
                                Color(0x30CE93D8),
                          ),
                          SizedBox(width: 8),
                          StatChip(
                            value: '1791',
                            label: 'Weeks',
                            valueColor: AppColors.starBlue,
                            borderColor: Color(0x304FC3F7),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}