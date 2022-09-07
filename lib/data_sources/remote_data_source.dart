import 'package:untitled04/services/network_service.dart';

abstract class RemoteDataSource {
  Future getData();
}

class RemoteDataSourceApi implements RemoteDataSource {
  final NetworkServices _networkServices;

  RemoteDataSourceApi(
    this._networkServices,
  );

  @override
  Future getData() async {
    return await _networkServices.getRequest("",);
  }
}
