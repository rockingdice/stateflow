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
@JsonSerializable(genericArgumentFactories: true)
class FlowValue<Type> extends FlowState {
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
  final FlowState? _state;
  final List<FlowState>? _states;
  final FlowWidgetBuilder _builder;

  const FlowWidget(
      {Key? key,
      FlowState? state,
      List<FlowState>? states,
      required FlowWidgetBuilder builder})
      : assert(
            (state != null && states == null) ||
                (state == null && states != null),
            'can only use either state or states!'),
        _state = state,
        _states = states,
        _builder = builder,
        super(key: key);

  @override
  _FlowWidgetState createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> {
  List<StreamSubscription<Null>?> _subscriptions = [];

  void updateSubscription() {
    for (var sub in _subscriptions) {
      sub?.cancel();
    }
    if (widget._state != null) {
      var sub = widget._state!.controller!.stream.listen((_) {
        setState(() {});
      });
      _subscriptions.add(sub);
    } else if (widget._states != null) {
      for (var s in widget._states!) {
        var sub = s.controller!.stream.listen((_) {
          setState(() {});
        });
        _subscriptions.add(sub);
      }
    }
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
    for (var sub in _subscriptions) {
      sub?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(context);
  }
}

@JsonSerializable()
class FlowInt extends FlowState {
  int value;

  FlowInt(this.value);

  factory FlowInt.fromJson(Map<String, dynamic> json) =>
      _$FlowIntFromJson(json);

  Map<String, dynamic> toJson() => _$FlowIntToJson(this);
}

@JsonSerializable()
class FlowDouble extends FlowState {
  double value;

  FlowDouble(this.value);

  factory FlowDouble.fromJson(Map<String, dynamic> json) =>
      _$FlowDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$FlowDoubleToJson(this);
}

@JsonSerializable()
class FlowString extends FlowState {
  String value;

  FlowString(this.value);

  factory FlowString.fromJson(Map<String, dynamic> json) =>
      _$FlowStringFromJson(json);

  Map<String, dynamic> toJson() => _$FlowStringToJson(this);
}

@JsonSerializable()
class FlowBool extends FlowState {
  bool value;

  FlowBool(this.value);

  factory FlowBool.fromJson(Map<String, dynamic> json) =>
      _$FlowBoolFromJson(json);

  Map<String, dynamic> toJson() => _$FlowBoolToJson(this);
}

@JsonSerializable()
class FlowListString extends FlowState {
  List<String> value;

  FlowListString(this.value);

  factory FlowListString.fromJson(Map<String, dynamic> json) =>
      _$FlowListStringFromJson(json);

  Map<String, dynamic> toJson() => _$FlowListStringToJson(this);
}

@JsonSerializable()
class FlowListNum extends FlowState {
  List<num> value;

  FlowListNum(this.value);

  factory FlowListNum.fromJson(Map<String, dynamic> json) =>
      _$FlowListNumFromJson(json);

  Map<String, dynamic> toJson() => _$FlowListNumToJson(this);
}

@JsonSerializable()
class FlowMap extends FlowState {
  Map<String, dynamic> value;

  FlowMap(this.value);

  factory FlowMap.fromJson(Map<String, dynamic> json) =>
      _$FlowMapFromJson(json);

  Map<String, dynamic> toJson() => _$FlowMapToJson(this);
}

@JsonSerializable()
class FlowSetString extends FlowState {
  Set<String> value;

  FlowSetString(this.value);

  factory FlowSetString.fromJson(Map<String, dynamic> json) =>
      _$FlowSetStringFromJson(json);

  Map<String, dynamic> toJson() => _$FlowSetStringToJson(this);
}

@JsonSerializable()
class FlowSetInt extends FlowState {
  Set<int> value;

  FlowSetInt(this.value);

  factory FlowSetInt.fromJson(Map<String, dynamic> json) =>
      _$FlowSetIntFromJson(json);

  Map<String, dynamic> toJson() => _$FlowSetIntToJson(this);
}

@JsonSerializable()
class FlowVoid extends FlowState {
  FlowVoid();

  factory FlowVoid.fromJson(Map<String, dynamic> json) =>
      _$FlowVoidFromJson(json);

  Map<String, dynamic> toJson() => _$FlowVoidToJson(this);
}
