import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_chat_demo/app/config/app_screen_type.dart';
import 'package:simple_chat_demo/app/router/router_app_config.dart';
import 'package:simple_chat_demo/bootstrap.dart';
import 'package:simple_chat_demo/common/constants/themes/theme.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/bottom_sheet/chat_bottom_sheet_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/chat/chat_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/chat_screen/cubit/message/message_cubit.dart';
import 'package:simple_chat_demo/presentation/screens/scan_screen/cubit/scan_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() => const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ScanCubit()),
        BlocProvider(create: (ctx) => ChatCubit()),
        BlocProvider(create: (ctx) => MessageCubit()),
        BlocProvider(create: (ctx) => ChatBottomSheetCubit()),
      ],
      child: ResponsiveApp(
        builder: (context) {
          final mediaSize = MediaQuery.of(context).size;
          final deviceType = getDeviceType(mediaSize);
          Size size;
          switch (deviceType) {
            case DeviceScreenType.desktop:
            case DeviceScreenType.tablet:
              size = const Size(1440, 1024);
            default:
              size = const Size(430, 930);
          }
          AppScreenType().init(deviceType);
          return ScreenUtilInit(
            designSize: size,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: RouterAppConfig().goRouter,
                theme: AppThemes.lightTheme,
              );
            },
          );
        },
      ),
    );
  }
}
