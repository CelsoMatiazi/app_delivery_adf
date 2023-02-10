
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burguer/pages/auth/register/register_controller.dart';
import 'package:vakinha_burguer/pages/auth/register/register_state.dart';
import 'package:validatorless/validatorless.dart';
import '../../../core/ui/base_state/base_state.dart';
import '../../../core/ui/widgets/delivery_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state){
        state.status.matchAny(
            any: () => hideLoader(),
            register: () => showLoader(),
            error: (){
              hideLoader();
              showError("Erro aoregistrar usuario");
            },
            success: (){
              hideLoader();
              showSuccess("Cadastro realizado comsucesso");
              Navigator.pop(context);
            }
        );
      },
      child : Scaffold(
                appBar: DeliveryAppBar(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Cadastro", style: context.textStyles.textTitle,),
                          const SizedBox(height: 20,),
                          Text("Preencha os campos abaixo para criar o seu cadastro",
                            style: context.textStyles.textMedium.copyWith(fontSize: 18),
                          ),

                          const SizedBox(height: 30,),

                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(labelText: "Nome"),
                            validator: Validatorless.required('Nome Obrigatorio'),
                          ),

                          const SizedBox(height: 30,),

                          TextFormField(
                            controller: _emailCtrl,
                            decoration: const InputDecoration(labelText: "E-mail"),
                            validator: Validatorless.multiple([
                              Validatorless.required('Email Obrigatorio'),
                              Validatorless.email('Email inválido'),
                            ]),
                          ),

                          const SizedBox(height: 30,),

                          TextFormField(
                            controller: _passwordCtrl,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: "Senha"),
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha Obrigatoria'),
                              Validatorless.min(6, 'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                          ),

                          const SizedBox(height: 30,),

                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(labelText: "Confirma senha"),
                            validator: Validatorless.multiple([
                              Validatorless.required('Confirma Senha Obrigatoria'),
                              Validatorless.compare(_passwordCtrl, "Senhas não conferem"),
                            ]),
                          ),

                          const SizedBox(height: 30,),

                          Center(
                            child: DeliveryButton(
                              width: double.infinity,
                              label: "CADASTRAR",
                              onPressed: (){
                                final valid = _formKey.currentState?.validate() ?? false;
                                if(valid){
                                  controller.register(
                                      _nameCtrl.text,
                                      _emailCtrl.text,
                                      _passwordCtrl.text
                                  );
                                }

                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
      )

    );
  }
}
