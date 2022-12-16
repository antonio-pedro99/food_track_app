import 'package:flutter/material.dart';

import '../blocs/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({
    Key? key,
    required this.bloc,
    required this.child,
  }) : super(key: key);

  // 2
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 3
  @override
  Widget build(BuildContext context) => widget.child;

  // 4
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class MultiBlocProvider extends StatelessWidget {
  final List<BlocProvider>? providers;
  final Widget child;

  const MultiBlocProvider(
      {super.key, required this.child, required this.providers});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
