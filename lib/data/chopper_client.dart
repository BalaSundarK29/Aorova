import 'package:bala_task/data/StackListService.dart';
import 'package:chopper/chopper.dart';

class AppChopperClient {
  late ChopperClient _client;
  AppChopperClient() {
    createChopperClient();
  }

  T getChopperService<T extends StackListService>() {
    return _client.getService<T>();
  }

  void createChopperClient() {
    _client = ChopperClient(
        baseUrl: Uri.parse("https://api.stackexchange.com"),
        services: [
          StackListService.create(),     
        ],
        converter: const JsonConverter());
  }
}