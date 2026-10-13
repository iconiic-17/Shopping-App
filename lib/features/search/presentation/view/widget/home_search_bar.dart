import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/widgets/custom_text_form_field.dart';
import 'package:shopping_app/features/search/presentation/view_model/search_cubit.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        hintText: 'Search products',
        prefixIcon: const Icon(Icons.search),
        action: TextInputAction.search,
        onChanged: context.read<SearchCubit>().onQueryChanged,
      ),
    );
  }
}
