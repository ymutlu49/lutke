"""Type-aware share card layout: pure proverb vs long-form article."""
import sys
sys.stdout.reconfigure(encoding='utf-8')

path = 'lib/features/cultural_content/widgets/share_card_renderer.dart'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

start_marker = '  @override\n  Widget build(BuildContext context) {\n    // Font ladder'
end_marker = '\n/// Robust normalized comparison'
idx_start = content.find(start_marker)
idx_end = content.find(end_marker, idx_start)
print(f'start={idx_start}, end={idx_end}')

# New body: branch into pull-quote vs article based on type.
# Use raw string for Dart code to avoid Python escape issues.
new_body = r'''  @override
  Widget build(BuildContext context) {
    // Pure proverb: pull-quote (full text, hero font).
    // Long-form (event/food/celebration/architecture/story/folkDance):
    //   title-prominent + first-paragraph snippet (~200 char teaser).
    final isPureProverb = item.type == CulturalContentType.proverb;
    if (isPureProverb) {
      return _buildPullQuoteVariant();
    }
    return _buildArticleVariant();
  }

  // ── Pure proverb pull-quote ──────────────────────────────────
  Widget _buildPullQuoteVariant() {
    final length = item.kurmanjContent.length;
    final heroSize = length <= 30
        ? 92.0
        : length <= 60
            ? 76.0
            : length <= 100
                ? 60.0
                : length <= 160
                    ? 50.0
                    : length <= 220
                        ? 42.0
                        : 36.0;

    final hasDistinctTitle =
        !_isSameAsContent(item.kurmanjTitle, item.kurmanjContent) &&
            item.kurmanjTitle.isNotEmpty;
    final hasTr =
        includeTurkish && item.turkishContent.trim().isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '“',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 96,
            height: 0.55,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFE8B923).withOpacity(0.55),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          item.kurmanjContent,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: heroSize,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.32,
            letterSpacing: 0.3,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        if (hasDistinctTitle) ...[
          const SizedBox(height: 28),
          Text(
            '— ${item.kurmanjTitle}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: const Color(0xFFE8B923).withOpacity(0.95),
              letterSpacing: 0.5,
            ),
          ),
        ],
        if (hasTr) ...[
          const SizedBox(height: 32),
          Container(
            width: 80,
            height: 1.4,
            color: const Color(0xFFE8B923).withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            item.turkishContent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 26,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: Colors.white.withOpacity(0.86),
              height: 1.45,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }

  // ── Article (long-form) — title-prominent + snippet teaser ───
  Widget _buildArticleVariant() {
    final firstPara = _firstParagraph(item.kurmanjContent);
    final snippet = _truncateAtSentence(firstPara, 220);
    final wasTruncated = snippet.length < firstPara.length ||
        firstPara.length < item.kurmanjContent.trim().length;

    final titleSize = item.kurmanjTitle.length <= 24
        ? 60.0
        : item.kurmanjTitle.length <= 36
            ? 50.0
            : 42.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          item.kurmanjTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.18,
            letterSpacing: 0.6,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Container(
          width: 80,
          height: 1.6,
          color: const Color(0xFFE8B923).withOpacity(0.65),
        ),
        const SizedBox(height: 22),
        Text(
          wasTruncated ? '$snippet…' : snippet,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.94),
            height: 1.5,
            letterSpacing: 0.2,
          ),
        ),
        if (wasTruncated) ...[
          const SizedBox(height: 24),
          Text(
            'Berdewama li lutke.app',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: const Color(0xFFE8B923).withOpacity(0.85),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ],
    );
  }
}

/// İlk anlamlı paragrafı döndürür (boş satır ile ayrılmış).
String _firstParagraph(String text) {
  final t = text.trim();
  final dbl = t.split(RegExp(r'\n\s*\n'));
  if (dbl.length > 1 && dbl[0].trim().isNotEmpty) {
    return dbl[0].trim();
  }
  final lines =
      t.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
  return lines.isEmpty ? t : lines.first;
}

/// Cümle sınırında veya kelime sınırında keser.
String _truncateAtSentence(String text, int maxLen) {
  if (text.length <= maxLen) return text;
  final cutoff = text.substring(0, maxLen);
  final m = RegExp(r'^.*[.!?]').firstMatch(cutoff);
  if (m != null) {
    final s = m.group(0)!;
    if (s.length >= maxLen ~/ 2) return s.trim();
  }
  final lastSpace = cutoff.lastIndexOf(' ');
  if (lastSpace > maxLen ~/ 2) {
    return cutoff.substring(0, lastSpace).trim();
  }
  return cutoff.trim();
}

'''

new_content = content[:idx_start] + new_body + content[idx_end:]
with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)
print(f'Wrote {len(new_content)} bytes (was {len(content)})')
