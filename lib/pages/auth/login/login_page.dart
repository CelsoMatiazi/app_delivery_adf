import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinha_burguer/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinha_burguer/core/ui/widgets/delivery_button.dart';
import 'package:vakinha_burguer/pages/auth/login/login_controller.dart';
import 'package:vakinha_burguer/pages/auth/login/login_state.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/base_state/base_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {



  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state){
        state.status.matchAny(
            any: () => hideLoader(),
            login: () => showLoader(),
            loginError: (){
              hideLoader();
              showError("Login ou senha invalidos!");
            },
            error: (){
              hideLoader();
              showError("Erro ao realizar login!");
            },
            success: (){
              hideLoader();
              Navigator.pop(context, true);
            }
        );
      },
      child: Scaffold(

        appBar: DeliveryAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Login", style: context.textStyles.textTitle,),

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
                        ]),
                      ),

                      const SizedBox(height: 50,),

                      Center(
                        child: DeliveryButton(
                          width: double.infinity,
                          label: "ENTRAR",
                          onPressed: (){

                              final valid = _formKey.currentState?.validate() ?? false;
                              if(valid){
                                controller.login(_emailCtrl.text, _passwordCtrl.text);
                              }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não possui uma conta", style: context.textStyles.textBold,),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/register');
                          },
                          child: Text('Cadastre-se', style: context.textStyles.textBold.copyWith(color: Colors.blue),)
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
