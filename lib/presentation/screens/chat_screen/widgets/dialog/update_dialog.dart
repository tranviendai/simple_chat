import 'package:flutter/material.dart';
import 'package:simple_chat_demo/app/router/router_app_name.dart';
import 'package:simple_chat_demo/common/constants/themes/color_scheme.dart';
import 'package:simple_chat_demo/common/utils/form_validation_helper.dart';

class UpdateDialog extends StatefulWidget {
  final Function(String) onUpdate;
  const UpdateDialog({required this.onUpdate, super.key});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8)),
      backgroundColor: AppColorScheme.blackSwatch[900],
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 30),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              right: -14,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.close_rounded, color: Colors.white),
              ),
            ),
            Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(),
                Text(
                  'Rename Chat',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(),
                TextField(
                  controller: _controller,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: AppColorScheme.whiteSwatch[100],
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                    isDense: true,
                    hintText: 'Greeting and Assistance Request',
                    hintStyle: const TextStyle(color: Colors.white54),
                  ),
                ),
                if (FormValidationHelper.validateMessage(_controller.text) != null)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      FormValidationHelper.validateMessage(_controller.text)!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
                    ),
                  ),
                const SizedBox(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      backgroundColor: WidgetStatePropertyAll(
                        _controller.text.isNotEmpty &&
                                FormValidationHelper.validateMessage(_controller.text) == null
                            ? AppColorScheme.primarySwatch
                            : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      if (_controller.text.isNotEmpty &&
                          FormValidationHelper.validateMessage(_controller.text) == null) {
                        context.pop();
                        widget.onUpdate(_controller.text);
                      }
                    },
                    child: Text(
                      'Save',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
