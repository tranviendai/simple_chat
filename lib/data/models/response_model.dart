import 'package:simple_chat_demo/data/models/model_type_model.dart';

class ResponseModel {
  final String response;
  final ModelTypeModel type; // Type of model used for generating the response

  ResponseModel({required this.response, required this.type});
}
