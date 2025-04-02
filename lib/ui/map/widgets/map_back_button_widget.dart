import 'dart:io';
import 'package:order_manager/configs/factory_viewmodel.dart';
import 'package:order_manager/core/widgets/icon_button_circle_widget.dart';

class MapBackButtonWidget extends StatelessWidget {
  const MapBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IconButtonCircleWidget(
        icon: icon,
        onPressed: getIt<IAppService>().navigatePop,
        showShadow: false,
      ),
    );
  }

  IconData get icon {
    if (Platform.isIOS) return Icons.arrow_back_ios_new_rounded;
    return Icons.arrow_back_rounded;
  }
}
