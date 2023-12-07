import 'dart:io';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

final pathToSaveAudio = 'audio_example.aac';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecordingInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission denied");
    }

    await _audioRecorder!.openAudioSession();

    _isRecordingInitialised = true;

    _audioRecorder!.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    if (!_isRecordingInitialised) return;

    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future stop() async {
    if (!_isRecordingInitialised) return;

    final path = await _audioRecorder!.stopRecorder();
    final audioFile = File(path!);
    print("Recorded Audio: $audioFile");
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }

  Future dispose() async {
    if (!_isRecordingInitialised) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecordingInitialised = false;
  }
}
