import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:order_manager/configs/environment_helper.dart';
export 'package:order_manager/configs/injection_container.dart';
export 'package:order_manager/core/datasource/data_source.dart';
export 'package:order_manager/core/datasource/non_relational_datasource.dart';
export 'package:order_manager/core/datasource/relational_datasource.dart';
export 'package:order_manager/core/service/app_service.dart';
export 'package:order_manager/core/service/clock_helper.dart';
export 'package:order_manager/core/service/storage_service.dart';

abstract interface class IFactoryViewModel<T> {
  T create(BuildContext context);
  void dispose(BuildContext context, T viewModel);
}