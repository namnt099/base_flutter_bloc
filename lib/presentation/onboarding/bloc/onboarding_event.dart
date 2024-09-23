import 'package:sdk_wallet_flutter/config/base/bloc/base_event.dart';

class OnboardingEvent extends BaseEvent {}

class EmmittedPageAction extends OnboardingEvent {
  final PageAction action;
  EmmittedPageAction({required this.action});
}

enum PageAction {
  next,
  pre,
}
