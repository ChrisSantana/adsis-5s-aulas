import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsuarioOptionWidget extends StatelessWidget {
  const UsuarioOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _OptionTile(
          icon: FontAwesomeIcons.signsPost, 
          title: 'Endereço',
        ),
        Divider(),
        _OptionTile(
          icon: FontAwesomeIcons.mapLocationDot, 
          title: 'Localização',
        ),
        Divider(),
        _OptionTile(
          icon: FontAwesomeIcons.rightFromBracket, 
          iconColor: Colors.red.shade900,
          title: 'Sair',
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;

  const _OptionTile({
    required this.icon,
    required this.title,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor ?? Colors.grey.shade700,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}