import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:ui/resources/assets.dart';
import 'package:ui/resources/values.dart';
import 'package:ui/util/cache_manager.dart';

class CachedPokemonImage extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final BoxFit fit;
  final Widget? errorWidget;

  const CachedPokemonImage({
    super.key,
    required this.imageUrl,
    this.size = 120,
    this.fit = BoxFit.contain,
    this.errorWidget,
  });

  @override
  State<CachedPokemonImage> createState() => _CachedPokemonImageState();
}

class _CachedPokemonImageState extends State<CachedPokemonImage>
    with AutomaticKeepAliveClientMixin {
  Future<File>? _future;
  File? _lastFile;
  String? _url;

  @override
  void initState() {
    super.initState();
    _configureFuture(force: true);
  }

  @override
  void didUpdateWidget(covariant CachedPokemonImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != _url) {
      _configureFuture(force: true);
    }
  }

  void _configureFuture({bool force = false}) {
    _url = widget.imageUrl;
    if (_url == null || _url!.isEmpty) {
      _future = null;
      return;
    }
    if (force || _future == null) {
      _future = PokemonCacheManager.instance.getSingleFile(_url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final url = widget.imageUrl;
    if (url == null || url.isEmpty) {
      return widget.errorWidget ??
          const Icon(Icons.image_not_supported, size: 80, color: Colors.grey);
    }

    final ext = p.extension(url).toLowerCase();

    return FutureBuilder<File>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          _lastFile = snapshot.data;
        }

        final file = _lastFile ?? snapshot.data;

        if (file != null) {
          if (ext == '.svg') {
            return SvgPicture.file(
              file,
              width: widget.size,
              height: widget.size,
              fit: widget.fit,
            );
          } else if (ext == '.gif' ||
              ext == '.png' ||
              ext == '.jpg' ||
              ext == '.jpeg') {
            return Image.file(
              file,
              width: widget.size,
              height: widget.size,
              fit: widget.fit,
            );
          } else {
            return widget.errorWidget ??
                const Icon(Icons.help_outline, size: 80, color: Colors.orange);
          }
        }

        return Lottie.asset(
          Assets.splashAnimation,
          width: Values.loadingImageSize,
          height: Values.loadingImageSize,
          fit: BoxFit.contain,
          repeat: true,
          animate: true,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
