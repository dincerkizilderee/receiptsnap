import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme.dart';
import 'screens/camera_screen.dart';
import 'screens/dashboard_screen.dart';

class ReceiptSnapApp extends StatefulWidget {
  const ReceiptSnapApp({super.key});

  @override
  State<ReceiptSnapApp> createState() => _ReceiptSnapAppState();
}

class _ReceiptSnapAppState extends State<ReceiptSnapApp> {
  int _currentIndex = 0;

  void _switchToDashboard() {
    setState(() => _currentIndex = 1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReceiptSnap',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Force dark status bar
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        );
        return child!;
      },
      home: Scaffold(
        backgroundColor: AppTheme.scaffoldBg,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            CameraScreen(onReceiptSaved: _switchToDashboard),
            const DashboardScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppTheme.cardBg,
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05), width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppTheme.accent,
            unselectedItemColor: AppTheme.textMuted,
            selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: _currentIndex == 0
                      ? BoxDecoration(
                          color: AppTheme.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  child: const Icon(Icons.document_scanner_rounded, size: 24),
                ),
                label: 'Tara',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: _currentIndex == 1
                      ? BoxDecoration(
                          color: AppTheme.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        )
                      : null,
                  child: const Icon(Icons.bar_chart_rounded, size: 24),
                ),
                label: 'Ozet',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
