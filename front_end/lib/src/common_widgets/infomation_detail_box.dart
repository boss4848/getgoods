import 'package:flutter/material.dart';
import 'package:getgoods/src/common_widgets/shadow_container.dart';

import '../constants/colors.dart';
//timeago
import 'package:timeago/timeago.dart' as timeago;

class InformationDetailBox extends StatelessWidget {
  final String title;

  final String subTitle;
  final Map<String, dynamic> info;
  final DateTime? updateAt;
  final Function onEdit;
  const InformationDetailBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.info,
    required this.updateAt,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> productInfo = {
    //   'title': title,
    //   'ID': '9123891023809123',
    //   'Name': 'Dried Mango',
    //   'Description': 'This is dried mango',
    //   'Price': 100,
    //   'Quantity': 100,
    //   'Category': 'Processed',
    //   'Sold': 0,
    // };
    int index = -1;

    return ShadowContainer(
      padding: false,
      items: info.entries.map(
        //map with index
        (e) {
          index++;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 12,
                    right: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => onEdit(),
                        child: const Text(
                          'Change Infomation',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: updateAt == null ? 8 : 0,
                    left: 12,
                    right: 12,
                  ),
                  child: Text(
                    subTitle,
                    style: const TextStyle(
                      color: grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 12,
                    right: 12,
                  ),
                  child: Text(
                    'Last updated: ${updateAt?.toLocal().toString().split('.')[0] ?? ''}',
                    style: const TextStyle(
                      color: grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                _buildDivider(),
              ],
              //remove first item
              _buildSetInput(
                label: e.key,
                value: e.value.toString(),
              ),
              //remove divider for last item
              if (e.key != info.entries.last.key) _buildDivider(),
            ],
          );
        },
      ).toList(),
    );
  }

  _buildSetInput({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: secondaryTextColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Divider _buildDivider() {
    return const Divider(
      color: secondaryBGColor,
      thickness: 1.1,
    );
  }
}
