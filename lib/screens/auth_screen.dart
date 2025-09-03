import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ilibrary_app/screens/feed_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoginMode = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // دالة موحدة لعرض رسائل الخطأ للمستخدم
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  // دالة موحدة لإرسال الطلبات للسيرفر
  Future<void> _submitAuthForm() async {
    // التحقق من أن المدخلات صحيحة
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
      _isLoginMode
          ? 'https://ilibrary.site/api/auth/token'
          : 'https://ilibrary.site/api/register',
    );

    final Map<String, String> body = _isLoginMode
        ? {'email': _emailController.text, 'password': _passwordController.text}
        : {
            'displayName': _nameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          };

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && _isLoginMode) {
        final token = responseData['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print('Login successful! Token saved.');

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const FeedScreen()),
          );
        }
      } else if (response.statusCode == 201 && !_isLoginMode) {
        print('Registration successful!');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إنشاء الحساب بنجاح! يمكنك الآن تسجيل الدخول.'),
            ),
          );
          setState(() {
            _isLoginMode = true;
          });
        }
      } else {
        // في حالة فشل الطلب، اعرض رسالة الخطأ من السيرفر
        final errorMessage = responseData['message'] ?? 'حدث خطأ غير متوقع';
        _showErrorSnackBar(errorMessage);
        print('Auth failed: $errorMessage');
      }
    } catch (error) {
      _showErrorSnackBar('لا يمكن الاتصال بالسيرفر. تحقق من اتصالك بالإنترنت.');
      print('An error occurred: $error');
    }

    // التحقق من أن الويدجت لا يزال موجودًا قبل تحديث حالته
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- قسم الشعار ---
                  Icon(
                    Icons.menu_book,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _isLoginMode ? 'أهلاً بعودتك!' : 'إنشاء حساب جديد',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // --- قسم حقول الإدخال ---
                  if (!_isLoginMode)
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'الرجاء إدخال اسمك.';
                        }
                        return null;
                      },
                    ),
                  if (!_isLoginMode) const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'الرجاء إدخال بريد إلكتروني صالح.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'كلمة المرور',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- قسم الأزرار ---
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ElevatedButton(
                      onPressed: _submitAuthForm,
                      child: Text(_isLoginMode ? 'تسجيل الدخول' : 'إنشاء حساب'),
                    ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLoginMode = !_isLoginMode;
                      });
                    },
                    child: Text(
                      _isLoginMode
                          ? 'ليس لديك حساب؟ إنشاء حساب جديد'
                          : 'لديك حساب بالفعل؟ تسجيل الدخول',
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
}
