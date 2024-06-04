import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/social_cubit.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, const NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.paperUpload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
