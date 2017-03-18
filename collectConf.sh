#!/bin/sh
# 実行後/root/conf/をダウンロードし、SVNにコミットする。
# 変更後同じことをすれば変更履歴を取れる。

conf_list=/root/collection/conf.list

# conf.listに記載された設定ファイルを/root/conf/にコピーする。
while read line
do
	cp --parents $line /root/collection/conf/
done < ${conf_list}
