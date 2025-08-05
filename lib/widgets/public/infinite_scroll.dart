import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_application/core/extentions.dart';

class InfiniteAutoScrollListView extends StatefulWidget {
  final List<Widget> children;
  // final double itemWidth;
  final double scrollVelocity;
  final Duration scrollTickDuration;

  ///
  const InfiniteAutoScrollListView({
    super.key,
    required this.children,
    // required this.itemWidth,
    this.scrollVelocity = 1.0,
    this.scrollTickDuration = const Duration(milliseconds: 16),
  }) : assert(children.length > 0, 'Provide at least one child');

  @override
  State<InfiniteAutoScrollListView> createState() =>
      _InfiniteAutoScrollListViewState();
}

class _InfiniteAutoScrollListViewState
    extends State<InfiniteAutoScrollListView> {
  late final ScrollController _scrollController;
  Timer? _scrollTimer;
  // We pick a very large itemCount so that, for a long time, the user cannot scroll
  // to the “true” end. When they do get close, we jump back to the midpoint.
  static const int _virtualMultiplier = 100000;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Start auto‐scrolling after the first frame is drawn.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
      _scrollController.animateTo(context.appWidth * 5,
          duration: const Duration(milliseconds: 16), curve: Curves.easeInOut);
    });
  }

  void _startAutoScroll() {
    // Cancel any existing timer (just in case).
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(widget.scrollTickDuration, (_) {
      if (!_scrollController.hasClients) return;

      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentOffset = _scrollController.offset;
      final nextOffset = currentOffset + widget.scrollVelocity;

      if (nextOffset >= maxScrollExtent) {
        // When we’re very close to the “end” of the virtual list, jump to midpoint
        // so that modulo logic keeps it “in the middle” and the loop appears seamless.
        final midpointOffset = maxScrollExtent / 2;
        _scrollController.jumpTo(midpointOffset);
      } else {
        // Otherwise, scroll by a tiny bit.
        _scrollController.jumpTo(nextOffset);
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _stopAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.children.length * _virtualMultiplier;

    return SizedBox(
      height: 50,
      // height: widget.itemWidth, // same as itemWidth if square; otherwise wrap in a container
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _stopAutoScroll();
          } else if (notification is ScrollEndNotification) {
            _startAutoScroll();
          }
          return true;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          // physics:
          //     const NeverScrollableScrollPhysics(), // disable user‐driven fling, you can change this
          itemCount: itemCount,
          itemBuilder: (context, index) {
            // Cycle through the original children using modulo
            final actualIndex = index % widget.children.length;
            return SizedBox(
              // width: widget.itemWidth,
              child: widget.children[actualIndex],
            );
          },
        ),
      ),
    );
  }
}
