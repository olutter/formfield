part of '../formfield.dart';

/// Int form field.
class IntFormField extends FormField<int> {
  IntFormField({
    Key? key,
    required this.onChanged,
    InputDecoration? decoration,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    int? initialValue,
    FormFieldSetter<int>? onSaved,
    String? restorationId,
    FormFieldValidator<int>? validator,
  }) : super(
          key: key,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          onSaved: onSaved,
          restorationId: restorationId,
          validator: validator,
          builder: (state) {
            return TextFormField(
              decoration: decoration,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.number,
              initialValue: initialValue?.toString(),
              onChanged: (v) {
                final value = int.tryParse(v);
                state.didChange(value);
              },
              validator: (v) {
                return validator?.call(null);
              },
            );
          },
        );

  final void Function(int? v) onChanged;

  @override
  FormFieldState<int> createState() => _IntFormFieldState();
}

class _IntFormFieldState extends FormFieldState<int> {
  IntFormField get _formField => widget as IntFormField;

  @override
  void didChange(int? value) {
    super.didChange(value);
    _formField.onChanged(value);
  }

  @override
  void didUpdateWidget(IntFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }

  @override
  void reset() {
    super.reset();
    _formField.onChanged(value);
  }
}
