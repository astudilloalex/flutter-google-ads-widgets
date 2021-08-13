import 'package:flutter/material.dart';
import 'package:google_ads_widgets/src/constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Banner ad widget
class BannerAdWidget extends StatefulWidget {
  /// Targeting information used to fetch an [Ad].
  ///
  /// If it is null, an instance without parameters is called.
  final AdRequest? adRequest;

  /// Represents the size of a banner ad.
  ///
  /// Default is [AdSize.banner].
  final AdSize adSize;

  /// Identifies the source of [Ad]s for your application.
  ///
  /// If it is null, the id of the test ads is used.
  final String? adUnitId;

  /// Define a Banner Ad widget.
  const BannerAdWidget({
    Key? key,
    this.adRequest,
    this.adSize = AdSize.banner,
    this.adUnitId,
  }) : super(key: key);

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.adSize.height.toDouble(),
      width: widget.adSize.width.toDouble(),
      child: Builder(
        builder: (_) {
          if (_loaded) {
            return AdWidget(ad: _bannerAd!);
          }
          return const Center();
        },
      ),
    );
  }

  void _load() {
    _bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId ?? TestAdId.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _loaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: widget.adRequest ?? const AdRequest(),
    )..load();
  }
}
