#!/bin/sh
# 実行後/root/conf/をダウンロードし、SVNにコミットする。
# 変更後同じことをすれば変更履歴を取れる。

exec_list=/root/collection/exec.list

# exec.listで実行した結果を/root/conf/にリダイレクトする。
while read line
do
	eval ${line}
done < ${exec_list}
