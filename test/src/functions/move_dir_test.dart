@Timeout(Duration(seconds: 600))

import 'package:test/test.dart' as t;
import 'package:dshell/dshell.dart';
import 'package:test/test.dart';

import '../util/test_file_system.dart';

String testFile;
void main() {
  t.group('moveDir', () {
    t.test('empty to ', () {
      TestFileSystem().withinZone((fs) {
        var from = join(fs.root, 'top');
        var to = join(fs.root, 'new_top');

        if (exists(to)) {
          deleteDir(to, recursive: true);
        }
        moveDir(from, to);
        t.expect(exists(to), t.equals(true));
      });
    });

    t.test('existing to ', () {
      TestFileSystem().withinZone((fs) {
        var from = join(fs.root, 'top');
        var to = join(fs.root, 'new_top');

        if (!exists(from)) {
          createDir(from, recursive: true);
        }
        if (!exists(to)) {
          createDir(to, recursive: true);
        }

        t.expect(
            () => moveDir(from, to),
            throwsA(t.predicate<MoveDirException>((e) =>
                e is MoveDirException &&
                e.message == 'The [to] path ${truepath(to)} must NOT exist.')));
      });
    });

    t.test('from not a directory ', () {
      TestFileSystem().withinZone((fs) {
        var from = join(fs.root, 'top', 'file');
        var to = join(fs.root, 'new_top');

        if (!exists(dirname(from))) {
          createDir(dirname(from), recursive: true);
        }
        touch(from, create: true);

        t.expect(
            () => moveDir(from, to),
            throwsA(t.predicate<MoveDirException>((e) =>
                e is MoveDirException &&
                e.message ==
                    'The [from] path ${truepath(from)} must be a directory.')));
      });
    });

    t.test('from does not exist ', () {
      TestFileSystem().withinZone((fs) {
        var from = join(fs.root, 'random');
        var to = join(fs.root, 'new_top');

        t.expect(
            () => moveDir(from, to),
            throwsA(t.predicate<MoveDirException>((e) =>
                e is MoveDirException &&
                e.message ==
                    'The [from] path ${truepath(from)} does not exists.')));
      });
    });
  });
}

/// checks that the given list of files no longer exists.
bool hasMoved(List<String> files) {
  var moved = true;
  for (var file in files) {
    if (exists(file)) {
      printerr('The file $file was not moved');
      moved = false;
      break;
    }
  }
  return moved;
}

List<String> subname(List<String> expected, String from, String replace) {
  var result = <String>[];

  for (var path in expected) {
    path = path.replaceAll(from, replace);
    result.add(path);
  }
  return result;
}