import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flow.g.dart';

/// FlowState
/// Subclass a FlowState to make a custom state that
/// could be used for FlowWidget to rebuild.
///

class _FlowState {
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
@JsonSerializable(genericArgumentFactories: true)
class FlowValue<Type> extends _FlowState {
  Type value;

  FlowValue(this.value);

  @override
  String toString() {
    return "FlowValue:($value)";
  }

  factory FlowValue.fromJson(
    Map<String, dynamic> json,
    Type Function(Object? json) fromJsonT,
  ) =>
      _$FlowValueFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(Type value) toJsonT) =>
      _$FlowValueToJson(this, toJsonT);
}

/// FlowWidget
/// Connect to a FlowState to rebuild.

typedef Widget FlowWidgetBuilder(BuildContext context);

class FlowWidget extends StatefulWidget {
  final _FlowState _state;
  final FlowWidgetBuilder _builder;

  const FlowWidget(
      {Key? key, required _FlowState state, required FlowWidgetBuilder builder})
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

@JsonSerializable()
class FlowInt extends _FlowState {
  int value;

  FlowInt(this.value);

  factory FlowInt.fromJson(Map<String, dynamic> json) =>
      _$FlowIntFromJson(json);

  Map<String, dynamic> toJson() => _$FlowIntToJson(this);
}

@JsonSerializable()
class FlowDouble extends _FlowState {
  double value;

  FlowDouble(this.value);

  factory FlowDouble.fromJson(Map<String, dynamic> json) =>
      _$FlowDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$FlowDoubleToJson(this);
}

@JsonSerializable()
class FlowString extends _FlowState {
  String value;

  FlowString(this.value);

  factory FlowString.fromJson(Map<String, dynamic> json) =>
      _$FlowStringFromJson(json);

  Map<String, dynamic> toJson() => _$FlowStringToJson(this);
}

@JsonSerializable()
class FlowBool extends _FlowState {
  bool value;

  FlowBool(this.value);

  factory FlowBool.fromJson(Map<String, dynamic> json) =>
      _$FlowBoolFromJson(json);

  Map<String, dynamic> toJson() => _$FlowBoolToJson(this);
}

@JsonSerializable()
class FlowListString extends _FlowState {
  List<String> value;

  FlowListString(this.value);

  factory FlowListString.fromJson(Map<String, dynamic> json) =>
      _$FlowListStringFromJson(json);

  Map<String, dynamic> toJson() => _$FlowListStringToJson(this);
}

@JsonSerializable()
class FlowListNum extends _FlowState {
  List<num> value;

  FlowListNum(this.value);

  factory FlowListNum.fromJson(Map<String, dynamic> json) =>
      _$FlowListNumFromJson(json);

  Map<String, dynamic> toJson() => _$FlowListNumToJson(this);
}

@JsonSerializable()
class FlowMap extends _FlowState {
  Map<String, dynamic> value;

  FlowMap(this.value);

  factory FlowMap.fromJson(Map<String, dynamic> json) =>
      _$FlowMapFromJson(json);

  Map<String, dynamic> toJson() => _$FlowMapToJson(this);
}

@JsonSerializable()
class FlowSetString extends _FlowState {
  Set<String> value;

  FlowSetString(this.value);

  factory FlowSetString.fromJson(Map<String, dynamic> json) =>
      _$FlowSetStringFromJson(json);

  Map<String, dynamic> toJson() => _$FlowSetStringToJson(this);
}

@JsonSerializable()
class FlowSetInt {
  Set<int> value;

  FlowSetInt(this.value);

  factory FlowSetInt.fromJson(Map<String, dynamic> json) =>
      _$FlowSetIntFromJson(json);

  Map<String, dynamic> toJson() => _$FlowSetIntToJson(this);
}
