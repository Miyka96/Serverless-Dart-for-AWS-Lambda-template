// ignore_for_file: prefer_function_declarations_over_variables
import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:serverless-dart-template/handlers/api/api_test.dart';

void main() async {
  Runtime()
    ..registerHandler<AwsApiGatewayEvent>("main.status", status)
    ..invoke();
}
