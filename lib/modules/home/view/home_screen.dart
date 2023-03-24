import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skype/core/repository/app_repository/app_repository_impl.dart';
import 'package:skype/core/utils/app_color.dart';
import 'package:skype/core/utils/functions/size_config.dart';
import 'package:skype/modules/home/controller/home_cubit.dart';
import '../../../core/services/server_locator.dart';
import '../../chats/cubit/chat_cubit.dart';
import '../../search/view/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) =>
          ChatCubit(appRepositoryImpl: sl.get<AppRepositoryImpl>())
            ..getUserdata()
            ..getFrinds(),
      child: BlocProvider(
        create: (context) =>
            HomeCubit(appRepositoryImpl: sl.get<AppRepositoryImpl>())
              ..getUserData(context),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final controller = HomeCubit.get(context);
            return Scaffold( 
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.white,
                    ),
                  )
                ],
                leading: IconButton(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.bell,
                    color: Colors.white,
                  ),
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [AppColor.primary, AppColor.secondry])),
                ),
                centerTitle: true,
                title: controller.appBarHead.isEmpty
                    ? CircleAvatar(
                        backgroundColor: AppColor.primary,
                      )
                    : controller.appBarHead[controller.selectedIndex],
              ),
              body: Stack(
                children: [
                  controller.pages[controller.selectedIndex],
                  Positioned(
                    bottom: 10,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: getWidth(35)),
                      width: getWidth(300),
                      height: getHeight(70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColor.primary.withOpacity(.85),
                              AppColor.secondry.withOpacity(.85)
                            ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.selectedIndex == 0
                                    ? AppColor.secondry
                                    : Colors.transparent),
                            child: IconButton(
                              onPressed: () {
                                controller.changePage(0);
                              },
                              icon: Icon(
                                Icons.home,
                                size: getWidth(25),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              controller.changePage(1);
                            },
                            backgroundColor: controller.selectedIndex == 1
                                ? const Color.fromARGB(255, 208, 155, 177)
                                : Colors.white,
                            shape: const CircleBorder(),
                            child: Icon(
                              Icons.phone,
                              color: controller.selectedIndex == 1
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.selectedIndex == 2
                                    ? AppColor.primary
                                    : Colors.transparent),
                            child: IconButton(
                                onPressed: () {
                                  controller.changePage(2);
                                },
                                icon: Icon(
                                  Icons.contact_phone_outlined,
                                  color: controller.selectedIndex == 2
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(255, 0, 0, 0),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
