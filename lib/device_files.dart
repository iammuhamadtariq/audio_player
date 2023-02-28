import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

import 'package:path_provider_extention/path_provider_extention.dart';

class DeviceFilesList extends StatefulWidget {
  const DeviceFilesList({Key? key}) : super(key: key);

  @override
  _DeviceFilesListState createState() => _DeviceFilesListState();
}

class _DeviceFilesListState extends State<DeviceFilesList> {
  var files;

  void getFiles() async {
    //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0]
        .rootDir; //storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["mp3"] //optional, to filter files, list only mp3 files
        );
    setState(() {}); //update the UI
  }

  @override
  void initState() {
    getFiles(); //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return files == null
        ? const Text("Searching Files")
        : ListView.builder(
            //if file/folder list is grabbed, then show here
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(files[index].path.split('/').last),
                leading: const Icon(Icons.audiotrack),
                trailing: const Icon(
                  Icons.play_arrow,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  // you can add Play/push code over here
                },
              ));
            },
          );
  }
}
