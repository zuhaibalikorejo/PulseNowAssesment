import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ServiceInvoker {
  static final ServiceInvoker _instance = ServiceInvoker();

  static ServiceInvoker get INSTANCE => _instance;

  String _endPoint = "";

  Future<dynamic> invoke<Req>(
    String endPoint, {
    Req? inputRequest,
    Map<String, String>? headers,
    ServiceRequestType serviceRequestType = ServiceRequestType.GET,
  }) async {
    _endPoint = endPoint;

    //comment above line and uncomment below two line for SSL disabling for VAPT.
    SecurityContext clientContext = SecurityContext.defaultContext;
    HttpClient client = HttpClient(context: clientContext);

    //HttpClient? client = await getHttpClient().then((client) => client);

    try {
      String url = getUrl(endPoint);

      HttpClientRequest httpClientRequest;
      Uri uri = Uri.parse(url);
      var encodedRequest = jsonEncode(inputRequest);
      var isRequestToBeWritten = true;
      switch (serviceRequestType) {
        case ServiceRequestType.GET:
          httpClientRequest = await client.getUrl(uri);
          isRequestToBeWritten = false;
          break;

        case ServiceRequestType.POST:
          httpClientRequest = await client.postUrl(uri);
          break;

        case ServiceRequestType.PUT:
          httpClientRequest = await client.putUrl(uri);
          break;

        case ServiceRequestType.DELETE:
          httpClientRequest = await client.deleteUrl(uri);
          break;

        case ServiceRequestType.PATCH:
          httpClientRequest = await client.patchUrl(uri);
          break;
      }

      await requestHeaders(httpClientRequest, headers, encodedRequest,
          serviceRequestType, endPoint);
      if (isRequestToBeWritten) {
        httpClientRequest.write(encodedRequest);
      }

      HttpClientResponse httpClientResponse = await httpClientRequest.close();

      final int statusCode = httpClientResponse.statusCode;

      // Read the response body
      String responseBody =
          await httpClientResponse.transform(utf8.decoder).join();

      print("Status Code: $statusCode");
      print("Response Body: $responseBody");

      // Parse JSON response
      dynamic jsonResponse;
      if (responseBody.isNotEmpty) {
        try {
          jsonResponse = jsonDecode(responseBody);
        } catch (e) {
          print("Error parsing JSON: $e");
          jsonResponse = responseBody;
        }
      }

      // Return the response
      return jsonResponse;
    } catch (error) {
      print("Error in service invocation: $error");
      rethrow;
    }
  }

  String getUrl(String endPoint) {
    return "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1";
  }

  Future<void> requestHeaders(
      HttpClientRequest httpClientRequest,
      Map<String, String>? listHeaders,
      String encodedRequest,
      ServiceRequestType requestType,
      String endPoint) async {}
}

enum ServiceRequestType { GET, POST, PUT, PATCH, DELETE }
