/// barrel file for posix specific functions.
library posix;

export 'src/posix/chmod.dart' show chmod, ChModException;
export 'src/posix/chown.dart' show chown, ChOwnException;
export 'src/shell/ash_shell.dart';
export 'src/shell/bash_shell.dart';
export 'src/shell/dash_shell.dart';
export 'src/shell/fish_shell.dart';
export 'src/shell/posix_shell.dart';
export 'src/shell/sh_shell.dart';
export 'src/shell/zsh_shell.dart';