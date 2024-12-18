import 'package:flutter/material.dart';

class Warnet {
  final String kodeTransaksi;
  final String namaPelanggan;
  final String jenisPelanggan; // 'VIP' or 'GOLD'
  final DateTime tglMasuk;
  final DateTime jamMasuk;
  final DateTime jamKeluar;
  final double tarif;

  Warnet({
    required this.kodeTransaksi,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tarif,
  });

  double get lama {
    return jamKeluar.difference(jamMasuk).inHours.toDouble();
  }

  double get diskon {
    if (lama > 2) {
      if (jenisPelanggan == 'VIP') {
        return 0.02 * (lama * tarif);
      } else if (jenisPelanggan == 'GOLD') {
        return 0.05 * (lama * tarif);
      }
    }
    return 0.0;
  }

  double get totalBayar {
    return (lama * tarif) - diskon;
  }
}

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final _kodeTransaksiController = TextEditingController();
  final _namaPelangganController = TextEditingController();
  final _jenisPelangganController = TextEditingController();
  final _tarifController = TextEditingController();
  final _jamMasukController = TextEditingController();
  final _jamKeluarController = TextEditingController();

  void _calculateAndShowResult() {
    final String kodeTransaksi = _kodeTransaksiController.text;
    final String namaPelanggan = _namaPelangganController.text;
    final String jenisPelanggan = _jenisPelangganController.text;
    final double tarif = double.tryParse(_tarifController.text) ?? 0;

    // Parse the input time
    List<String> jamMasukParts = _jamMasukController.text.split(':');
    List<String> jamKeluarParts = _jamKeluarController.text.split(':');
    
    if (jamMasukParts.length != 2 || jamKeluarParts.length != 2) {
      // Handle invalid input
      return;
    }

    DateTime jamMasuk = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(jamMasukParts[0]),
      int.parse(jamMasukParts[1]),
    );

    DateTime jamKeluar = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(jamKeluarParts[0]),
      int.parse(jamKeluarParts[1]),
    );

    Warnet transaksi = Warnet(
      kodeTransaksi: kodeTransaksi,
      namaPelanggan: namaPelanggan,
      jenisPelanggan: jenisPelanggan,
      tglMasuk: DateTime.now(),
      jamMasuk: jamMasuk,
      jamKeluar: jamKeluar,
      tarif: tarif,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Transaksi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kode Transaksi: ${transaksi.kodeTransaksi}'),
              Text('Nama Pelanggan: ${transaksi.namaPelanggan}'),
              Text('Jenis Pelanggan: ${transaksi.jenisPelanggan}'),
              Text('Jam Masuk: ${transaksi.jamMasuk.hour}:${transaksi.jamMasuk.minute.toString().padLeft(2, '0')}'),
              Text('Jam Keluar: ${transaksi.jamKeluar.hour}:${transaksi.jamKeluar.minute.toString().padLeft(2, '0')}'),
              Text('Lama: ${transaksi.lama} Jam'),
              Text('Tarif: Rp ${transaksi.tarif}'),
              Text('Diskon: Rp ${transaksi.diskon.toStringAsFixed(2)}'),
              Text('Total Bayar: Rp ${transaksi.totalBayar.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Transaksi Warnet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _kodeTransaksiController,
              decoration: InputDecoration(labelText: 'Kode Transaksi'),
            ),
            TextField(
              controller: _namaPelangganController,
              decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            ),
            TextField(
              controller: _jenisPelangganController,
              decoration: InputDecoration(labelText: 'Jenis Pelanggan (VIP/GOLD)'),
            ),
            TextField(
              controller: _tarifController,
              decoration: InputDecoration(labelText: 'Tarif'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _jamMasukController,
              decoration: InputDecoration(labelText: 'Jam Masuk (HH:mm)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _jamKeluarController,
              decoration: InputDecoration(labelText: 'Jam Keluar (HH:mm)'),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAndShowResult,
              child: Text('Hitung Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
