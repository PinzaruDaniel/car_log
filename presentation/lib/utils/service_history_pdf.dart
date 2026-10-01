import '../localization/localization.dart';
import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/garage_widgets.dart';
import '../generated/garage_assets.dart';

Future<Uint8List> buildServiceHistoryPdf(GarageVehicle vehicle) async {
  final font = pw.Font.ttf(
    await rootBundle.load(AppAssets.notosansRegular.path),
  );
  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(base: font, bold: font),
  );
  final records = [...vehicle.records]
    ..sort((a, b) => b.date.compareTo(a.date));
  pdf.addPage(
    pw.MultiPage(
      maxPages: 1000,
      pageFormat: PdfPageFormat.a4,
      header: (_) => pw.Padding(
        padding: pw.EdgeInsets.only(bottom: 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              LocaleKeys.pdf_title.tr(namedArgs: {'car': vehicle.title}),
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              LocaleKeys.pdf_vehicle.tr(
                namedArgs: {
                  'year': '${vehicle.year}',
                  'km': kilometres(vehicle.odometer),
                },
              ),
            ),
            if (vehicle.vin.isNotEmpty)
              pw.Text(LocaleKeys.pdf_vin.tr(namedArgs: {'vin': vehicle.vin})),
          ],
        ),
      ),
      footer: (context) => pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Text(
          LocaleKeys.pdf_footer.tr(
            namedArgs: {
              'page': '${context.pageNumber}',
              'total': '${context.pagesCount}',
            },
          ),
          style: pw.TextStyle(fontSize: 9),
        ),
      ),
      build: (_) => [
        if (records.isEmpty) pw.Text(LocaleKeys.pdf_empty.tr()),
        for (final record in records)
          pw.Container(
            margin: pw.EdgeInsets.only(bottom: 12),
            padding: pw.EdgeInsets.all(14),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey400),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  recordTitle(record),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                  LocaleKeys.pdf_record.tr(
                    namedArgs: {
                      'date': displayDate(record.date),
                      'km': kilometres(record.km),
                      'cost': NumberFormat.decimalPatternDigits(
                        decimalDigits: 2,
                      ).format(record.cost),
                      'category': categoryLabel(record.kind),
                    },
                  ),
                ),
                if (record.notes.isNotEmpty) ...[
                  pw.SizedBox(height: 8),
                  pw.Text(recordNotes(record)),
                ],
              ],
            ),
          ),
      ],
    ),
  );
  return pdf.save();
}
