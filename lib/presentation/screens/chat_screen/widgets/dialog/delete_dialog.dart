import 'package:flutter/material.dart';
import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';

class DeleteDialog extends StatelessWidget {
  final VoidCallback onDelete;
  const DeleteDialog({required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
      backgroundColor: AppColorScheme.blackSwatch[900],
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure to delete?',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              'The conservation will not be existed if you proceed this action',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w400),
            ),
            const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
                  backgroundColor: WidgetStatePropertyAll(AppColorScheme.primarySwatch),
                ),
                onPressed: () {
                  context.pop();
                  onDelete();
                },
                child: Text(
                  'OK',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
                  backgroundColor: WidgetStatePropertyAll(AppColorScheme.whiteSwatch[100]),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'No',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
