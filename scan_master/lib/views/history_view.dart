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
              case 'WiFi Data':
            formattedTitle = 'WiFi Data';
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
      r"(www.)?[-A-Za-z0-9]+\.[A-Za-z]{2,}", // Simpler URL pattern
    ];

    final phonePattern = r"^\d[\d\s-]{9,12}$";
    final wifiPattern =
        r"^(?:([0-9]{1,3}\.){3}[0-9]{1,3})|(?:([0-9A-Fa-f]{1,2}:){5}[0-9A-Fa-f]{1,2})$"; // Basic WiFi pattern (IP or MAC address)
    final emailPattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[-a-zA-Z0-9]{0,61}[a-zA-Z0-9])?\.[a-zA-Z]{2,}$"; // Basic email pattern
    final barcodePattern = r"^\d{8,13}$"; // Barcode pattern

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
    if (RegExp(phonePattern).hasMatch(text)) {
      return 'Phone Number';
    }

    // Check for WiFi data
    if (RegExp(wifiPattern).hasMatch(text)) {
      return 'WiFi Data';
    }

    // Check for email (consider adding more specific contact data checks)
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
            if (_isURL(scan.data)) {
              final Uri url = Uri.parse(scan.data);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
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
        if (_isURL(scan.data))
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
}
