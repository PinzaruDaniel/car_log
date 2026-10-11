import '../localization/localization.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../generated/garage_assets.dart';

Future<Uint8List> buildServiceHistoryPdf(ServiceHistoryPdfViewModel item) async {
  final font = pw.Font.ttf(await rootBundle.load(AppAssets.notosansRegular.path));
  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(base: font, bold: font),
  );
  pdf.addPage(
    pw.MultiPage(
      maxPages: 1000,
      pageFormat: PdfPageFormat.a4,
      header: (_) => pw.Padding(
        padding: pw.EdgeInsets.only(bottom: 20),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(item.title, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
            pw.Text(item.vehicleSummary),
            if (item.vin != null) pw.Text(item.vin!),
          ],
        ),
      ),
      footer: (context) => pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Text(
          LocaleKeys.pdf_footer.tr(namedArgs: {'page': '${context.pageNumber}', 'total': '${context.pagesCount}'}),
          style: pw.TextStyle(fontSize: 9),
        ),
      ),
      build: (_) => [
        if (item.records.isEmpty) pw.Text(item.emptyMessage),
        for (final record in item.records)
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
                pw.Text(record.title, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 6),
                pw.Text(record.summary),
                if (record.notes != null) ...[pw.SizedBox(height: 8), pw.Text(record.notes!)],
              ],
            ),
          ),
      ],
    ),
  );
  return pdf.save();
}

class ServiceHistoryPdfViewModel {
  const ServiceHistoryPdfViewModel({
    required this.title,
    required this.vehicleSummary,
    required this.vin,
    required this.emptyMessage,
    required this.records,
  });

  final String title;
  final String vehicleSummary;
  final String? vin;
  final String emptyMessage;
  final List<ServiceHistoryPdfRecordViewItem> records;
}

class ServiceHistoryPdfRecordViewItem {
  const ServiceHistoryPdfRecordViewItem({required this.title, required this.summary, required this.notes});

  final String title;
  final String summary;
  final String? notes;
}
