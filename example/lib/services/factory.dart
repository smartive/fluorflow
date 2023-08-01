import 'package:example/services/singleton.dart';
import 'package:fluorflow/annotations.dart';

class ConstructedService {}

class ConstructedServiceWithOneParam {
  final String name;

  ConstructedServiceWithOneParam(this.name);
}

class ConstructedServiceWithTwoParams {
  final String name;
  final SingletonService svc;

  ConstructedServiceWithTwoParams(this.name, this.svc);
}

@Factory()
ConstructedService constructedSvcFactory() => ConstructedService();

@Factory()
ConstructedServiceWithOneParam constructedSvc1PFactory(String name) =>
    ConstructedServiceWithOneParam(name);

@Factory()
ConstructedServiceWithTwoParams constructedSvc2PFactory(
        String name, SingletonService svc) =>
    ConstructedServiceWithTwoParams(name, svc);
