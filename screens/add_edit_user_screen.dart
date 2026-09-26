import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../utils/validation.dart';
import '../widgets/custom_text_field.dart';

class AddEditUserScreen extends StatefulWidget {
  final User? user;
  const AddEditUserScreen({super.key, this.user});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dobController = TextEditingController();
  final _cityController = TextEditingController();

  String _gender = '';
  List<String> _hobbies = [];

  final ApiService api = ApiService();

  final List<String> hobbyOptions = ["Reading", "Traveling", "Gaming", "Cooking"];

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _isEditing = true;
      final user = widget.user!;
      _fullNameController.text = user.fullName;
      _emailController.text = user.email;
      _mobileController.text = user.mobile;
      _dobController.text = user.dob;
      _cityController.text = user.city;
      _gender = user.gender;
      _hobbies = user.hobbies.split(','); // Assuming CSV storage
    }
  }

  void saveUser() async {
    if (_formKey.currentState!.validate() &&
        Validation.validateGender(_gender) == null &&
        _hobbies.isNotEmpty) {
      final user = User(
        id: widget.user?.id,
        fullName: _fullNameController.text,
        email: _emailController.text,
        mobile: _mobileController.text,
        dob: _dobController.text,
        city: _cityController.text,
        gender: _gender,
        hobbies: _hobbies.join(','), // Save as CSV
      );

      try {
        if (_isEditing) {
          await api.updateUser(user.id!, user);
        } else {
          await api.addUser(user);
        }
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete the form")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? "Edit User" : "Add User")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Full Name
              CustomTextField(
                label: "Full Name",
                controller: _fullNameController,
                validator: (value) =>
                    Validation.validateFullName(value ?? ''),
              ),
              const SizedBox(height: 10),

              // Email
              CustomTextField(
                label: "Email",
                controller: _emailController,
                validator: (value) => Validation.validateEmail(value ?? ''),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),

              // Mobile
              CustomTextField(
                label: "Mobile",
                controller: _mobileController,
                validator: (value) => Validation.validateMobile(value ?? ''),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),

              // DOB with DatePicker
              CustomTextField(
                label: "Date of Birth",
                controller: _dobController,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dobController.text =
                    "${picked.day.toString().padLeft(2, '0')}/"
                        "${picked.month.toString().padLeft(2, '0')}/"
                        "${picked.year}";
                  }
                },
                validator: (value) => Validation.validateDOB(value ?? ''),
              ),
              const SizedBox(height: 10),

              // City
              CustomTextField(
                label: "City",
                controller: _cityController,
                validator: (value) =>
                (value == null || value.isEmpty) ? "Enter city" : null,
              ),
              const SizedBox(height: 10),

              // Gender Radio Buttons
              Text("Gender", style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: ["Male", "Female", "Other"].map((gender) {
                  return Expanded(
                    child: RadioListTile(
                      title: Text(gender),
                      value: gender,
                      groupValue: _gender,
                      onChanged: (String? value) {
                        setState(() {
                          _gender = value ?? '';
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              if (Validation.validateGender(_gender) != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    Validation.validateGender(_gender)!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 10),

              // Hobbies Checkboxes
              Text("Hobbies", style: const TextStyle(fontWeight: FontWeight.bold)),
              ...hobbyOptions.map((hobby) {
                return CheckboxListTile(
                  title: Text(hobby),
                  value: _hobbies.contains(hobby),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _hobbies.add(hobby);
                      } else {
                        _hobbies.remove(hobby);
                      }
                    });
                  },
                );
              }).toList(),
              if (_hobbies.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Please select at least one hobby",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveUser,
                child: Text(_isEditing ? "Update User" : "Add User"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
