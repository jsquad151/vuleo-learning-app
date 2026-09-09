import 'package:flutter/material.dart';

import '../../models/child_profile.dart';
import '../../theme/app_theme.dart';

class ChildSettingsView extends StatefulWidget {
  const ChildSettingsView({super.key, required this.child});

  final ChildProfile child;

  @override
  State<ChildSettingsView> createState() => _ChildSettingsViewState();
}

class _ChildSettingsViewState extends State<ChildSettingsView> {
  double _dailyLimitMinutes = 60;
  bool _soundEffects = true;
  bool _weeklyEmail = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            "${widget.child.name}'s settings",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        _SettingsCard(
          title: 'Daily time limit',
          subtitle: '${_dailyLimitMinutes.round()} minutes a day',
          child: Slider(
            value: _dailyLimitMinutes,
            min: 15,
            max: 120,
            divisions: 7,
            activeColor: AppTheme.parentColor,
            label: '${_dailyLimitMinutes.round()} min',
            onChanged: (value) => setState(() => _dailyLimitMinutes = value),
          ),
        ),
        _SettingsCard(
          title: 'Sound effects',
          trailing: Switch(
            value: _soundEffects,
            activeThumbColor: AppTheme.parentColor,
            onChanged: (value) => setState(() => _soundEffects = value),
          ),
        ),
        _SettingsCard(
          title: 'Weekly progress email',
          trailing: Switch(
            value: _weeklyEmail,
            activeThumbColor: AppTheme.parentColor,
            onChanged: (value) => setState(() => _weeklyEmail = value),
          ),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.title,
    this.subtitle,
    this.trailing,
    this.child,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    ?subtitle == null
                        ? null
                        : Text(
                            subtitle!,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
          ?child,
        ],
      ),
    );
  }
}
