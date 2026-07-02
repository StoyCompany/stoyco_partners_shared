import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/cards/card_financial.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/info_card/info_pill_card.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

/// Reusable widget to display a balance card with hide/show toggle functionality
///
/// This widget is completely independent and can be used anywhere in the application
/// or moved to a shared library.
///
/// Usage example:
/// ```dart
/// BalanceCard(
///   balance: 1500000.00,
///   title: 'TOTAL BALANCE',
///   infoMessage: 'Withdrawals available soon',
///   onVisibilityToggle: (isVisible) {
///     print('Balance visibility: $isVisible');
///   },
/// )
/// ```
class BalanceCard extends StatefulWidget {
  const BalanceCard({
    required this.balance,
    this.title = 'BALANCE TOTAL',
    this.infoMessage,
    this.titleColor,
    this.balanceColor,
    this.iconColor,
    this.infoIconColor,
    this.infoTextColor,
    this.infoBorderColor,
    this.infoBackgroundColor,
    this.currencyLocale = 'en_US',
    this.currencySymbol = r'$',
    this.currencyDecimalDigits = 2,
    this.hiddenBalanceText = r'$ ••••••••',
    this.initiallyVisible = true,
    this.fontFamily,
    this.onVisibilityToggle,
    super.key,
  });

  /// The balance amount to display (can be null if data is not yet available)
  final double? balance;

  /// Card title (e.g., "TOTAL BALANCE", "AVAILABLE BALANCE")
  final String title;

  /// Optional informative message shown below the balance
  final String? infoMessage;

  /// Customizable colors
  final Color? titleColor;
  final Color? balanceColor;
  final Color? iconColor;
  final Color? infoIconColor;
  final Color? infoTextColor;
  final Color? infoBorderColor;
  final Color? infoBackgroundColor;

  /// Currency format configuration
  final String currencyLocale;
  final String currencySymbol;
  final int currencyDecimalDigits;

  /// Text shown when balance is hidden
  final String hiddenBalanceText;

  /// Whether the balance is initially visible
  final bool initiallyVisible;

  /// Optional font family
  final String? fontFamily;

  /// Optional callback when visibility changes
  final ValueChanged<bool>? onVisibilityToggle;

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  late bool _isBalanceVisible;

  @override
  void initState() {
    super.initState();
    _isBalanceVisible = widget.initiallyVisible;
  }

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
    widget.onVisibilityToggle?.call(_isBalanceVisible);
  }

  String _formatBalance() {
    if (widget.balance == null) {
      return '${widget.currencySymbol}-';
    }

    return NumberFormat.currency(
      locale: widget.currencyLocale,
      symbol: widget.currencySymbol,
      decimalDigits: widget.currencyDecimalDigits,
    ).format(widget.balance);
  }

  @override
  Widget build(BuildContext context) {
    final String formattedBalance = _formatBalance();

    // Get default colors from ColorFoundation
    final Color titleColorResolved =
        widget.titleColor ?? ColorFoundation.text.grey5;
    final Color balanceColorResolved =
        widget.balanceColor ?? ColorFoundation.text.white;
    final Color iconColorResolved =
        widget.iconColor ?? ColorFoundation.text.white;

    return CardFinancial(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: widget.fontFamily,
              fontSize: StoycoScreenSize.fontSize(context, 14),
              color: titleColorResolved,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
          ),

          SizedBox(height: StoycoScreenSize.height(context, 8)),

          // Balance with visibility icon
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  _isBalanceVisible
                      ? formattedBalance
                      : widget.hiddenBalanceText,
                  style: TextStyle(
                    fontFamily: widget.fontFamily,
                    fontSize: StoycoScreenSize.fontSize(context, 30),
                    fontWeight: FontWeight.w700,
                    color: balanceColorResolved,
                    letterSpacing: 0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: StoycoScreenSize.width(context, 12)),
              GestureDetector(
                onTap: _toggleBalanceVisibility,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: StoycoScreenSize.all(context, 4),
                  child: Icon(
                    _isBalanceVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: iconColorResolved,
                    size: StoycoScreenSize.width(context, 26),
                  ),
                ),
              ),
            ],
          ),

          // Informative message (optional)
          if (widget.infoMessage != null) ...<Widget>[
            SizedBox(height: StoycoScreenSize.height(context, 16)),
            InfoPillCard(
              message: widget.infoMessage!,
              fontSize: StoycoScreenSize.fontSize(context, 15),
            ),
          ],
        ],
      ),
    );
  }
}
