import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/market_place/login/controller/login_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_button.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/repositories/data_authentication_repository.dart';

class LoginPhonePage extends View {
  const LoginPhonePage({Key? key}) : super(key: key);

  @override
  LoginPhoneView createState() => LoginPhoneView();
}

class LoginPhoneView extends ViewState<LoginPhonePage, LoginController> {
  LoginPhoneView() : super(LoginController(DataAuthenticationRepository()));

  @override
  Widget get view => Scaffold(
      key: globalKey,
      body: SafeArea(
        child: loginBody,
    )
  );

  Widget get loginBody => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bannerImage,
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpacer(20),
              welcomeText,
              vSpacer(20),
              usernameField,
              vSpacer(20),
              passwordField,
              vSpacer(10),
              forgotPassword,
              vSpacer(20),
              loginButton
            ],
          ),
        )
      ],
    ),
  );

  Widget vSpacer(double height) => SizedBox(
    height: height,
  );

  Widget get bannerImage => SizedBox(
    width: double.infinity,
    child: FadeInImage(
      fit: BoxFit.fill,
      placeholder: const AssetImage(
        Resources.login_banner,
      ),
      image: const AssetImage(
        Resources.login_banner,
      ),
      imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          Resources.login_banner,
          width: double.infinity,
          height: 250,
        );
      },
    ),
  );

  Widget get welcomeText => CustomText(
      textName: Constants.welecome,
      textAlign: TextAlign.left,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      textColor: AppColor.black_color
  );

  get textFieldBorder => OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.grey_color_500,
    ),
    borderRadius: BorderRadius.circular(10)
  );

  Widget get usernameField => ControlledWidgetBuilder(builder: (BuildContext ctx, LoginController controller){
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintText: Constants.user_name,
        border: textFieldBorder,
        focusedBorder: textFieldBorder,
        enabledBorder: textFieldBorder
      ),
      obscureText: false,
      textInputAction: TextInputAction.next,
    );
  });

  Widget get passwordField => ControlledWidgetBuilder(builder: (BuildContext ctx, LoginController controller){
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        focusedBorder: textFieldBorder,
        enabledBorder: textFieldBorder,
        border: textFieldBorder,
        hintText: Constants.password,
        suffixIcon: IconButton(
          icon: Icon(controller.isPassVisible ? Icons.visibility : Icons.visibility_off, size: 20,),
          onPressed: ()=> controller.updateVisibility(),
        ),
      ),
      obscureText: controller.isPassVisible,
      textInputAction: TextInputAction.done,
    );
  });

  Widget get forgotPassword => GestureDetector(
    child: CustomText(
      textName: Constants.forgot_password,
      textAlign: TextAlign.left,
      fontSize: 13,
      fontWeight: FontWeight.bold,
      textColor: AppColor.blue_accent,
    ),
  );

  Widget get loginButton => CustomButton(
    onTapAction: () => {
      Future.delayed(const Duration(microseconds: 500),() {
        navigateToDashboardScreen(context, 0);
      }),
    },
    buttonName: const Text(Constants.login),
    borderColor: AppColor.blue_color,
    fillColor: AppColor.blue_color,
    textColor: AppColor.white_color,
    height: 50,
    width: MediaQuery.of(context).size.width,
  );
}
