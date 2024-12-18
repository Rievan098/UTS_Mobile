// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_2301083020_a/main.dart';

void main() {
  testWidgets('TransaksiPage displays correct transaction details', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Open the drawer and navigate to the Transaksi page.
    await tester.tap(find.byIcon(Icons.menu)); // Open the drawer
    await tester.pumpAndSettle(); // Wait for the drawer to open

    // Tap on the 'Transaksi Warnet' item
    await tester.tap(find.text('Transaksi Warnet'));
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify that the Transaksi page displays the correct details
    expect(find.text('Kode Transaksi: TR001'), findsOneWidget);
    expect(find.text('Nama Pelanggan: John Doe'), findsOneWidget);
    expect(find.text('Jenis Pelanggan: VIP'), findsOneWidget);
    expect(find.text('Jam Masuk: 10:00'), findsOneWidget);
    expect(find.text('Jam Keluar: 14:00'), findsOneWidget);
    expect(find.text('Lama: 4.0 Jam'), findsOneWidget);
    expect(find.text('Tarif: Rp 10000'), findsOneWidget);
    expect(find.text('Diskon: Rp 200.00'), findsOneWidget); // Expected discount for VIP
    expect(find.text('Total Bayar: Rp 38000.00'), findsOneWidget); // Total after discount
  });
}
