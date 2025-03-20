import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/core/entity/request_state_entity.dart';
import 'package:order_manager/core/widgets/progress_indicator_widget.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';
import 'package:order_manager/ui/user/view_models/user_factory_viewmodel.dart';
import 'package:order_manager/ui/user/view_models/user_viewmodel.dart';
import 'package:order_manager/ui/user/widgets/usuario_head_widget.dart';
import 'package:order_manager/ui/user/widgets/usuario_option_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserViewModel>(
      create: UserFactoryViewModel().create,
      child: _UserContentWidget(),
    );
  }
}


class _UserContentWidget extends StatelessWidget {
  const _UserContentWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meu Perfil',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserViewModel, IRequestState>(
        builder: (context, state) {
          if (state is RequestInitiationState) return Offstage();
          if (state is RequestProcessingState) return Center(child: ProgressIndicatorWidget());
          if (state is RequestErrorState) return _TryAgainWidget();
          
          final UserEntity? usuario = (state as RequestCompletedState<UserEntity>).value;
          if (usuario == null) _TryAgainWidget();

          return RefreshIndicator.adaptive(
            onRefresh: context.read<UserViewModel>().onRefreshIndicator,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                UsuarioHeadWidget(
                  usuario: usuario!
                ),
                UsuarioOptionWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TryAgainWidget extends StatelessWidget {
  const _TryAgainWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Não foi possível obter o usuário, clique em tentar novamente!'),
        ElevatedButton(
          onPressed: () {}, 
          child: Text('Tentar Novamente'),
        ),
      ],
    );
  }
}