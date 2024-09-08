import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leadingWidth: 70,
      centerTitle: false,
      title: const Text('Anthony Jones'),
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: const Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            maxRadius: 10,
            foregroundColor: Colors.red,
            backgroundColor: Colors.red,
            backgroundImage: AssetImage('images/profile_avatar.jpg'),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), padding: const EdgeInsets.all(12)),
          child: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), padding: const EdgeInsets.all(12)),
          child: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
