import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' as cb;
import 'package:source_gen/source_gen.dart';

TEnum getEnumFromAnnotation<TEnum extends Enum>(
  List<TEnum> values,
  DartObject enumField, [
  TEnum? defaultValue,
]) {
  final index = enumField.getField('index')?.toIntValue();
  if (index == null && defaultValue != null) {
    return defaultValue;
  }
  return values[index ?? 0];
}

cb.Reference recursiveTypeReference(
  LibraryReader lib,
  DartType t, {
  bool forceNullable = false,
}) {
  cb.Reference mapRef(DartType t) => recursiveTypeReference(lib, t);

  return switch (t) {
    VoidType() || DynamicType() => cb.refer(t.getDisplayString()),
    DartType(alias: InstantiatedTypeAliasElement(:final element2)) => cb.refer(
      element2.displayName,
      element2.library2.uri.toString(),
    ),
    FunctionType(
      :final returnType,
      :final formalParameters,
      :final typeParameters,
      :final nullabilitySuffix,
    ) =>
      cb.FunctionType(
        (b) =>
            b
              ..isNullable =
                  forceNullable ||
                  nullabilitySuffix == NullabilitySuffix.question
              ..returnType = mapRef(returnType)
              ..requiredParameters.addAll(
                formalParameters
                    .where((p) => p.isRequiredPositional)
                    .map((p) => p.type)
                    .map(mapRef),
              )
              ..optionalParameters.addAll(
                formalParameters
                    .where((p) => p.isOptionalPositional)
                    .map((p) => p.type)
                    .map(mapRef),
              )
              ..namedRequiredParameters.addAll({
                for (final p in formalParameters.where(
                  (p) => p.isRequiredNamed,
                ))
                  p.displayName: mapRef(p.type),
              })
              ..namedParameters.addAll({
                for (final p in formalParameters.where(
                  (p) => p.isOptionalNamed,
                ))
                  p.displayName: mapRef(p.type),
              })
              ..types.addAll(
                typeParameters
                    .where((tf) => tf.bound != null)
                    .map((tf) => tf.bound!)
                    .map(mapRef),
              ),
      ),
    RecordType(
      :final positionalFields,
      :final namedFields,
      :final nullabilitySuffix,
    ) =>
      cb.RecordType(
        (b) =>
            b
              ..isNullable =
                  forceNullable ||
                  nullabilitySuffix == NullabilitySuffix.question
              ..positionalFieldTypes.addAll(
                positionalFields.map((f) => mapRef(f.type)),
              )
              ..namedFieldTypes.addIterable(
                namedFields,
                key: (f) => f.name,
                value: (f) => mapRef(f.type),
              ),
      ),
    _ => cb.TypeReference(
      (b) =>
          b
            ..isNullable =
                forceNullable ||
                t.nullabilitySuffix == NullabilitySuffix.question
            ..symbol = t.element3?.displayName ?? t.getDisplayString()
            ..types.addAll(switch (t) {
              ParameterizedType(:final typeArguments) =>
                typeArguments.map(mapRef).toList(),
              _ => [],
            })
            ..url = t.element3?.library2?.uri.toString(),
    ),
  };
}
