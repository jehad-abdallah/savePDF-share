import 'package:flutter/material.dart';
import 'printable_data.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaveBtnBuilder extends StatelessWidget {
  const SaveBtnBuilder({Key? key}) : super(key: key);

  Future<void> sharePhoto() async {
    final image = await imageFromAssetBundle(
      "assets/Images/image.png",
    );
    await Share.shareFiles(['assets/Images/image.png'], text: 'Image Shared');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.indigo,
              primary: Colors.indigo,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () => printDoc(),
            child: const Text(
              "Save as PDF",
              style: TextStyle(color: Colors.white, fontSize: 20.00),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
              onPressed: () => sharePhoto(),
              icon: const Icon(Icons.share),
              label: const Text('Share This Sentence')),
        ],
      ),
    );
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/Images/image.png",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
