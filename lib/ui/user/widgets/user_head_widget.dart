import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:order_manager/domain/entities/user/user_entity.dart';

class UserHeadWidget extends StatelessWidget {
  final UserEntity user;
  
  const UserHeadWidget({
    super.key, 
    required this.user,
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
          _UserInformationWidget(
            user: user,
          ),
        ],
      ),
    );
  }
}

class _UserInformationWidget extends StatelessWidget {
  final UserEntity user;

  const _UserInformationWidget({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            user.email,
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