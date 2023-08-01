import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' as cb;
import 'package:source_gen/source_gen.dart';

TEnum getEnumFromAnnotation<TEnum extends Enum>(
    List<TEnum> values, DartObject enumField,
    [TEnum? defaultValue]) {
  final index = enumField.getField('index')?.toIntValue();
  if (index == null && defaultValue != null) {
    return defaultValue;
  }
  return values[index ?? 0];
}

cb.Reference recursiveTypeReference(
  LibraryReader lib,
  DartType t, {
  dynamic Function(cb.TypeReferenceBuilder)? typeRefUpdates,
}) {
  cb.Reference mapRef(DartType t) => recursiveTypeReference(lib, t);

  return switch (t) {
    VoidType() ||
    DynamicType() =>
      cb.refer(t.getDisplayString(withNullability: false)),
    DartType(alias: InstantiatedTypeAliasElement(:final element)) =>
      cb.refer(element.name, lib.pathToElement(element).toString()),
    final FunctionType f => cb.FunctionType((b) => b
      ..returnType = mapRef(f.returnType)
      ..requiredParameters.addAll(f.parameters
          .where((p) => p.isRequiredPositional)
          .map((p) => p.type)
          .map(mapRef))
      ..optionalParameters.addAll(f.parameters
          .where((p) => p.isOptionalPositional)
          .map((p) => p.type)
          .map(mapRef))
      ..namedRequiredParameters.addAll({
        for (final p in f.parameters.where((p) => p.isRequiredNamed))
          p.name: mapRef(p.type)
      })
      ..namedParameters.addAll({
        for (final p in f.parameters.where((p) => p.isOptionalNamed))
          p.name: mapRef(p.type)
      })
      ..types.addAll(f.typeFormals
          .where((tf) => tf.bound != null)
          .map((tf) => tf.bound!)
          .map(mapRef))),
    _ => cb.TypeReference((b) => b
          ..isNullable = t.nullabilitySuffix == NullabilitySuffix.question
          ..symbol =
              t.element?.name ?? t.getDisplayString(withNullability: false)
          ..types.addAll(switch (t) {
            ParameterizedType(:final typeArguments) =>
              typeArguments.map(mapRef).toList(),
            _ => [],
          })
          ..url = t.element == null
              ? null
              : lib.pathToElement(t.element!).toString())
        .rebuild(typeRefUpdates ?? (b) => b),
  };
}
