import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RecordingScreen extends HookWidget {
  const RecordingScreen({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    final recordingState = useState<bool>(false,);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Hooks Examples',),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center, child: _CircleButton(recordingState,),),
            Align(alignment: Alignment.center, child: _ElapsedTimeLabel(recordingState,),),
          ],
        ),
      ),
    );
  }
}

class _CircleButton extends HookWidget {
  final ValueNotifier<bool> _recordingState;
  const _CircleButton(this._recordingState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500,),
    )..repeat(reverse: true,);
    final animation = useMemoized(() => Tween(begin: 1.0, end: 10.0,).animate(controller,),);

    return SizedBox(
      height: 96,
      width: 96,
      child: AnimatedBuilder(
        animation: animation,
        child: MaterialButton(
          textColor: Colors.white,
          onPressed: () => _recordingState.value = !_recordingState.value,
          color: Colors.red,
          child: _recordingState.value
              ? const Icon(Icons.stop_rounded, size: 35,)
              : const Icon(Icons.mic, size: 35,),
          shape: const CircleBorder(),
        ),
        builder: (context, child,) {
          return Container(
            decoration: ShapeDecoration(
              color: Colors.red.shade900,
              shape: const CircleBorder(),
              shadows: [
                if (_recordingState.value) BoxShadow(
                  color: Colors.red.withOpacity(0.5,),
                  spreadRadius: animation.value,
                  blurRadius: animation.value,
                ),
              ],
            ),
            child: child,
          );
        },
      ),
    );
  }
}

class _ElapsedTimeLabel extends HookWidget {
  final ValueNotifier<bool> _recordingState;
  const _ElapsedTimeLabel(this._recordingState, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    final duration = useState(Duration.zero,);
    final stopWatch = useRef<Stopwatch?>(null,);
    final timer = useRef<Timer?>(null,);

    final use = useValueChanged(
      _recordingState.value,
      (previousValue, _,){
        if(_recordingState.value){
          stopWatch.value = Stopwatch()..start();
          timer.value = Timer.periodic(
            const Duration(milliseconds: 1,),
                (_,) {
              if(stopWatch.value?.isRunning ?? false){
                duration.value = stopWatch.value!.elapsed;
              }
            },
          );
        }else{
          duration.value = Duration.zero;
          stopWatch.value!.stop();
          stopWatch.value = null;
          timer.value!.cancel();
          timer.value = null;

        }
        return _;
      },
    );

    useEffect(
      (){
        return () => {stopWatch.value?.stop(), timer.value?.cancel(),};
      },
      const [],
    );

    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 30,),
        child: Text(duration.value.toString().substring(2, 10,),),
      ),
    );
  }
}