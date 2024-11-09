import 'dart:io';

import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/utils/extensions/extensions_media_query.dart';
import 'package:base_flutter_bloc/presentation/app/go_routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/common/constants.dart';
import '../bloc/detail_bloc.dart';

class UpdateUserModalBottomSheet extends StatefulWidget {
  final UserModel user;

  const UpdateUserModalBottomSheet({
    super.key,
    required this.user,
  });

  @override
  State<UpdateUserModalBottomSheet> createState() =>
      _UpdateUserModalBottomSheetState();
}

class _UpdateUserModalBottomSheetState
    extends State<UpdateUserModalBottomSheet> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.user.name ?? '';
    _emailController.text = widget.user.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DetailBloc>().state;
    final croppedFile = state.croppedFile;

    return Padding(
      padding: EdgeInsets.only(bottom: context.mediaQuery.viewInsets.bottom),
      child: Container(
        height: context.mediaQuery.size.height * 0.5,
        color: Colors.grey,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Stack(
                children: [
                  croppedFile == null
                      ? CachedNetworkImage(
                          imageUrl:
                              "${Constants.baseImageUrl}${widget.user.image}",
                          imageBuilder: (_, imageProvider) => Container(
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
                        )
                      : Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.file(
                              File(croppedFile.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {
                          context.read<DetailBloc>().add(DetailEvent.pickImage());
                        },
                        child: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const Spacer(),
              BlocListener<DetailBloc, DetailState>(
                listener: (context, state) {
                  if (state.isSuccessUpdateUser) {
                    context.pop(true);
                  }
                  if (state.errorUpdateUser != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorUpdateUser!.message),
                      ),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    final email = _emailController.text;

                    context.read<DetailBloc>().add(
                        DetailEvent.updateUser(widget.user.id!, name, email));
                  },
                  child: const Text('Update Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
