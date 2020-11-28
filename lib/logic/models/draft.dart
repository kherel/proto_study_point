import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/foundation.dart';

class DraftBlock {
  final String key;
  final String text;
  final BlockType type;
  final AtomicSubtype subtype;
  final int depth;
  final List<_InlineStyleRange> inlineStyleRanges;
  final List<_EntityRange> entityRanges;
  final Map<String, String> data;
  const DraftBlock({
    @required this.key,
    @required this.text,
    @required this.type,
    @required this.subtype,
    @required this.depth,
    @required this.inlineStyleRanges,
    @required this.entityRanges,
    @required this.data,
  })  : assert(key != null),
        assert(text != null),
        assert(type != null),
        assert(
          subtype != null && type == BlockType.atomic ||
              subtype == null && type != BlockType.atomic,
        ),
        assert(depth != null),
        assert(inlineStyleRanges != null),
        assert(entityRanges != null);

  static List<DraftBlock> getList(List<dynamic> map) =>
      map.map((map) => DraftBlock.fromJson(map)).toList();

  factory DraftBlock.fromJson(Map<String, dynamic> map) {
    BlockType type;
    if (map["type"] == 'unordered-list-item') {
      type = BlockType.unorderedListItem;
    } else {
      type = EnumToString.fromString(BlockType.values, map["type"]);
    }
    return DraftBlock(
      key: map["key"],
      text: map["text"],
      type: type,
      subtype: map["data"]["subType"] == null
          ? null
          : EnumToString.fromString(
              AtomicSubtype.values,
              map["data"]["subType"],
            ),
      depth: map["depth"] ?? 0,
      inlineStyleRanges: map["inlineStyleRanges"] == null
          ? null
          : _InlineStyleRange.getList(map["inlineStyleRanges"]),
      data: (map["data"] as Map).isEmpty
          ? {}
          : map["data"] as Map<String, String>,
      entityRanges: map["entityRanges"] == null
          ? null
          : _EntityRange.getList(
              map["entityRanges"],
            ),
    );
  }
  @override
  String toString() =>
      'type: $type, ${subtype == null ? '' : subtype} key: $key, text: $text';
}

class _InlineStyleRange {
  int offset;
  int length;
  String style;

  bool contains(int index) {
    if ((offset <= index) && (index < (offset + length))) {
      return true;
    }
    return false;
  }

  _InlineStyleRange({this.offset, this.length, this.style});

  static List<_InlineStyleRange> getList(List<dynamic> map) {
    List<_InlineStyleRange> inlineStyleList = List();
    for (int i = 0; i < map.length; i++) {
      inlineStyleList.add(_InlineStyleRange.fromJson(map[i]));
    }
    return inlineStyleList;
  }

  factory _InlineStyleRange.fromJson(Map<String, dynamic> map) =>
      _InlineStyleRange(
          offset: map["offset"] ?? 0,
          length: map["length"] ?? 0,
          style: map["style"]);
}

class _EntityRange {
  int offset;
  int length;
  int key;

  _EntityRange({this.offset, this.length, this.key});

  bool contains(int index) {
    if ((offset <= index) && (index < (offset + length))) {
      return true;
    }
    return false;
  }

  factory _EntityRange.fromJson(Map<String, dynamic> map) => _EntityRange(
      offset: map["offset"] ?? 0,
      length: map["length"] ?? 0,
      key: map["key"] ?? 0);

  static List<_EntityRange> getList(List<dynamic> map) {
    List<_EntityRange> list = List();
    for (int i = 0; i < map.length; i++) {
      list.add(_EntityRange.fromJson(map[i]));
    }
    return list;
  }
}

class _EntityMapData {
  String url;
  String targetOption;

  _EntityMapData({this.url, this.targetOption});

  factory _EntityMapData.fromJson(Map<String, dynamic> map) =>
      _EntityMapData(url: map["url"], targetOption: map["targetOption"]);
}

class EntityMap {
  final String type;
  final String mutability;
  final _EntityMapData data;

  const EntityMap({this.type, this.mutability, this.data});

  static Map<String, EntityMap> getEntityMap(Map<String, dynamic> map) {
    Map<String, EntityMap> _map = Map();
    if (map != null) {
      map.forEach((key, value) =>
          _map.putIfAbsent(key, () => EntityMap.fromJson(value)));
    }
    return _map;
  }

  factory EntityMap.fromJson(Map<String, dynamic> map) => EntityMap(
        type: map["type"],
        mutability: map["mutability"],
        data: _EntityMapData.fromJson(map["data"]),
      );
}

class DraftObject {
  final List<DraftBlock> blocks;
  final Map<String, EntityMap> entityMap;

  const DraftObject({
    @required this.blocks,
    @required this.entityMap,
  })  : assert(blocks != null),
        assert(entityMap != null);

  factory DraftObject.fromJson(Map<String, dynamic> map) {
    assert(map["blocks"] != null);
    assert(map["entityMap"] != null);
    return DraftObject(
      blocks: DraftBlock.getList(map["blocks"]),
      entityMap: (map["entityMap"] as Map).isEmpty
          ? {}
          : EntityMap.getEntityMap(
              map["entityMap"] as Map<String, dynamic>,
            ),
    );
  }
}

enum BlockType {
  unstyled,
  heading1,
  heading2,
  heading3,
  quote,
  callout,
  atomic,
  unorderedListItem,
  testLink,
  textTestLink
}

enum AtomicSubtype { image, youtube, video, audio }
