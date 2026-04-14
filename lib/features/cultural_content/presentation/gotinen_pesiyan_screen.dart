// ════════════════════════════════════════════════════════════════
// GOTINÊN PÊŞÎYAN — Atasözleri Koleksiyonu
//
// 3363 Kurmancî atasözü, alfabe filtresi + arama.
// Kaynak: Yılmaz Mutlu derlemesi (Nisan 2026).
//
// UX:
//   - Üst: arama çubuğu + bilgi (toplam/filtrelenen sayı)
//   - Sol kenar: dikey alfabe şeridi (A B C Ç D E Ê...)
//   - Orta: atasözü kartları listesi
//   - Kart: Kurmancî (büyük) + Türkçe (varsa, küçük gri)
// ════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/router/app_router.dart';
import '../domain/gotinen_pesiyan_db.dart';

class GotinenPesiyanScreen extends ConsumerStatefulWidget {
  const GotinenPesiyanScreen({super.key});

  @override
  ConsumerState<GotinenPesiyanScreen> createState() =>
      _GotinenPesiyanScreenState();
}

class _GotinenPesiyanScreenState extends ConsumerState<GotinenPesiyanScreen> {
  String _query = '';
  String? _selectedLetter; // null = hepsi
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  // Alfabe listesi — veri dosyasında geçen benzersiz harfler, Kurmancî sıra
  static const _kurmanciAlphabet = [
    'A', 'B', 'C', 'Ç', 'D', 'E', 'Ê', 'F', 'G', 'H', 'I', 'Î',
    'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'Ş', 'T', 'V',
    'W', 'X', 'Y', 'Z',
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  List<Gotin> get _filtered {
    var items = kGotinenPesiyan;

    if (_selectedLetter != null) {
      items = items.where((g) => g.letter == _selectedLetter).toList();
    }

    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      items = items.where((g) {
        if (g.ku.toLowerCase().contains(q)) return true;
        if (g.tr != null && g.tr!.toLowerCase().contains(q)) return true;
        return false;
      }).toList();
    }

    return items;
  }

  void _safePop() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.culture);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final total = kGotinenPesiyan.length;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _safePop,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gotinên Pêşîyan',
              style: AppTypography.headline.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            Text(
              '${items.length} / $total',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // ── Arama çubuğu ──
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: TextField(
                controller: _searchCtrl,
                onChanged: (val) => setState(() => _query = val),
                decoration: InputDecoration(
                  hintText: 'Gotinê bigere…',
                  hintStyle: AppTypography.body.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                    size: 22,
                  ),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded, size: 18),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // ── Ana alan: alfabe şeridi + liste ──
          Expanded(
            child: Row(
              children: [
                // Sol dikey alfabe şeridi
                _AlphabetSidebar(
                  alphabet: _kurmanciAlphabet,
                  selectedLetter: _selectedLetter,
                  onSelect: (letter) {
                    setState(() {
                      // Aynı harfe tekrar tıklama → filtreyi kaldır
                      _selectedLetter =
                          _selectedLetter == letter ? null : letter;
                    });
                    // Başa kaydır
                    if (_scrollCtrl.hasClients) {
                      _scrollCtrl.jumpTo(0);
                    }
                  },
                ),

                // Sağ ana içerik
                Expanded(
                  child: items.isEmpty
                      ? _EmptyState(query: _query)
                      : ListView.builder(
                          controller: _scrollCtrl,
                          padding: const EdgeInsets.fromLTRB(8, 0, 16, 32),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final g = items[index];
                            // Yeni harfe geçildiğinde harf başlığı göster
                            final showHeader = index == 0 ||
                                items[index - 1].letter != g.letter;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (showHeader && _selectedLetter == null)
                                  _LetterHeader(letter: g.letter),
                                _GotinCard(gotin: g),
                                const SizedBox(height: 8),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Sol dikey alfabe şeridi — A B C Ç D E Ê F G H I Î ...
// ════════════════════════════════════════════════════════════════

class _AlphabetSidebar extends StatelessWidget {
  final List<String> alphabet;
  final String? selectedLetter;
  final ValueChanged<String> onSelect;

  const _AlphabetSidebar({
    required this.alphabet,
    required this.selectedLetter,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      margin: const EdgeInsets.only(left: 8, right: 4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: alphabet.length,
        itemBuilder: (context, i) {
          final letter = alphabet[i];
          final isActive = letter == selectedLetter;
          return GestureDetector(
            onTap: () => onSelect(letter),
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isActive
                      ? Colors.white
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Harf başlığı (liste içinde, filtresiz görünümde)
// ════════════════════════════════════════════════════════════════

class _LetterHeader extends StatelessWidget {
  final String letter;
  const _LetterHeader({required this.letter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.borderLight,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Atasözü kartı
// ════════════════════════════════════════════════════════════════

class _GotinCard extends StatelessWidget {
  final Gotin gotin;
  const _GotinCard({required this.gotin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sol: quote icon
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Icon(
                  Icons.format_quote_rounded,
                  size: 18,
                  color: AppColors.primary.withOpacity(0.6),
                ),
              ),
              // Sağ: Kurmancî metin
              Expanded(
                child: Text(
                  gotin.ku,
                  style: AppTypography.body.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          if (gotin.tr != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(
                gotin.tr!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Boş durum
// ════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  final String query;
  const _EmptyState({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 48,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 12),
            Text(
              'Gotin nehat dîtin',
              style: AppTypography.title.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              query.isEmpty
                  ? 'Tu lêger tune.'
                  : '"$query" ji bo lêgerînê encam nedit.',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
