import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class BaseProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Widget? child;
  final T  model;
  final Function(T)? onReady;

  const BaseProvider({Key? key, required this.builder, required this.model, this.child, this.onReady}) : super(key: key);

  @override
  _BaseProviderState<T> createState() => _BaseProviderState<T>();
}

class _BaseProviderState<T extends ChangeNotifier> extends State<BaseProvider<T>> {
  late T model;

  @override
  void initState () {
    model = widget.model;
    if(widget.onReady != null) widget.onReady!(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

