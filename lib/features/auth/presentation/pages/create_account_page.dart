import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:form_validator/form_validator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/password_strength_indicator.dart';
import '../widgets/social_login_button.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _locationController = TextEditingController();
  
  bool _obscurePassword = true;
  PasswordStrength _passwordStrength = PasswordStrength.weak;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          AppStrings.createAccount,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to phone verification if phone number is provided
            if (_phoneController.text.isNotEmpty) {
              context.go('/phone-verification', extra: _phoneController.text);
            } else {
              context.go('/home');
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  // Full Name Field
                  AuthTextField(
                    controller: _fullNameController,
                    labelText: AppStrings.fullName,
                    hintText: 'Enter your full name',
                    validator: ValidationBuilder()
                        .required('Full name is required')
                        .minLength(2, 'Name must be at least 2 characters')
                        .build(),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Phone Number Field
                  AuthTextField(
                    controller: _phoneController,
                    labelText: AppStrings.phoneNumber,
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Text(
                        '+250',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    validator: ValidationBuilder()
                        .phone('Please enter a valid phone number')
                        .build(),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Email Field
                  AuthTextField(
                    controller: _emailController,
                    labelText: AppStrings.email,
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: ValidationBuilder()
                        .email('Please enter a valid email')
                        .required('Email is required')
                        .build(),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Password Field
                  AuthTextField(
                    controller: _passwordController,
                    labelText: AppStrings.password,
                    hintText: 'Enter your password',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    onChanged: (value) {
                      setState(() {}); // Trigger rebuild for password strength
                    },
                    validator: ValidationBuilder()
                        .required('Password is required')
                        .minLength(8, 'Password must be at least 8 characters')
                        .build(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Password Strength Indicator
                  if (_passwordController.text.isNotEmpty)
                    PasswordStrengthIndicator(
                      password: _passwordController.text,
                      onStrengthChanged: (strength) {
                        _passwordStrength = strength;
                      },
                    ),
                  
                  const SizedBox(height: 20),
                  
                  // Location Field
                  AuthTextField(
                    controller: _locationController,
                    labelText: AppStrings.location,
                    hintText: 'Enter your location (optional)',
                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Create Account Button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _createAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  AppStrings.createAccount,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Or sign up with
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AppColors.border)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or sign up with',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: AppColors.border)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Google Sign Up Button
                  SocialLoginButton(
                    text: AppStrings.google,
                    icon: Icons.g_mobiledata,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthGoogleSignInRequested());
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Sign In Link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: "Already have an account? "),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => context.go('/sign-in'),
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      // Check password strength
      if (_passwordStrength == PasswordStrength.weak) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please choose a stronger password'),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }

      // Format phone number
      String? phoneNumber;
      if (_phoneController.text.isNotEmpty) {
        phoneNumber = '+250${_phoneController.text}';
      }

      context.read<AuthBloc>().add(
        AuthSignUpRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _fullNameController.text.trim(),
          phoneNumber: phoneNumber,
          address: _locationController.text.trim().isEmpty 
              ? null 
              : _locationController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}