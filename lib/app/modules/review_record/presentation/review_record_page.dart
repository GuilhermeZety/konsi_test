import 'package:easy_mask/easy_mask.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/extensions/context_extension.dart';
import 'package:konsi_test/app/core/common/extensions/widget/widget_extension.dart';
import 'package:konsi_test/app/core/common/utils/toasting.dart';
import 'package:konsi_test/app/core/shared/models/address_model.dart';
import 'package:konsi_test/app/modules/review_record/presentation/cubit/review_record_cubit.dart';
import 'package:konsi_test/app/ui/components/button.dart';

class ReviewRecordPage extends StatefulWidget {
  const ReviewRecordPage({super.key, required this.address});

  final AddressModel address;

  @override
  State<ReviewRecordPage> createState() => _ReviewRecordPageState();
}

class _ReviewRecordPageState extends State<ReviewRecordPage> {
  ReviewRecordCubit cubit = ReviewRecordCubit();

  @override
  void initState() {
    super.initState();
    cubit.initialize(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Revisão'),
      ),
      body: BlocConsumer<ReviewRecordCubit, ReviewRecordState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ReviewRecordError) {
            Toasting.error(
              context,
              title: state.title,
              description: state.description,
            );
          }

          if (state is ReviewRecordCreated) {
            Toasting.success(
              context,
              title: 'Registro criado com sucesso',
              description: 'Você ja pode conferir em sua caderneta',
            );
            Modular.to.pop(true);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: context.colorScheme.secondaryContainer,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: SeparatedColumn(
                        separatorBuilder: () => const Gap(24),
                        children: [
                          _formInput(
                            'CEP',
                            cubit.cepController,
                            keyboardType: TextInputType.number,
                            isRequired: true,
                            minLength: 9,
                            formatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              TextInputMask(
                                mask: '99999-999',
                              ),
                            ],
                            hint: 'Insira aqui o CEP da residência',
                          ),
                          _formInput(
                            'Endereço',
                            cubit.addressController,
                            isRequired: true,
                            hint: 'Insira aqui o endereço da residência',
                          ),
                          _formInput(
                            'Número',
                            cubit.numberController,
                            keyboardType: TextInputType.number,
                            hint: 'Insira aqui o número da residência, se houver',
                          ),
                          _formInput(
                            'Complemento',
                            cubit.complementController,
                            hint: 'Insira aqui o complemento da residência, se houver',
                          ),
                        ],
                      ),
                    ).expanded(),
                    Button(
                      onPressed: cubit.createRecord,
                      child: const Text('Confirmar'),
                    ).expandedH(),
                  ],
                ),
              ),
            ).hero('hero-review-record'),
          );
        },
      ),
    );
  }

  Widget _formInput(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = false,
    int? minLength,
    List<TextInputFormatter>? formatter,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      inputFormatters: formatter,
      validator: !isRequired
          ? null
          : (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo é obrigatório';
              }

              if (minLength != null && value.length < minLength) {
                return 'Este campo deve ter pelo menos $minLength caracteres';
              }
              return null;
            },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey_500,
          ),
        ),
      ),
    );
  }
}
