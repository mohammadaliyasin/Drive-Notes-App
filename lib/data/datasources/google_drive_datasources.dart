import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

class DriveApiService {
  final AuthClient client;
  final drive.DriveApi driveApi;

  DriveApiService({required this.client})
      : driveApi = drive.DriveApi(client);

  Future<drive.File> createNoteFile(String folderId, String title, String content) async {
    final file = drive.File()
      ..name = '$title.txt'
      ..parents = [folderId]
      ..mimeType = 'text/plain';

    final media = drive.Media(Stream.value(content.codeUnits), content.length);
    return await driveApi.files.create(file, uploadMedia: media);
  }

  Future<void> updateNoteFile(String fileId, String newContent) async {
    final media = drive.Media(Stream.value(newContent.codeUnits), newContent.length);
    await driveApi.files.update(drive.File(), fileId, uploadMedia: media);
  }

  Future<List<drive.File>> listNoteFiles(String folderId) async {
    final files = await driveApi.files.list(q: "'\$folderId' in parents and mimeType='text/plain'");
    return files.files ?? [];
  }

  Future<String> createDriveNotesFolder() async {
    final folder = drive.File()
      ..name = 'DriveNotes'
      ..mimeType = 'application/vnd.google-apps.folder';

    final created = await driveApi.files.create(folder);
    return created.id!;
  }

  Future<String?> getDriveNotesFolderId() async {
    final result = await driveApi.files.list(q: "name='DriveNotes' and mimeType='application/vnd.google-apps.folder'");
    return result.files?.firstOrNull?.id;
  }
}