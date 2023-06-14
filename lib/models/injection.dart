import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:my_chatgpt/services/chatgpt_service.dart';
import 'package:uuid/uuid.dart';

final chatgpt = ChatGptService();

final uuid = Uuid();

//日志输出
final logger = Logger(
  level: kDebugMode ? Level.verbose : Level.info,
);
