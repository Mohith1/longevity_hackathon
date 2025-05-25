// lib/survey_screen.dart

import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  final TextEditingController _ageController = TextEditingController();
  String? _selectedSex;
  final List<String> _selectedGoals = [];
  final TextEditingController _notesController = TextEditingController();

  // Options
  final List<String> _sexOptions = ['Male', 'Female', 'Other'];
  final List<String> _goalOptions = [
    'Joint Mobility',
    'Flexibility',
    'Strength',
    'Pain Relief',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Health Assessment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us about yourself',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),

                  // Age
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      prefixIcon: Icon(Icons.cake),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final age = int.tryParse(value ?? '');
                      if (age == null || age < 1 || age > 120) {
                        return 'Enter a valid age';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  // Sex
                  DropdownButtonFormField<String>(
                    value: _selectedSex,
                    decoration: const InputDecoration(
                      labelText: 'Sex',
                      prefixIcon: Icon(Icons.wc),
                    ),
                    items: _sexOptions
                        .map((sex) =>
                            DropdownMenuItem(value: sex, child: Text(sex)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedSex = val),
                    validator: (value) =>
                        value == null ? 'Please select your sex' : null,
                  ),

                  const SizedBox(height: 24),
                  // Joint Health Goals
                  Text(
                    'Joint Health Goals',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _goalOptions.map((goal) {
                      final isSelected = _selectedGoals.contains(goal);
                      return FilterChip(
                        label: Text(goal),
                        selected: isSelected,
                        onSelected: (sel) {
                          setState(() {
                            if (sel) {
                              _selectedGoals.add(goal);
                            } else {
                              _selectedGoals.remove(goal);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                  // Additional Notes
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Additional Health Info',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.notes),
                    ),
                    maxLines: 3,
                  ),

                  const SizedBox(height: 32),
                  // Submit Survey
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submitSurvey,
                      child: const Text('Submit', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitSurvey() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedGoals.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one goal')),
        );
        return;
      }
      // TODO: send survey data to backend or save locally
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Survey submitted successfully!')),
      );
      // Navigate onward, e.g. to dashboard
    }
  }

  @override
  void dispose() {
    _ageController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
