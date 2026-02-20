import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/merch_content_model.dart';

class MerchContentDescription extends StatelessWidget {
  const MerchContentDescription({
    required this.data,
    super.key,
  });

  final MerchContentModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          data.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(data.description),
        const SizedBox(height: 8),
        Text(
          'Published: ${data.publishDate}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Text('👍 ${data.likes}'),
            const SizedBox(width: 16),
            Text('💬 ${data.comments}'),
            const SizedBox(width: 16),
            Text('📤 ${data.shares}'),
            const SizedBox(width: 16),
            Text('👁 ${data.views}'),
          ],
        ),
      ],
    );
  }
}
