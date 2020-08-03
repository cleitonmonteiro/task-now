import 'package:flutter/material.dart';

Future<DateTime> showDatetimePicker({
  @required BuildContext context,
  @required DateTime initialDate,
  @required DateTime firstDate,
  @required DateTime lastDate,
}) {
  Widget dialog = DateTimePickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  return showDialog<DateTime>(
    context: context,
    builder: (BuildContext context) => dialog,
  );
}

class DateTimePickerDialog extends StatefulWidget {
  const DateTimePickerDialog({
    @required this.initialDate,
    @required this.firstDate,
    @required this.lastDate,
    this.cancelText = 'Cancel',
    this.confirmText = 'Done',
  });

  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The text that is displayed on the cancel button.
  final String cancelText;

  /// The text that is displayed on the confirm button.
  final String confirmText;

  @override
  _DateTimePickerDialogState createState() => _DateTimePickerDialogState();
}

class _DateTimePickerDialogState extends State<DateTimePickerDialog> {
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _handleOk() {
    if (_selectedTime != null) {
      final datetime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      return Navigator.pop(context, datetime);
    }

    Navigator.pop(context, _selectedDate);
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  void _handleDateChanged(DateTime date) {
    setState(() => _selectedDate = date);
  }

  void _showSetTimeDialog() async {
    final now = TimeOfDay.now();

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );

    if (selectedTime != null) {
      setState(() => _selectedTime = selectedTime);
    }
  }

  String get _timeText =>
      _selectedTime != null ? _selectedTime.format(context) : 'Set time';

  @override
  Widget build(BuildContext context) {
    final Widget actions = ButtonBar(
      buttonTextTheme: ButtonTextTheme.primary,
      layoutBehavior: ButtonBarLayoutBehavior.constrained,
      children: <Widget>[
        FlatButton(
          child: Text(widget.cancelText),
          onPressed: _handleCancel,
        ),
        FlatButton(
          child: Text(widget.confirmText),
          onPressed: _handleOk,
        ),
      ],
    );

    Widget datePicker = CalendarDatePicker(
      initialDate: _selectedDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      onDateChanged: _handleDateChanged,
    );

    Widget setTimeButtom = RawMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      onPressed: () => _showSetTimeDialog(),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.schedule),
          ),
          Expanded(
            child: Card(
              elevation: 0.0,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(_timeText),
              ),
            ),
          ),
        ],
      ),
    );

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: datePicker,
          ),
          setTimeButtom,
          actions,
        ],
      ),
    );
  }
}
