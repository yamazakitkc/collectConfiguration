### install
#### インストール
```
yum -y install heartbeat
yum -y install pacemaker
```
#### 設定ファイルのコピー
```
cp /usr/share/doc/heartbeat-*/ha.cf /etc/ha.d/ha.cf
cp /usr/share/doc/heartbeat-*/authkeys /etc/ha.d/authkeys
chkconfig heartbeat off
chmod 600 /etc/ha.d/authkeys
# pacemaker利用時はharesourcesは不要というメッセージあり。
# cp /usr/share/doc/heartbeat-*/haresources /etc/ha.d/
```
```
sed -i -e "s/#auth/auth/g" /etc/ha.d/authkeys
echo 1 sha1 abcdefg >> /etc/ha.d/authkeys
sed -i -e "s/HOSTNAME=.*/HOSTNAME=vagrant-centos65-2.vagrantup.com/" /etc/sysconfig/network
```
#### ha.cf編集
```
sed -i -e "s/#debugfile/debugfile/" /etc/ha.d/ha.cf
sed -i -e "s/#logfile/logfile/" /etc/ha.d/ha.cf
sed -i -e "s/#udpport/udpport/" /etc/ha.d/ha.cf
sed -i -e "s/auto_failback on/auto_failback off/" /etc/ha.d/ha.cf
# クラスタ対象ノードのホスト名を記載
sed -i -e "/#node\tken3/inode vagrant-centos65-1.vagrantup.com" /etc/ha.d/ha.cf
sed -i -e "/#node\tken3/inode vagrant-centos65-2.vagrantup.com" /etc/ha.d/ha.cf
# 対向のIPアドレスを記載。
sed -i -e "/#ucast eth0 192.168.1.2/iucast eth0 192.168.33.11" /etc/ha.d/ha.cf
echo pacemaker on >> /etc/ha.d/ha.cf
# こんな書き方もある
# sed -i -e "s@#debugfile /var/log/ha-debug@debugfile /var/log/ha-debug@g" /etc/ha.d/ha.cf
```
ln -s /usr/libexec/pacemaker/cib /usr/lib64/heartbeat/cib
ln -s /usr/libexec/pacemaker/stonithd /usr/lib64/heartbeat/stonithd
ln -s /usr/libexec/pacemaker/attrd /usr/lib64/heartbeat/attrd
ln -s /usr/libexec/pacemaker/crmd /usr/lib64/heartbeat/crmd
