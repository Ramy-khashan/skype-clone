import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/widget/app_text_field.dart';
import '../../../core/widget/loading_item.dart';
import '../../home/view/home_screen.dart';
import '../controller/search_cubit.dart';
import 'widgets/handle_view.dart';

import '../../../core/repository/search_repository/search_repository_impl.dart';
import '../../../core/services/server_locator.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/functions/size_config.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
        return true;
      },
      child: BlocProvider(
        create: (context) =>
            SearchCubit(searchRepositoryImpl: sl.get<SearchRepositoryImpl>())
              ..getUserBySearch(),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            final controller = SearchCubit.get(context);
            return GestureDetector(
              onTap: () {
                FocusScopeNode focusScopeNode = FocusScope.of(context);
                if (!focusScopeNode.hasPrimaryFocus) {
                  return focusScopeNode.unfocus();
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [AppColor.primary, AppColor.secondry])),
                  ),
                  centerTitle: true,
                  title: Text(
                    "Search",
                    style: TextStyle(
                        fontSize: getFont(32),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  bottom: PreferredSize(
                      preferredSize: Size(double.infinity, getHeight(70)),
                      child: AppTextField(
                        controller: controller.searchController,
                        onChange: (value) {
                          controller.onChangeTextSearch(value);
                        },
                        onValidate: (value) {},
                        hint: "Write frind name..",
                      )),
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    controller.searchController.clear();
                    await controller.getUserBySearch();
                  },
                  child: controller.isLoadingUsers
                      ? const LoadingItem()
                      : (controller.searchedUser.isEmpty &&
                              !controller.isSuceesAndEmpty)
                          ? const HandleViewItem(
                              icon: FontAwesomeIcons.magnifyingGlass,
                              head: "Start Search")
                          // : controller.isFailed
                          //     ? const HandleViewItem(
                          //         icon: FontAwesomeIcons.triangleExclamation,
                          //         head: "Something went wrong, Please try again!")
                          : (controller.isSuceesAndEmpty)
                              ? const HandleViewItem(
                                  icon: FontAwesomeIcons.magnifyingGlassPlus,
                                  head: "No user with this name.. ")
                              : ListView.builder(
                                  padding: EdgeInsets.only(top: getHeight(6)),
                                  itemCount: controller.searchedUser.length,
                                  itemBuilder: (context, index) => Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        foregroundImage: NetworkImage(controller
                                            .searchedUser[index].image!),
                                      ),
                                      title: Text(
                                          controller.searchedUser[index].name!),
                                      onTap: controller.userFriend.contains(
                                              controller
                                                  .searchedUser[index].userid!)
                                          ? () {}
                                          : () {
                                              controller.addFrind(
                                                  name: controller
                                                      .searchedUser[index]
                                                      .name!,
                                                  reciverId: controller
                                                      .searchedUser[index]
                                                      .userid!,
                                                  context: context);
                                            },
                                      trailing: controller.userFriend.contains(
                                              controller
                                                  .searchedUser[index].userid!)
                                          ? const SizedBox.shrink()
                                          : const Icon(
                                              Icons.person_add_alt_1_outlined),
                                    ),
                                  ),
                                ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
