import 'package:flutter/material.dart';
import 'package:gym_app/auth/auth.dart';
import 'package:gym_app/second%20try/pages/homePage.dart';
import 'package:gym_app/widgets/error_handler.dart';
import 'package:provider/provider.dart';

class ToggleLoginCard extends StatefulWidget {
  const ToggleLoginCard({super.key});

  @override
  State<ToggleLoginCard> createState() => _ToggleLoginCardState();
}

class _ToggleLoginCardState extends State<ToggleLoginCard>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLogin = true;
  bool _isloading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 15.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _toggleMode(bool isLogin) async {
    if (_isLogin == isLogin) return;

    // Animate out
    await _animationController.reverse();

    setState(() {
      _isLogin = isLogin;
      _emailController.clear();
      _passwordController.clear();
    });

    // Animate in
    await _animationController.forward();
  }

  void _submit() async {
    // Validate inputs first
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      AuthErrorHandler.showAuthError(context, "Please fill in fields");
      return;
    }

    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      AuthErrorHandler.showAuthError(context, "use valid email address");
      return;
    }

    if (_passwordController.text.length < 6) {
      AuthErrorHandler.showAuthError(
        context,
        "Password must be at least 6 characters",
      );
      return;
    }

    try {
      setState(() {
        _isloading = true;
      });

      final auth = Provider.of<AuthBase>(context, listen: false);

      if (_isLogin) {
        // LOGIN
        await auth.signInWithEmailAndPassword(
          email,
          _passwordController.text.toString(),
        );

        // Clear controllers BEFORE navigation
        _emailController.clear();
        _passwordController.clear();

        // Navigate immediately without showing message on this page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePageNew()),
          (route) => false,
        );

        // The success message should be shown on HomePageNew if needed
      } else {
        // SIGN UP
        await auth.createUserWithEmailAndPassword(
          _emailController.text,
          _passwordController.text.toString(),
        );

        // For signup, you might want to stay on the same page
        // Or navigate to a profile setup page

        // Clear controllers
        _emailController.clear();
        _passwordController.clear();

        // Show success message (widget is still mounted for signup)
        if (mounted) {
          AuthErrorHandler.showSuccess(context, "Account Created Successfully");

          // Optionally toggle to login mode after successful signup
          _toggleMode(true);
        }
      }
    } catch (e) {
      // Only show error if widget is still mounted
      if (mounted) {
        String errorMessage = "An unexpected error occurred";

        AuthErrorHandler.showAuthError(context, errorMessage);
      }
    } finally {
      // Only update loading state if widget is still mounted
      if (mounted) {
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(opacity: _fadeAnimation.value, child: child),
        );
      },
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.05,
              ), // Fixed: withOpacity instead of withValues
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Toggle between Login/Signup
            _buildToggleSection(),
            const SizedBox(height: 24),

            // Animated Content
            _buildAnimatedContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _toggleMode(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isLogin ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isLogin
                      ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(
                              0.2,
                            ), // Fixed: withOpacity
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _isLogin ? Colors.white : Colors.grey[700],
                    fontWeight: _isLogin ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => _toggleMode(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isLogin ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: !_isLogin
                      ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(
                              .2,
                            ), // Fixed: withOpacity
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !_isLogin ? Colors.white : Colors.grey[700],
                    fontWeight: !_isLogin ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title with animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            key: ValueKey('title_$_isLogin'),
            _isLogin ? 'Welcome Back' : 'Create Account',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            key: ValueKey('subtitle_$_isLogin'),
            _isLogin
                ? 'Sign in to continue your fitness journey'
                : 'Join our fitness community today',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),

        // Email Field
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Password Field
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock_outlined, size: 20),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                key: ValueKey('eye_$_obscurePassword'),
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Action Button
        ElevatedButton(
          onPressed: _isloading ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    key: ValueKey('button_$_isLogin'),
                    _isLogin ? 'Login' : 'Create Account',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
