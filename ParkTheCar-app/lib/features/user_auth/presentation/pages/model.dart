// To parse this JSON data, do
//
//     final spaceCounter = spaceCounterFromJson(jsonString);

import 'dart:convert';

SpaceCounter spaceCounterFromJson(String str) => SpaceCounter.fromJson(json.decode(str));

String spaceCounterToJson(SpaceCounter data) => json.encode(data.toJson());

class SpaceCounter {
    String spaces;

    SpaceCounter({
        required this.spaces,
    });

    factory SpaceCounter.fromJson(Map<String, dynamic> json) => SpaceCounter(
        spaces: json["spaces"],
    );

    Map<String, dynamic> toJson() => {
        "spaces": spaces,
    };
}