import 'package:flutter/material.dart';

class AppScrollCard<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final double height;
  final Color activeDotColor;
  final Color inactiveDotColor;

  const AppScrollCard({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height = 850, // altura padrão ajustável
    this.activeDotColor = Colors.blue,
    this.inactiveDotColor = Colors.grey,
  });

  @override
  State<AppScrollCard<T>> createState() => _AppScrollCardState<T>();
}

class _AppScrollCardState<T> extends State<AppScrollCard<T>> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.9, // mantém leve espaçamento lateral
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // 🔹 Agora o conteúdo é renderizado diretamente
                child: widget.itemBuilder(widget.items[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (index) {
            final bool isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 12 : 8,
              height: isActive ? 12 : 8,
              decoration: BoxDecoration(
                color: isActive
                    ? widget.activeDotColor
                    : widget.inactiveDotColor,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
