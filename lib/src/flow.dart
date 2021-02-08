import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow.g.dart';

/// FlowState
/// Subclass a FlowState to make a custom state that
/// could be used for FlowWidget to rebuild.
///

class FlowState {
  StreamController<Null>? _controller;

  StreamController<Null>? get controller {
    if (_controller == null) {
      _controller = StreamController.broadcast(
        onListen: () {},
        onCancel: () {
          _controller?.close();
          _controller = null;
        },
      );
    }
    return _controller;
  }

  void rebuild() async {
    controller?.add(null);
  }

  @override
  String toString() {
    return "FlowData:(${shortHash(this)})";
  }
}

///
/// FlowValue<Type>
/// Use FlowValue directly with base types as a state:
/// FlowValue<bool>
/// FlowValue<String>
///

@JsonSerializable()
class FlowValue<Type> extends FlowState {
  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  Type data;

  FlowValue(Type data) : data = data;

  set value(Type d) => data = d;

  @JsonKey(ignore: true)
  Type get value => data;

  @override
  String toString() {
    return "FlowValue:($data)";
  }

  static Type _dataFromJson<Type>(Type input) => input;

  static Type _dataToJson<Type>(Type input) => input;

  factory FlowValue.fromJson(Map<String, dynamic> json) =>
      _$FlowValueFromJson(json);

  Map<String, dynamic> toJson() => _$FlowValueToJson(this);
}

/// FlowWidget
/// Connect to a FlowState to rebuild.

typedef Widget FlowWidgetBuilder(BuildContext context);

class FlowWidget extends StatefulWidget {
  final FlowState _state;
  final FlowWidgetBuilder _builder;

  const FlowWidget(
      {Key? key, required FlowState state, required FlowWidgetBuilder builder})
      : _state = state,
        _builder = builder,
        super(key: key);

  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  StreamSubscription<Null>? _subscription;

  void updateSubscription() {
    _subscription?.cancel();

    _subscription = widget._state.controller!.stream.listen((_) {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(FlowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateSubscription();
  }

  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateSubscription();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(context);
  }
}
