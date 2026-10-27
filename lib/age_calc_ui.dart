import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime date(DateTime d) => DateTime.utc(d.year, d.month, d.day);
DateTime get now => date(DateTime.now());
int diff(DateTime a, DateTime b) => date(b).difference(date(a)).inDays;
int monthEnd(int y, int m) => DateTime.utc(y, m + 1, 0).day;
DateTime shifted(DateTime d, int n) {
  final x = d.month - 1 + n, y = d.year + x ~/ 12, m = x % 12 + 1;
  return DateTime.utc(y, m, d.day.clamp(1, monthEnd(y, m)));
}

List<int> age(DateTime b, DateTime t) {
  var m = (t.year - b.year) * 12 + t.month - b.month;
  if (shifted(b, m).isAfter(t)) m--;
  return [m ~/ 12, m % 12, diff(shifted(b, m), t)];
}

DateTime birthday(DateTime b, int y) =>
    DateTime.utc(y, b.month, b.day.clamp(1, monthEnd(y, b.month)));
DateTime next(DateTime b) {
  var d = birthday(b, now.year);
  return d.isBefore(now) ? birthday(b, now.year + 1) : d;
}

String iso(DateTime d) =>
    d.year.toString().padLeft(4, '0') +
    '-' +
    d.month.toString().padLeft(2, '0') +
    '-' +
    d.day.toString().padLeft(2, '0');
DateTime? parse(String? s) => s == null ? null : DateTime.tryParse(s)?.toUtc();
String? invalid(DateTime? d) {
  if (d == null) return 'Date of birth is required';
  if (d.year < 1900) return 'Minimum year is 1900';
  if (d.isAfter(now)) return 'Future birth dates are not allowed';
  return null;
}

const groups = ['Family', 'Friend', 'Work', 'Other'];
const planets = [
  ('Mercury', .2408467),
  ('Venus', .61519726),
  ('Earth', 1.0),
  ('Mars', 1.8808158),
  ('Jupiter', 11.862615),
  ('Saturn', 29.447498),
  ('Uranus', 84.016846),
  ('Neptune', 164.79132)
];

class AgeCalcApp extends StatefulWidget {
  const AgeCalcApp({super.key});
  @override
  State<AgeCalcApp> createState() => _AgeCalcState();
}

class _AgeCalcState extends State<AgeCalcApp> {
  DateTime? dob, asOf;
  List<Map<String, String>> people = [];
  String theme = 'system', format = 'dmy', search = '';
  int tab = 0;
  bool showResult = false;
  String? error;
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      dob = parse(p.getString('dob'));
      if (invalid(dob) != null) dob = null;
      showResult = dob != null;
      theme = p.getString('theme') ?? 'system';
      format = p.getString('format') ?? 'dmy';
      try {
        people = (jsonDecode(p.getString('people') ?? '[]') as List)
            .map((x) => Map<String, String>.from(x as Map))
            .toList();
      } catch (_) {
        people = [];
      }
    });
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    if (dob == null) {
      await p.remove('dob');
    } else {
      await p.setString('dob', iso(dob!));
    }
    await p.setString('people', jsonEncode(people));
    await p.setString('theme', theme);
    await p.setString('format', format);
  }

  String formatted(DateTime d) {
    final a = d.day.toString().padLeft(2, '0'),
        b = d.month.toString().padLeft(2, '0');
    if (format == 'iso') return iso(d);
    if (format == 'mdy') return b + '/' + a + '/' + d.year.toString();
    if (format == 'long')
      return d.day.toString() +
          ' ' +
          [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec'
          ][d.month - 1] +
          ' ' +
          d.year.toString();
    return a + '/' + b + '/' + d.year.toString();
  }

  Future<DateTime?> choose(DateTime? d) => showDatePicker(
      context: context,
      initialDate: d ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  Widget card(Widget child) => Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(padding: const EdgeInsets.all(18), child: child));
  Widget picker(String label, DateTime? d, void Function(DateTime) set) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(label),
        OutlinedButton.icon(
            onPressed: () async {
              final x = await choose(d);
              if (x != null) set(date(x));
            },
            icon: const Icon(Icons.calendar_month),
            label: Text(d == null ? 'Select date' : formatted(d))),
        const SizedBox(height: 14)
      ]);
  void calculate() {
    setState(() {
      error = invalid(dob);
      if (error == null && asOf != null && !asOf!.isAfter(dob!))
        error = 'Age on must be after date of birth';
      showResult = error == null;
    });
    if (showResult) save();
  }

  Future<void> edit([int? index, DateTime? preset]) async {
    final old = index == null ? null : people[index];
    final controller = TextEditingController(text: old?['name'] ?? '');
    DateTime? d = parse(old?['date']) ?? preset;
    String group = old?['group'] ?? 'Family', err = '';
    final result = await showDialog<Map<String, String>>(
        context: context,
        builder: (c) => StatefulBuilder(
            builder: (c, refresh) => AlertDialog(
                    title:
                        Text(index == null ? 'Add birthday' : 'Edit birthday'),
                    content: SingleChildScrollView(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      TextField(
                          controller: controller,
                          maxLength: 40,
                          decoration: const InputDecoration(labelText: 'Name')),
                      OutlinedButton.icon(
                          onPressed: () async {
                            final x = await choose(d);
                            if (x != null) refresh(() => d = date(x));
                          },
                          icon: const Icon(Icons.calendar_month),
                          label: Text(
                              d == null ? 'Date of birth' : formatted(d!))),
                      DropdownButtonFormField<String>(
                          value: group,
                          items: groups
                              .map((g) =>
                                  DropdownMenuItem(value: g, child: Text(g)))
                              .toList(),
                          onChanged: (v) => refresh(() => group = v ?? group),
                          decoration:
                              const InputDecoration(labelText: 'Group')),
                      if (err.isNotEmpty)
                        Text(err,
                            style: const TextStyle(color: Colors.redAccent))
                    ])),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(c),
                          child: const Text('Cancel')),
                      FilledButton(
                          onPressed: () {
                            final e = invalid(d);
                            if (controller.text.trim().isEmpty || e != null) {
                              refresh(() => err = controller.text.trim().isEmpty
                                  ? 'Name is required'
                                  : e!);
                              return;
                            }
                            Navigator.pop(c, {
                              'id': old?['id'] ??
                                  DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                              'name': controller.text.trim(),
                              'date': iso(d!),
                              'group': group
                            });
                          },
                          child: const Text('Save'))
                    ])));
    controller.dispose();
    if (result != null && mounted) {
      setState(() {
        if (index == null) {
          people.add(result);
        } else {
          people[index] = result;
        }
      });
      save();
    }
  }

  Future<void> delete(int index) async {
    final ok = await showDialog<bool>(
        context: context,
        builder: (c) =>
            AlertDialog(title: const Text('Delete birthday?'), actions: [
              TextButton(
                  onPressed: () => Navigator.pop(c, false),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(c, true),
                  child: const Text('Delete'))
            ]));
    if (ok == true) {
      setState(() => people.removeAt(index));
      save();
    }
  }

  Future<void> reset() async {
    final ok = await showDialog<bool>(
        context: context,
        builder: (c) =>
            AlertDialog(title: const Text('Delete all saved data?'), actions: [
              TextButton(
                  onPressed: () => Navigator.pop(c, false),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(c, true),
                  child: const Text('Delete all'))
            ]));
    if (ok == true) {
      final p = await SharedPreferences.getInstance();
      for (final k in ['dob', 'people', 'theme', 'format']) {
        await p.remove(k);
      }
      setState(() {
        dob = null;
        asOf = null;
        people = [];
        theme = 'system';
        format = 'dmy';
        showResult = false;
      });
    }
  }

  Widget agePage() => Column(children: [
        card(Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          picker(
              'Date of birth',
              dob,
              (d) => setState(() {
                    dob = d;
                    showResult = false;
                  })),
          picker(
              'Age on (optional)',
              asOf,
              (d) => setState(() {
                    asOf = d;
                    showResult = false;
                  })),
          if (asOf != null)
            TextButton(
                onPressed: () => setState(() => asOf = null),
                child: const Text('Clear Age on')),
          if (error != null)
            Text(error!, style: const TextStyle(color: Colors.redAccent)),
          FilledButton(onPressed: calculate, child: const Text('Calculate age'))
        ])),
        if (showResult && dob != null) ...[
          card(Column(children: [
            Row(children: [
              for (final i in [0, 1, 2])
                Expanded(
                    child: Column(children: [
                  Text(age(dob!, asOf ?? now)[i].toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color(0xFF5CE1E6),
                          fontWeight: FontWeight.bold)),
                  Text(['years', 'months', 'days'][i])
                ]))
            ]),
            const SizedBox(height: 12),
            Text(diff(dob!, asOf ?? now).toString() +
                ' days · ' +
                (diff(dob!, asOf ?? now) ~/ 7).toString() +
                ' weeks · ' +
                (diff(dob!, asOf ?? now) * 24).toString() +
                ' hours lived')
          ])),
          card(Text(diff(now, next(dob!)).toString() +
              ' days to next birthday · Turning ' +
              (next(dob!).year - dob!.year).toString() +
              ' on ' +
              formatted(next(dob!)))),
          OutlinedButton(
              onPressed: () => edit(null, dob),
              child: const Text('Save to birthdays'))
        ]
      ]);
  Widget birthdaysPage() {
    final entries = people
        .asMap()
        .entries
        .where((e) => ((e.value['name'] ?? '') + ' ' + (e.value['group'] ?? ''))
            .toLowerCase()
            .contains(search.toLowerCase()))
        .toList()
      ..sort((a, b) => diff(now, next(parse(a.value['date']) ?? now))
          .compareTo(diff(now, next(parse(b.value['date']) ?? now))));
    return Column(children: [
      TextField(
          onChanged: (s) => setState(() => search = s),
          decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder())),
      const SizedBox(height: 12),
      FilledButton.icon(
          onPressed: () => edit(),
          icon: const Icon(Icons.add),
          label: const Text('Add birthday')),
      const SizedBox(height: 12),
      if (entries.isEmpty) card(const Text('No birthdays found.')),
      for (final e in entries)
        card(Row(children: [
          CircleAvatar(
              child:
                  Text((e.value['name'] ?? '?').substring(0, 1).toUpperCase())),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(e.value['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text((e.value['group'] ?? '') +
                    ' · ' +
                    formatted(parse(e.value['date']) ?? now)),
                Text(diff(now, next(parse(e.value['date']) ?? now)).toString() +
                    ' days remaining')
              ])),
          IconButton(
              tooltip: 'Edit birthday',
              onPressed: () => edit(e.key),
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              tooltip: 'Delete birthday',
              onPressed: () => delete(e.key),
              icon: const Icon(Icons.delete_outline))
        ]))
    ]);
  }

  Widget planetsPage() {
    if (dob == null) return card(const Text('Calculate your age first.'));
    final years = diff(dob!, now) / 365.25;
    return Column(children: [
      for (final p in planets)
        card(Row(children: [
          const Icon(Icons.public, color: Color(0xFF5CE1E6)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(p.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Year = ' + p.$2.toString() + ' Earth years'),
                LinearProgressIndicator(
                    value: years == 0
                        ? 0
                        : p.$2 == planets.first.$2
                            ? 1
                            : (planets.first.$2 / p.$2).clamp(0.0, 1.0))
              ])),
          Text((years / p.$2).toStringAsFixed(2))
        ]))
    ]);
  }

  Widget settingsPage() => Column(children: [
        card(Column(children: [
          DropdownButtonFormField<String>(
              value: theme,
              decoration: const InputDecoration(labelText: 'Theme'),
              items: const [
                DropdownMenuItem(value: 'system', child: Text('Match device')),
                DropdownMenuItem(value: 'dark', child: Text('Dark')),
                DropdownMenuItem(value: 'light', child: Text('Light'))
              ],
              onChanged: (v) {
                setState(() => theme = v ?? 'system');
                save();
              }),
          DropdownButtonFormField<String>(
              value: format,
              decoration: const InputDecoration(labelText: 'Date format'),
              items: const [
                DropdownMenuItem(value: 'dmy', child: Text('31/12/2000')),
                DropdownMenuItem(value: 'mdy', child: Text('12/31/2000')),
                DropdownMenuItem(value: 'iso', child: Text('2000-12-31')),
                DropdownMenuItem(value: 'long', child: Text('31 Dec 2000'))
              ],
              onChanged: (v) {
                setState(() => format = v ?? 'dmy');
                save();
              }),
          const SizedBox(height: 14),
          OutlinedButton.icon(
              onPressed: reset,
              icon: const Icon(Icons.delete_forever),
              label: const Text('Delete all saved data'))
        ])),
        const Text(
            'Everything stays on this device. Planet ages are approximate.')
      ]);
  @override
  Widget build(BuildContext context) {
    final light = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7C5CFF)),
        scaffoldBackgroundColor: const Color(0xFFF4F6FF));
    final dark = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF7C5CFF),
            brightness: Brightness.dark,
            surface: const Color(0xFF17205A)),
        scaffoldBackgroundColor: const Color(0xFF0A1030));
    return MaterialApp(
        title: 'Age Calc',
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        themeMode: theme == 'light'
            ? ThemeMode.light
            : theme == 'dark'
                ? ThemeMode.dark
                : ThemeMode.system,
        home: Scaffold(
            appBar: AppBar(title: const Text('◷  Age Calc')),
            body: SafeArea(
                child: ListView(
                    key: ValueKey(tab),
                    padding: const EdgeInsets.all(20),
                    children: [
                  Text(
                      [
                        'Your age',
                        'Birthdays',
                        'Age on other planets',
                        'Settings'
                      ][tab],
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  [agePage, birthdaysPage, planetsPage, settingsPage][tab]()
                ])),
            bottomNavigationBar: NavigationBar(
                selectedIndex: tab,
                onDestinationSelected: (i) => setState(() => tab = i),
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.access_time), label: 'Age'),
                  NavigationDestination(
                      icon: Icon(Icons.cake_outlined), label: 'Birthdays'),
                  NavigationDestination(
                      icon: Icon(Icons.public), label: 'Planets'),
                  NavigationDestination(
                      icon: Icon(Icons.settings_outlined), label: 'Settings')
                ])));
  }
}
