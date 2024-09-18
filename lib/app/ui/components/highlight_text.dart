import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle? normalStyle;
  final int? normalMaxLines;
  final TextStyle? highlightStyle;

  const HighlightText({
    super.key,
    required this.text,
    required this.query,
    required this.normalStyle,
    this.normalMaxLines,
    required this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return Text(text, style: normalStyle, maxLines: normalMaxLines ?? 3, overflow: TextOverflow.ellipsis);
    }

    final List<TextSpan> spans = [];
    final String lowerText = text.toLowerCase();
    final String lowerQuery = query.toLowerCase();

    int start = 0;
    int index;

    while ((index = lowerText.indexOf(lowerQuery, start)) != -1) {
      if (index > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, index),
            style: normalStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: highlightStyle,
        ),
      );

      start = index + query.length;
    }

    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: normalStyle,
        ),
      );
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: normalMaxLines ?? 3,
    );
  }
}
