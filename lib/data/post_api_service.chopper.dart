// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiService;

  @override
  Future<Response> getVendors() {
    final $url = 'https://api-wediina.herokuapp.com/vendor_cat';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getVendorcat(String _id) {
    final $url = 'https://api-wediina.herokuapp.com/vendor_by_cat_id/$_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getVendoer(String _id) {
    final $url = 'https://api-wediina.herokuapp.com/Vendor_by_id/$_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getVenues() {
    final $url = 'https://api-wediina.herokuapp.com/venue_cat';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getVenuecat(String _id) {
    final $url = 'https://api-wediina.herokuapp.com/venue_by_cat_id/$_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response> getVenue(String _id) {
    final $url = 'https://api-wediina.herokuapp.com/Venue_by_id/$_id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
