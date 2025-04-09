import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/core/widgets/progress_indicator_widget.dart';
import 'package:order_manager/domain/entities/core/request_state_entity.dart';
import 'package:order_manager/ui/login/view_models/login_viewmodel.dart';
import 'package:order_manager/utils/util_text.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {

  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _loginViewModel = context.read<LoginViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, IRequestState<String>>(
      builder: (context, state) {
        final bool isProcessing = state is RequestProcessingState;
        return Form(
          child: Column(
            children: [
              TextFormField(
                enabled: !isProcessing,
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: UtilText.labelLoginYourEmail,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  enabled: !isProcessing,
                  controller: _passwordTextController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: UtilText.labelLoginYourPassword,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.lock),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: onAuthentication,
                  child: !isProcessing ? Text(
                    UtilText.labelLoginTitle.toUpperCase(),
                  ) : ProgressIndicatorWidget(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onAuthentication() {
    _loginViewModel.onAuthentication(_emailTextController.text, _passwordTextController.text);
  }
}
