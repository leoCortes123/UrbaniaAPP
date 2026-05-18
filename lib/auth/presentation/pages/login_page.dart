import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:urbania/core/theme/app_colors.dart';
import 'package:urbania/core/theme/app_typography.dart';
import 'package:urbania/core/theme/app_spacing.dart';
import 'package:urbania/core/theme/app_shapes.dart';
import 'package:urbania/core/errors/failure.dart';
import 'package:urbania/auth/presentation/providers/auth_controller.dart';
import 'package:urbania/auth/presentation/states/auth_state.dart';
import 'package:urbania/shared/widgets/app_button.dart';
import 'package:urbania/shared/widgets/app_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _emailError = _emailController.text.isEmpty ? 'Ingresa tu email' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Ingresa tu contraseña' : null;
    });

    if (_emailError != null || _passwordError != null) return;

    ref.read(authControllerProvider.notifier).login(
          _emailController.text,
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AsyncValue<AuthState>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (failure, _) {
          if (failure is Failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
      );
    });

    final isLoading = authState is AsyncLoading;

    return Scaffold(
      body: Stack(
        children: [
          // Background decorative blobs
          _buildBackground(),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  // Logo and title
                  _buildHeader(),
                  const SizedBox(height: AppSpacing.xxl),
                  // Form
                  _buildForm(isLoading),
                  const SizedBox(height: AppSpacing.lg),
                  // Forgot password
                  Center(
                    child: TextButton(
                      onPressed: () => context.push('/forgot-password'),
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: AppTypography.labelMD
                            .copyWith(color: AppColors.primaryContainer),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  // Divider
                  _buildDivider(),
                  const SizedBox(height: AppSpacing.lg),
                  // Social buttons
                  _buildSocialButtons(),
                  const SizedBox(height: AppSpacing.lg),
                  // Register link
                  _buildRegisterLink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.04),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withOpacity(0.04),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppShapes.lg),
          ),
          child: const Icon(
            Icons.home_rounded,
            size: 48,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Urbania',
          style: AppTypography.headlineXL.copyWith(
            color: AppColors.primaryContainer,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Gestión residencial inteligente',
          style:
              AppTypography.bodyMD.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildForm(bool isLoading) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerMargin),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppShapes.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Iniciar Sesión',
            style: AppTypography.titleMD,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: 'Correo electrónico',
            hint: 'tu@correo.com',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            errorText: _emailError,
            onChanged: (_) => setState(() => _emailError = null),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Contraseña',
            hint: '••••••••',
            obscureText: _obscurePassword,
            controller: _passwordController,
            errorText: _passwordError,
            onChanged: (_) => setState(() => _passwordError = null),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            text: isLoading ? '' : 'Ingresar',
            onPressed: isLoading ? null : _handleLogin,
            isLoading: isLoading,
            variant: AppButtonVariant.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.outlineVariant)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'o continuar con',
            style:
                AppTypography.labelMD.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.outlineVariant)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            icon: Icons.g_mobiledata,
            label: 'Google',
            onPressed: () {},
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SocialButton(
            icon: Icons.facebook,
            label: 'Facebook',
            onPressed: () {},
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SocialButton(
            icon: Icons.apple,
            label: 'Apple',
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta? ',
          style: AppTypography.bodyMD.copyWith(color: AppColors.onSurfaceVariant),
        ),
        TextButton(
          onPressed: () => context.push('/register'),
          child: Text(
            'Regístrate',
            style: AppTypography.labelMD
                .copyWith(color: AppColors.primaryContainer),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        side: const BorderSide(color: AppColors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppShapes.DEFAULT),
        ),
      ),
      child: Icon(icon, color: AppColors.onSurface),
    );
  }
}