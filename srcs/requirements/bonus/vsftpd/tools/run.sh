#! /bin/sh

grep -E $FTP_USER /etc/passwd > /dev/null

if [ ! $? -eq 0 ]; then
	adduser $FTP_USER -D -h /home/$FTP_USER -s /bin/sh
	chpasswd <<-EOF
		$FTP_USER:$FTP_PASSWORD
	EOF
	sed -i "s/{FTP_USER}/${FTP_USER}/" /etc/vsftpd/vsftpd.conf
fi

exec vsftpd /etc/vsftpd/vsftpd.conf