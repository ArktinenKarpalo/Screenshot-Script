#!/usr/bin/ruby

require 'securerandom'
require 'net/ftp'

$ftpHost = "127.0.0.1"								# FTP Host address
$ftpPort = 21										# FTP Port
$ftpUsername = "username"							# FTP Username
$ftpPassword = "password"							# FTP Password
$ftpFolder = "/screenshots/"						# Folder to save screenshots in FTP
$screenshotUrl = "www.example.com/screenshots/"		# URL where screenshots are uploaded in FTP
$destinationFolder = "/home/user/screenshots"		# Folder to locally save screenshots

@fileName = "#{Time.now.strftime "%d-%m-%Y"}-#{SecureRandom.urlsafe_base64[0..6]}.png"
@filePath = "#{$destinationFolder}/#{@fileName}"
`import #{@filePath}`

ftp = Net::FTP.new
ftp.connect($ftpHost, $ftpPort)
ftp.login($ftpUsername, $ftpPassword)
ftp.putbinaryfile(File.new($ftpFolder+@filePath))
ftp.close

`echo -n #{$screenshotUrl}#{@fileName} | xclip -selection clipboard`
