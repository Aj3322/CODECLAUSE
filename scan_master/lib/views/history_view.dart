import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/scan_model.dart';
import '../services/storage_service.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Clear all history
              StorageService.scanBox.clear();
            },
          ),
        ],
      ),
      body: HistoryList(),
    );
  }
}

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: StorageService.scanBox.listenable(),
      builder: (context, Box<ScanModel> box, _) {
        final scanList = box.values.toList();
        return ListView.builder(
          itemCount: scanList.length,
          itemBuilder: (context, index) {
            final scan = scanList[index];
            String formattedTitle = scan.data;
            IconData iconData = Icons.text_snippet; // Default icon
            switch (checkStringType(scan.data)) {
              case 'URL':
            formattedTitle = 'URL';
            iconData = Icons.link;
                break;
              case 'Phone Number':
            formattedTitle = 'Phone Number';
            iconData = Icons.phone;
                break;
              case 'WiFi':
            formattedTitle = 'WiFi';
            iconData = Icons.wifi;
                break;
              case 'Contact Data':
            formattedTitle = 'Contact Data';
            iconData = Icons.contact_page_outlined;
                break;
              case 'Number':
            formattedTitle = 'Number';
            iconData = Icons.numbers;
                break;
              case 'Text':
                formattedTitle = 'Text';
                iconData = Icons.text_snippet;
                break;
              case 'Email':
                formattedTitle = 'Email';
                iconData = Icons.email;
                break;
              case 'vCard':
                formattedTitle = 'vCard';
                iconData = Icons.person;
                break;
              case 'SMS':
                formattedTitle = 'SMS';
                iconData = Icons.sms;
                break;
              case 'Barcode Product Number':
                formattedTitle = 'Product';
                iconData = Icons.production_quantity_limits;
                break;
            }

            return ListTile(
              leading: Icon(iconData),
              title: Text(formattedTitle),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(scan.data),
                  Text(scan.dateTime.toString(),style: const TextStyle(fontSize: 11),),
                ],
              ),
              trailing: _popMenu(index, box, scan),
              onTap: () => showResultDialog(context, scan.data),
            );
          },
        );
      },
    );
  }

  bool _isURL(String data) {
    return data.startsWith('http://') || data.startsWith('https://');
  }
  String checkStringType(String text) {
    final urlPatterns = [
      r"(https?|ftp)://([-A-Z0-9.]+)(/?[:]?\w+)*(/?[^#]*)#?([^?+]*?)?",
      r"(www.)?[-A-Za-z0-9]+\.[A-Za-z]{2,}",
    ];

    const phonePattern = r"^\d[\d\s-]{9,12}$";
    const wifiPattern =
        r"^(?:([0-9]{1,3}\.){3}[0-9]{1,3})|(?:([0-9A-Fa-f]{1,2}:){5}[0-9A-Fa-f]{1,2})$"; // Basic WiFi pattern (IP or MAC address)
    const emailPattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[-a-zA-Z0-9]{0,61}[a-zA-Z0-9])?\.[a-zA-Z]{2,}$"; // Basic email pattern
    const barcodePattern = r"^\d{8,13}$";

    // Check for email (consider adding more specific contact data checks)
    if (RegExp(emailPattern).hasMatch(text)||text.startsWith('mail')) {
      return 'Email';
    }
    // Check for vCard
    if (text.contains('BEGIN:VCARD') && text.contains('END:VCARD')) {
      return 'vCard';
    }
    //Check for sms
    if (text.startsWith('SMSTO:')) {
      return 'SMS';
    }
    // Check for URL first
    for (var pattern in urlPatterns) {
      if (RegExp(pattern).hasMatch(text)) {
        return 'URL';
      }
    }
    // Check for barcode
    if (RegExp(barcodePattern).hasMatch(text)) {
      return 'Barcode Product Number';
    }
    // Check for phone number
    if (RegExp(phonePattern).hasMatch(text)||text.startsWith('tel')) {
      return 'Phone Number';
    }

    // Check for WiFi data
    if (RegExp(wifiPattern).hasMatch(text)||text.startsWith('WIFI:S:')) {
      return 'WiFi';
    }

    // Check for Contact Data
    if (RegExp(emailPattern).hasMatch(text)) {
      return 'Contact Data';
    }

    // Check for barcode
    if (RegExp(barcodePattern).hasMatch(text)) {
      return 'Barcode Product Number';
    }

    // Check if all characters are numbers
    if (text.split('').every((char) => RegExp(r'[0-9]').hasMatch(char))) {
      return 'Number';
    }

    // Otherwise, consider it text
    return 'Text';
  }


  Widget _popMenu(int index, Box<ScanModel> box, ScanModel scan) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        switch (value) {
          case 'delete':
            box.deleteAt(index);
            break;
          case 'open':
            // if (_isURL(scan.data)) {
              final Uri url = Uri.parse(scan.data);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              // }
            }
            break;
          case 'copy':
            Clipboard.setData(ClipboardData(text: scan.data));
            Get.snackbar('Copied', 'History item copied to clipboard');
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
        // if (_isURL(scan.data))
          const PopupMenuItem(
            value: 'open',
            child: Text('Open'),
          ),
        const PopupMenuItem(
          value: 'copy',
          child: Text('Copy'),
        ),
      ],
    );
  }

  void showResultDialog(BuildContext context, String text) {
    String type = checkStringType(text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detected Type: $type'),
          content: Text('Content: $text'),
          actions: <Widget>[
            if (type == 'URL') ...[
              TextButton(
                child: Text('Open URL'),
                onPressed: () async {
                  if (await canLaunch(text)) {
                    await launch(text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not launch URL')),
                    );
                  }
                  Navigator.of(context).pop();
                },
              ),
            ] else if (type == 'Email') ...[
              TextButton(
                child: Text('Send Email'),
                onPressed: () {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: text,
                  );
                  launch(emailUri.toString());
                  Navigator.of(context).pop();
                },
              ),
            ] else if (type == 'Phone Number') ...[
              TextButton(
                child: Text('Call'),
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: text,
                  );
                  launch(phoneUri.toString());
                  Navigator.of(context).pop();
                },
              ),
            ] else if (type == 'SMS') ...[
              TextButton(
                child: Text('Send Sms'),
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'SMSTO',
                    path: text,
                  );
                  launch(phoneUri.toString());
                  Navigator.of(context).pop();
                },
              ),
            ] else if (type == 'vCard') ...[
              TextButton(
                child: const Text('Save Contact'),
                onPressed: () {
                  final Uri phoneUri = Uri(
                    scheme: 'data:text/vcard;charset=utf-8,',
                    path: text,
                  );
                  launch(phoneUri.toString());
                  Navigator.of(context).pop();
                },
              ),
            ],
            TextButton(
              child: Text('Copy'),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard')),
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
