import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';

class UsuarioHeadWidget extends StatelessWidget {
  final UserEntity usuario;
  
  const UsuarioHeadWidget({
    super.key, 
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 60,
            child: Icon(
              FontAwesomeIcons.solidCircleUser,
              color: Colors.white,
              size: 114,
            ),
          ),
          _UsuarioInformationWidget(
            usuario: usuario,
          ),
        ],
      ),
    );
  }
}

class _UsuarioInformationWidget extends StatelessWidget {
  final UserEntity usuario;

  const _UsuarioInformationWidget({
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          usuario.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            usuario.email,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _onPressedEditButton, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text(
            'Editar o perfil',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _onPressedEditButton() {
    /// None
  }
}