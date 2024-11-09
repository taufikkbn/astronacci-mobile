
import 'package:base_flutter_bloc/presentation/screens/detail_user/widget/update_user_modal_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/common/constants.dart';
import '../../../../core/utils/di/injector.dart';
import '../bloc/detail_bloc.dart';

class DetailScreen extends StatefulWidget {
  final String? userId;

  const DetailScreen({
    super.key,
    required this.userId,
  });

  static Widget screen(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector<DetailBloc>()
            ..add(DetailEvent.started(
              state.uri.queryParameters['id'] ?? '',
            )),
          lazy: false,
        ),
      ],
      child: DetailScreen(
        userId: state.uri.queryParameters['id'],
      ),
    );
  }

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail User')),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: BlocBuilder<DetailBloc, DetailState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state.userError != null) {
                    return Text(state.userError!.message);
                  }
                  if (state.userData != null) {
                    final user = state.userData!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 64),
                        CachedNetworkImage(
                          imageUrl: "${Constants.baseImageUrl}${user.image}",
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (_, __) => CircularProgressIndicator(),
                          errorWidget: (_, __, error) => Container(
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
                        const SizedBox(height: 16),
                        Text(user.name.toString()),
                        const SizedBox(height: 16),
                        Text(user.email.toString()),
                        const SizedBox(height: 64),
                        ElevatedButton(
                          onPressed: () async{
                            context.read<DetailBloc>().add(DetailEvent.clearImage());
                            final result = await showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: context.watch<DetailBloc>(),
                                child: UpdateUserModalBottomSheet(user: user),
                              ),
                            );

                            if (result == true && context.mounted) {
                              context.read<DetailBloc>().add(DetailEvent.started(widget.userId!));
                            }
                          },
                          child: const Text('Update Profile'),
                        )
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    injector<DetailBloc>().close();

    super.dispose();
  }
}
