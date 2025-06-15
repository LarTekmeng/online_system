import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_doc_savimex/feature/repositories/auth_repo.dart';
import 'package:online_doc_savimex/feature/repositories/department_repo.dart';
import 'package:online_doc_savimex/feature/screen/Login/login_screen.dart';
import '../../Model/department.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _employeeIdCtrl = TextEditingController();
  final _nameCtrl       = TextEditingController();
  final _emailCtrl      = TextEditingController();
  final _passCtrl       = TextEditingController();

  bool _loadingSubmit = false;
  bool _loadingDeps   = true;
  String _error       = '';

  List<Department> _departments = [];
  Department? _selectedDept;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  Future<void> _loadDepartments() async {
    setState(() { _loadingDeps = true; });
    try {
      final repo = context.read<DepartmentRepository>();
      final depts = await repo.fetchDepartments();
      setState(() {
        _departments      = depts;
        _selectedDept     = depts.isNotEmpty ? depts.first : null;
      });
    } catch (e) {
      debugPrint('Failed to load departments: $e');
      setState(() { _error = 'Unable to load departments'; });
    } finally {
      setState(() { _loadingDeps = false; });
    }
  }

  String? _validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Enter email';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(v) ? null : 'Invalid email';
  }

  String? _validatePass(String? v) {
    if (v == null || v.length < 6) return 'Min 6 chars';
    return null;
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDept == null) {
      setState(() => _error = 'Please select a department');
      return;
    }

    setState(() { _loadingSubmit = true; _error = ''; });
    try {
      final authRepo = context.read<AuthRepository>();
      await authRepo.registerUser(
        _nameCtrl.text.trim(),
        _emailCtrl.text.trim(),
        _passCtrl.text,
        _selectedDept!.id,
        _employeeIdCtrl.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() { _loadingSubmit = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_loadingDeps)
                const Center(child: CircularProgressIndicator())
              else if (_departments.isEmpty)
                const Center(child: Text('No departments available'))
              else
                DropdownButtonFormField<Department>(
                  value: _selectedDept,
                  decoration: const InputDecoration(labelText: 'Department'),
                  items: _departments
                      .map((d) => DropdownMenuItem(
                    value: d,
                    child: Text(d.name),
                  ))
                      .toList(),
                  onChanged: (d) => setState(() => _selectedDept = d),
                  validator: (_) => _selectedDept == null
                      ? 'Please select one'
                      : null,
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _employeeIdCtrl,
                decoration:
                const InputDecoration(labelText: 'Employee ID'),
                validator: (v) => v == null || v.isEmpty
                    ? 'Enter employee ID'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty
                    ? 'Enter name'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passCtrl,
                decoration:
                const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePass,
              ),
              const SizedBox(height: 24),
              _loadingSubmit
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Register'),
              ),
              if (_error.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(_error,
                    style:
                    const TextStyle(color: Colors.red)),
              ],
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LoginScreen()),
                ),
                child: const Text('Have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
