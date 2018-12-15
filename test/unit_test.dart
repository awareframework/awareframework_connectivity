import 'package:test/test.dart';

import 'package:awareframework_connectivity/awareframework_connectivity.dart';

void main(){
  test("test sensor config", (){
    var config = ConnectivitySensorConfig();
    expect(config.debug, false);
  });
}