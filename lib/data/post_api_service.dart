import 'package:chopper/chopper.dart';
part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://api-wediina.herokuapp.com')
abstract class PostApiService extends ChopperService{
@Get(path: '/vendor_cat')
 Future<Response> getVendors();

@Get(path: '/vendor_by_cat_id/{_id}')
Future<Response> getVendorcat(@Path('_id') String _id);

@Get(path: '/Vendor_by_id/{_id}')
Future<Response> getVendoer(@Path('_id') String _id);


@Get(path: '/venue_cat')
Future<Response> getVenues();

@Get(path: '/venue_by_cat_id/{_id}')
Future<Response> getVenuecat(@Path('_id') String _id);

@Get(path: '/Venue_by_id/{_id}')
Future<Response> getVenue(@Path('_id') String _id);


static PostApiService create(){
  final client = ChopperClient(
      baseUrl: 'https://api-wediina.herokuapp.com',
     services: [
       _$PostApiService(),

     ],
     converter: JsonConverter(),
  );
  return _$PostApiService(client);

}


}