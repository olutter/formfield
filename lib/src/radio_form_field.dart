part of '../forms.dart';

/// Radio form field item.
class RadioFormFieldItem<T> {
  const RadioFormFieldItem({
    required this.value,
    required this.title,
    this.subtitle,
  });

  final Widget title;
  final Widget? subtitle;
  final T value;
}

/// Radio form field.
class RadioFormField<T> extends FormField<T> {
  RadioFormField({
    Key? key,
    required this.items,
    required this.onChanged,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    T? initialValue,
    FormFieldSetter<T>? onSaved,
    String? restorationId,
    FormFieldValidator<T>? validator,
  }) : super(
          key: key,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          initialValue: initialValue,
          onSaved: onSaved,
          restorationId: restorationId,
          validator: validator,
          builder: (state) {
            final errorText = state.errorText;

            final children = items
                .map(
                  (e) => RadioListTile<T>(
                    title: e.title,
                    subtitle: e.subtitle,
                    onChanged: state.didChange,
                    groupValue: state.value,
                    value: e.value,
                  ),
                )
                .toList();

            return Builder(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...children,
                  if (errorText != null) const SizedBox(height: 8),
                  if (errorText != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24,
                      ),
                      child: Text(
                        errorText,
                        style:
                            Theme.of(context).inputDecorationTheme.errorStyle,
                      ),
                    )
                ],
              );
            });
          },
        );

  final List<RadioFormFieldItem<T>> items;
  final void Function(T? v) onChanged;

  @override
  FormFieldState<T> createState() => _RadioFormFieldState<T>();
}

class _RadioFormFieldState<T> extends FormFieldState<T> {
  RadioFormField<T> get _formField => widget as RadioFormField<T>;

  @override
  void didChange(T? value) {
    super.didChange(value);
    _formField.onChanged(value);
  }

  @override
  void didUpdateWidget(RadioFormField<T> oldWidget) {
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
