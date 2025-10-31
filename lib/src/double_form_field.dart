part of '../formfield.dart';

/// Double form field.
class DoubleFormField extends FormField<double> {
  DoubleFormField({
    Key? key,
    required this.onChanged,
    InputDecoration? decoration,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    double? initialValue,
    FormFieldSetter<double>? onSaved,
    String? restorationId,
    FormFieldValidator<double>? validator,
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
                final value = double.tryParse(v);
                state.didChange(value);
              },
              validator: (v) {
                return validator?.call(null);
              },
            );
          },
        );

  final void Function(double? v) onChanged;

  @override
  FormFieldState<double> createState() => _DoubleFormFieldState();
}

class _DoubleFormFieldState extends FormFieldState<double> {
  DoubleFormField get _formField => widget as DoubleFormField;

  @override
  void didChange(double? value) {
    super.didChange(value);
    _formField.onChanged(value);
  }

  @override
  void didUpdateWidget(DoubleFormField oldWidget) {
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
