import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

/// A customizable modal dialog widget with a title, description, optional icon,
/// and action buttons.
///
/// This modal follows the Stoyco design system with rounded corners, borders,
/// and responsive padding that adapts to different screen sizes. The modal
/// automatically sizes itself based on its content.
///
/// The modal includes:
/// * An optional icon at the top
/// * A title displayed in bold
/// * A description with centered text
/// * Up to two action buttons at the bottom (cancel and confirm)
///
/// This widget can be displayed using either Flutter's [showDialog] or GetX's
/// [Get.dialog].
///
/// Example usage with [showDialog] and both actions:
/// ```dart
/// showDialog(
///   context: context,
///   barrierDismissible: false,
///   builder: (context) => CustomModal(
///     title: 'Confirm Action',
///     description: 'Are you sure you want to proceed?',
///     icon: Icon(Icons.warning),
///     cancelActionLabel: 'CANCEL',
///     cancelAction: () => Navigator.pop(context),
///     confirmActionLabel: 'CONFIRM',
///     confirmAction: () {
///       // Perform action
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
///
/// Example usage with [Get.dialog] and only confirm action:
/// ```dart
/// Get.dialog<void>(
///   barrierDismissible: false,
///   CustomModal(
///     title: 'Contraseña Actualizada',
///     description: 'Ahora puedes ingresar a tu cuenta con tu nueva contraseña',
///     confirmAction: () {
///       Get.offAllNamed<void>(AppRoutes.login);
///     },
///     confirmActionLabel: 'INICIAR SESIÓN',
///   ),
/// );
/// ```
class CustomModal extends StatelessWidget {
  /// Creates a custom modal dialog.
  ///
  /// The [title] and [description] are required and will be displayed in the
  /// modal's content area.
  ///
  /// The [icon] is optional and will be displayed at the top of the modal.
  /// If not provided, no icon will be shown.
  ///
  /// The [cancelAction] and [cancelActionLabel] control the left action button.
  /// If [cancelAction] is null, the cancel button will not be shown.
  /// If [cancelActionLabel] is null, it defaults to 'CANCELAR'.
  ///
  /// The [confirmAction] and [confirmActionLabel] control the right action button.
  /// If [confirmActionLabel] is null, it defaults to 'VOLVER A ENVIAR'.
  const CustomModal({
    super.key,
    required this.title,
    this.description,
    this.customDescription,
    this.cancelActionLabel,
    this.cancelAction,
    this.confirmActionLabel,
    this.confirmAction,
    this.icon,
  });

  /// The title text displayed at the top of the modal.
  final String title;

  /// The description text displayed below the title.
  final String? description;

  /// Use this field to provide a custom widget for the description area, replacing the default text description.
  final Widget? customDescription;

  /// The label for the cancel button.
  ///
  /// Defaults to 'CANCELAR' if not provided.
  final String? cancelActionLabel;

  /// The callback executed when the cancel button is tapped.
  ///
  /// If null, the cancel button will not be shown.
  final VoidCallback? cancelAction;

  /// The label for the confirm button.
  ///
  /// Defaults to 'VOLVER A ENVIAR' if not provided.
  final String? confirmActionLabel;

  /// The callback executed when the confirm button is tapped.
  final VoidCallback? confirmAction;

  /// An optional icon widget displayed at the top of the modal.
  ///
  /// If null, no icon will be shown.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final double verticalPadding = context.layout.value(xs: 32, md: 36, lg: 42);
    final double horizontalPadding = context.layout.value(
      xs: 28,
      md: 32,
      lg: 34,
    );

    return Center(
      child: Padding(
        padding: StoycoScreenSize.symmetric(context, horizontal: 21),
        child: Container(
          decoration: BoxDecoration(
            color: ColorFoundation.background.saLight,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
                child: Column(
                  children: Gutter.separateChildren(
                    children: <Widget>[
                      icon ?? const SizedBox.shrink(),
                      Text(
                        title,
                        style: FontFoundation.title.bold25saDark,
                        textAlign: TextAlign.center,
                      ),
                      customDescription ??
                          Text(
                            description ?? '',
                            textAlign: TextAlign.center,
                            style: FontFoundation.paragraph.medium16saDark,
                          ),
                    ],
                    extent: 20,
                  ),
                ),
              ),
              Container(
                height: 65,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: ColorFoundation.border.saDark,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    if (cancelAction != null)
                      Expanded(
                        child: _ModalButton(
                          onTap: cancelAction,
                          label: cancelActionLabel ?? 'CANCELAR',
                          textStyle: FontFoundation.label.semiBold15saError,
                        ),
                      ),
                    if (cancelAction != null)
                      Container(width: 1, color: ColorFoundation.border.saDark),
                    Expanded(
                      child: _ModalButton(
                        onTap: confirmAction,
                        label: confirmActionLabel ?? 'VOLVER A ENVIAR',
                        textStyle: FontFoundation.label.semiBold15saDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// An internal button widget used in the modal's action bar.
class _ModalButton extends StatelessWidget {
  const _ModalButton({
    required this.onTap,
    required this.label,
    required this.textStyle,
  });

  /// The callback executed when the button is tapped.
  final VoidCallback? onTap;

  /// The text label displayed on the button.
  final String label;

  /// The text style applied to the label.
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(child: Text(label, style: textStyle)),
    );
  }
}
