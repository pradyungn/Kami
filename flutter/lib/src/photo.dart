import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PhotoView extends StatefulWidget {
  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  List<Asset> _images;
  Future<List<ByteData>> _thumbsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select photos of text'),
      ),
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: _images != null
                ? FutureBuilder(
                    future: _thumbsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error,
                                size: 96,
                                color: Colors.red,
                              ),
                              Text('Error: ${snapshot.error.toString()}'),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Image.memory(data[i].buffer.asUint8List()),
                          ),
                          itemCount: data.length,
                        );
                      } else {
                        return const Center(
                          child: const CircularProgressIndicator(
                            value: -1,
                          ),
                        );
                      }
                    },
                  )
                : const Center(
                    child: const Text('No images selected'),
                  ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: RaisedButton.icon(
                  icon: const Icon(Icons.camera),
                  label: Expanded(
                    child: const Text(
                      'Pick',
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  onPressed: () async {
                    final res = await MultiImagePicker.pickImages(
                      maxImages: 50,
                      enableCamera: true,
                      selectedAssets: _images ?? [],
                    );
                    if (!mounted) return;
                    setState(() {
                      _images = res;
                      _thumbsFuture = Future.wait(
                        _images.map((i) => i.getThumbByteData(300, 300)),
                        eagerError: true,
                      );
                    });
                  },
                ),
              ),
              if (_images != null) SizedBox(width: 10),
              if (_images != null)
                MaterialButton(
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  color: Colors.green,
                  minWidth: 16,
                  onPressed: () {
                    Navigator.pop(context, _images);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
