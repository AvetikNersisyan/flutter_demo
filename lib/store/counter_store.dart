import "package:mobx/mobx.dart";
part "counter_store.g.dart";


class CounterStore  = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {

  @observable
  int count = 0;

  @action
  void increment() {
    count++;
  }
}