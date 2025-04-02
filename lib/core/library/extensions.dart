import 'package:dio/dio.dart';
import 'package:order_manager/domain/entities/core/http_response_entity.dart';
import 'package:order_manager/domain/error/core/http_exception.dart';
import 'package:order_manager/core/library/constants.dart';

extension NumberParsing on int {
  bool toBool() {
    return this == 1 ? true : false;
  }
}

extension BoolParsing on bool {
  int toInt() {
    return this ? 1 : 0;
  }
}

extension DateTimeExtension on DateTime {
  bool isToday() {
    return DateTime.now().toDate().isAtSameMomentAs(toDate());
  }

  DateTime toDate() {
    return DateTime(year, month, day);
  }

  bool belongCurrentWeek() {
    return DateTime.now().toWeekOfYear() == toWeekOfYear();
  }

  int toWeekOfYear() {
    final int daysToAdd = DateTime.thursday - weekday;
    final DateTime thursdayDate = daysToAdd > 0 ? add(Duration(days: daysToAdd)) : subtract(Duration(days: daysToAdd.abs()));
    final int dayOfYearThursday = _dayOfYear(thursdayDate);
    return 1 + ((dayOfYearThursday - 1) / 7).floor();
  }

  int _dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays;
  }

  DateTime toFirstDateOfTheWeek() {
    return subtract(Duration(days: weekday));
  }

  DateTime toFirstDateOfTheMonth() {
    return DateTime(year, month, 1);
  }

  DateTime toLastDayAndTimeOfTheMonth() {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  DateTime toLastMonths({int subtractMonths = 1, int startDay = 1}) {
    if (subtractMonths < 0) return this;
    return DateTime(year, month - subtractMonths, startDay);
  }

  DateTime toNextMonths({int addMonths = 1, int startDay = 1}) {
    if (addMonths < 0) return this;
    return DateTime(year, month + addMonths, startDay);
  }

  bool isMonday() {
    return weekday == DateTime.monday;
  }

  bool isSameDate(DateTime dateComparsion) {
    return toDate().isAtSameMomentAs(dateComparsion.toDate());
  }

  bool isGreaterOrEqualsThan(DateTime dateComparsion) {
    final bool isSame = isSameDate(dateComparsion);
    final bool isAfter = dateComparsion.toDate().isAfter(toDate());
    return isSame || isAfter;
  }

  bool isLessOrEqualsThan(DateTime dateComparsion) {
    final bool isSame = isSameDate(dateComparsion);
    final bool isBefore = dateComparsion.toDate().isBefore(toDate());
    return isSame || isBefore;
  }

  String toDateSql() {
    final String day = this.day.toString().padLeft(2, '0');
    final String month = this.month.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

extension HttpResponseExtension on HttpResponseEntity? {
  bool toBool() {
    const String success = 'success';
    final bool successHttp = (this?.statusCode ?? 0) >= HttpConstant.kSuccess && (this?.statusCode ?? 0) <= HttpConstant.kSuccessLimit;
    final Map? data = this?.data != null && this!.data is Map && this!.data.containsKey(success) ? this!.data : null;
    return data?[success] ?? successHttp;
  }

  bool toStatusNoContent() {
    return (this?.statusCode ?? 0) == HttpConstant.kSuccessNoContent;
  }

  bool hasStatus(int statusCode) {
    return (this?.statusCode ?? 0) == statusCode;
  }
}

extension HttpExceptionExtension on int? {
  Exception statusToException() {
    if (this == HttpConstant.kExpiredToken) return HttpExpiredTokenException();
    if (this == HttpConstant.kInvalidOperation) return HttpInvalidOperationException();
    if (this == HttpConstant.kNotPermission) return HttpNotPermissionException();
    if (this == HttpConstant.kNotFound) return HttpNotFoundException();
    if (this == HttpConstant.kDefaultError) return HttpError();
    return HttpError();
  }
}

extension HandlerExceptionExtension on Object? {
  Exception toHttpException() {
    if (this is HttpNotFoundException) return this as Exception;
    if (this is HttpNotPermissionException) return this as Exception;
    if (this is HttpInvalidOperationException) return this as Exception;
    if (this is HttpTimeoutException) return this as Exception;
    if (this is HttpInternetConnectionFailure) return this as Exception;
    if (this is HttpExpiredTokenException) return this as Exception;
    return HttpError();
  }

  Object convertDioToHttpException() {
    final Object erroDefault = this ?? HttpError();
    if (this is DioException) {
      switch ((this as DioException).type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return HttpTimeoutException();
        case DioExceptionType.connectionError:
        case DioExceptionType.unknown:
          return HttpInternetConnectionFailure();
        default:
          return erroDefault;
      }
    }
    return erroDefault;
  }
}

extension StringUtil on String {
  String capitalize() {
    if (trim().isEmpty) return this;
    return length == 1 ? toUpperCase() : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String startCase() {
    if (trim().isEmpty) return this;
    final List<String> words = split(' ');
    return words.map<String>((word) {
      if (word.trim().length <= 2) return word.toLowerCase();
      return word.capitalize();
    }).join(' ');
  }

  String firstWord() {
    if (trim().isEmpty) return this;
    return split(' ').first.trim();
  }

  String minify() {
    final String minified = _removeUnnecessarySpace(this);
    return _removeLineBreaksAndTabs(minified);
  }

  String _removeUnnecessarySpace(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ');
  }

  String _removeLineBreaksAndTabs(String text) {
    return text.replaceAll(RegExp(r'\n|\t'), '');
  }
}

extension ParsingStringList on List<String> {
  String get joinPath => join('/');
}

extension ParsingObjectList on List<Object> {
  String toJoinForSqlIn() {
    String joinForSqlIn = '';
    if (isEmpty) return joinForSqlIn;

    String separator = '';
    for (final Object value in this) {
      joinForSqlIn += "$separator'$value'";
      separator = ',';
    }
    return joinForSqlIn;
  }
}
