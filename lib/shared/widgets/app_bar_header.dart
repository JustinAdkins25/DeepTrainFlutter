import 'package:flutter/material.dart';

class AppBarHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70); // AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleSpacing: 40,
      title: Row(
        children: [
          // Logo or Brand Name
          Text(
            'DeepTrain',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue[700],
            ),
          ),

          const Spacer(),

          // Navigation Links (for desktop)
          _NavButton(label: 'Home', onTap: () {}),
          _NavButton(label: 'Features', onTap: () {}),
          _NavButton(label: 'Pricing', onTap: () {}),
          _NavButton(label: 'Contact', onTap: () {}),

          const SizedBox(width: 20),

          // Login Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}
