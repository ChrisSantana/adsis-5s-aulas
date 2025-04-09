import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/configs/assets_helper.dart';
import 'package:order_manager/ui/login/view_models/login_factory_viewmodel.dart';
import 'package:order_manager/ui/login/view_models/login_viewmodel.dart';
import 'package:order_manager/ui/login/widgets/login_form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: LoginFactoryViewModel().create,
      child: _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  const _LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _TopImageWidget(),
          _BottomImageWidget(),
          _ContentLoginWidget(),
        ],
      ),
    );
  }
}

class _TopImageWidget extends StatelessWidget {
  const _TopImageWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Image.asset(
        AssetsHelper.assetsLoginTop, 
        width: MediaQuery.sizeOf(context).width * 0.36,
      ),
    );
  }
}

class _BottomImageWidget extends StatelessWidget {
  const _BottomImageWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Image.asset(
        AssetsHelper.assetsLoginBottom, 
        width: MediaQuery.sizeOf(context).width * 0.36,
      ),
    );
  }
}

class _ContentLoginWidget extends StatelessWidget {
  const _ContentLoginWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
      child: Column(
        spacing: 60,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            AssetsHelper.assetsLoginIcon,
            height: MediaQuery.sizeOf(context).height * 0.3,
          ),
          LoginFormWidget(),
        ],
      ),
    );
  }
}