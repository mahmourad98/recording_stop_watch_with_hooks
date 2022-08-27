import 'package:flutter_test/flutter_test.dart';
import 'package:untitled04/business_logic/counter.dart';

void main(){
  group(
    "testing the counter class functionality",
    (){
      test(
        "testing the counter class",
        (){
          final counter = Counter();
          counter.increment();
          expect(counter.counter, 1,);
        },
      );
      test(
        "testing the counter class",
        (){
          final counter = Counter();
          counter.decrement();
          expect(counter.counter, -1,);
        },
      );
      test(
        "testing the counter class",
        (){
          final counter = Counter();
          counter.increment();
          counter.decrement();
          expect(counter.counter, 0,);
        },
      );
      test(
        "testing the counter class",
        (){
          final counter = Counter();
          counter.decrement();
          counter.increment();
          expect(counter.counter, 0,);
        },
      );
    },
  );
}