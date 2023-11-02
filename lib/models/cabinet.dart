import 'package:json_annotation/json_annotation.dart';

part 'cabinet.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Cabinet {
  final int id;
  final String name;
  final int floor;

  const Cabinet({
    required this.id,
    required this.name,
    required this.floor,
  });

  factory Cabinet.fromJson(Map<String, dynamic> json) => _$CabinetFromJson(json);
}
