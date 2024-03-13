import 'package:chopper/chopper.dart';
part 'StackListService.chopper.dart';

@ChopperApi(baseUrl: "/2.3/search")
abstract class StackListService extends ChopperService {
  // A helper method that helps instantiating the service. You can omit this method and use the generated class directly instead.
  static StackListService create({ChopperClient? client})=>_$StackListService(client);
  @Get()
  Future<Response> getStackList(
      @Query('tagged') String tagName, @Query('site') String sitename);
}
