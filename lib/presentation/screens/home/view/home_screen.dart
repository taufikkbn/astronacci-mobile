import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/common/constants.dart';
import '../../../../core/utils/di/injector.dart';
import '../../../app/go_routes.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget screen(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector<HomeBloc>()..add(const HomeEvent.fetchUser()),
        ),
      ],
      child: const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<HomeBloc>().add(HomeEvent.logout());
              context.goNamed(Routes.login);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchUsers(reset: true);
        },
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: (value) {
                _fetchUsers(reset: true, search: value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {},
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    // if (state.isLoading) {
                    //   return Center(child: const CircularProgressIndicator());
                    // }
                    if (state.userError != null) {
                      return Text(state.userError!.message);
                    }
                    if (state.userData.isEmpty) {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: state.hasReachedMax
                          ? state.userData.length
                          : state.userData.length + 1,
                      itemBuilder: (context, index) {
                        return index >= state.userData.length
                            ? const Center(
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              )
                            : _itemView(state.userData[index]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemView(UserModel user) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.detail,
          queryParameters: {
            'id': user.id.toString(),
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: "${Constants.baseImageUrl}${user.image}",
              imageBuilder: (context, imageProvider) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(user.name.toString()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    injector<HomeBloc>().close();

    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _fetchUsers();
    }
  }

  void _fetchUsers({bool reset = false, String? search}) {
    final bloc = context.read<HomeBloc>();
    final currentState = bloc.state;

    if (reset) {
      print("cuaks : ${search}");
      bloc.add(HomeEvent.fetchUser(
        search: search ?? '',
        page: 1,
        isNewSearch: true,
      ));
    } else if (!currentState.isLoading && !currentState.hasReachedMax) {
      bloc.add(HomeEvent.fetchUser(
        search: search ?? _searchController.text,
        page: currentState.page,
        isNewSearch: false,
      ));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
