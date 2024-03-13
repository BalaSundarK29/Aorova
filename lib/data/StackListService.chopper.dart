// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StackListService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$StackListService extends StackListService {
  _$StackListService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = StackListService;

  @override
  Future<Response<dynamic>> getStackList(
    String tagName,
    String sitename,
  ) {
    final Uri $url = Uri.parse('/2.3/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tagged': tagName,
      'site': sitename,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
