import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/models/validator/field_validator.dart';
import 'package:flutter_todo_app/providers/tasks.dart';
import 'package:provider/provider.dart';

class UserTaskScreen extends StatefulWidget {
  static final routeName = 'user-task/';
  final VoidCallback? onSaveData;
  UserTaskScreen({this.onSaveData});
  @override
  _UserTaskScreenState createState() => _UserTaskScreenState();
}

class _UserTaskScreenState extends State<UserTaskScreen> {
  final _description = FocusNode();
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  var _task = Task(
      id: '',
      title: '',
      date: DateTime.now(),
      description: '',
      isComplete: false);
  @override
  void dispose() {
    // TODO: implement dispose;
    _description.dispose();
    super.dispose();
  }

  Future<void> _showDialog(
      BuildContext context, String title, String content) async {
    await showDialog<Null>(
        context: context,
        builder: (_) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
            content: Text(content),
            title: Text(title),
          );
        });
  }

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Tasks>(context, listen: false)
          .addNewTask(_task.title, _task.description);
      widget.onSaveData!();
    } catch (e) {
      //print(e);
      _showDialog(
          context, 'ERROR', 'Something went wrong, please try again later!');
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
        actions: [
          IconButton(
              key: Key('save'),
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                key: Key('title'),
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_description);
                },
                validator: FieldValidator.titleValidator,
                onSaved: (newValue) {
                  _task = Task(
                      id: _task.id,
                      title: newValue.toString(),
                      date: _task.date,
                      description: _task.description);
                },
              ),
              TextFormField(
                key: Key('description'),
                decoration: InputDecoration(labelText: 'Description'),
                focusNode: _description,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) {},
                onEditingComplete: () {
                  setState(() {});
                },
                validator: FieldValidator.descriptionValidator,
                onSaved: (newValue) {
                  _task = Task(
                      id: _task.id,
                      title: _task.title,
                      date: _task.date,
                      description: newValue.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
