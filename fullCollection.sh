#!/bin/sh
# 実行後/root/conf/をダウンロードし、SVNにコミットする。
# 変更後同じことをすれば変更履歴を取れる。

./collectConf.sh
./resultcCommand.sh
