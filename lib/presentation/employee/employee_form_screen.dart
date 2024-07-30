import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Function onTapBack;
  const EmployeeFormScreen({super.key, required this.onTapBack});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  final bool _lockParentWindow = false;
  bool _userAborted = false;
  final bool _multiPick = false;
  final FileType _pickingType = FileType.any;

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        compressionQuality: 30,
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        dialogTitle: _dialogTitleController.text,
        initialDirectory: _initialDirectoryController.text,
        lockParentWindow: _lockParentWindow,
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _clearCachedFiles() async {
    _resetState();
    try {
      bool? result = await FilePicker.platform.clearTemporaryFiles();
      _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            (result!
                ? 'Temporary files removed with success.'
                : 'Failed to clean temporary files'),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final path =
        kIsWeb ? null : _paths!.map((e) => e.path).toList()[0].toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () => widget.onTapBack(),
                icon: Icon(Icons.arrow_back)),
            Text(
              'Add Employee\'s Form',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(child: SizedBox()),
            OutlinedButton(
              onPressed: () {
                _pickFiles();
              },
              child: const Text('Upload File'),
            ),
          ],
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(height: 10),
                  Text(
                    'Uploaded File',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Builder(
                    builder: (BuildContext context) => _isLoading
                        ? Row(
                            children: const [
                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.0,
                                    ),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : _userAborted
                            ? Row(
                                children: const [
                                  Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        width: 300,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.error_outline,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          title: Text(
                                            'User has aborted the dialog',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : _directoryPath != null
                                ? ListTile(
                                    title: const Text('Directory path'),
                                    subtitle: Text(_directoryPath!),
                                  )
                                : _paths != null
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                _paths!.first.name,
                                              ),
                                              trailing: OutlinedButton.icon(
                                                onPressed: () =>
                                                    _clearCachedFiles(),
                                                label: const Text('Delete'),
                                                icon: const Icon(
                                                    Icons.delete_forever),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : _saveAsFileName != null
                                        ? ListTile(
                                            title: const Text('Save file'),
                                            subtitle: Text(_saveAsFileName!),
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                  ),
                  Expanded(child: SizedBox()),
                  OutlinedButton.icon(
                    onPressed: _paths != null ? () => widget.onTapBack() : null,
                    label: const Text('Submit'),
                    icon: const Icon(Icons.save),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
