#!/usr/bin/ruby

require 'securerandom'
require 'net/ftp'

# FTP Host address
$ftpHost = "127.0.0.1"
# FTP Port
$ftpPort = 21
# FTP Username
$ftpUsername = "username"
# FTP Password
$ftpPassword = "password"
# Folder to save screenshots in FTP
$ftpFolder = "/screenshots/"
# URL where screenshots are uploaded in FTP
$screenshotUrl = "www.example.com/screenshots/"
# Folder to locally save screenshots
$destinationFolder = "/home/user/screenshots"

@fileName = "#{Time.now.strftime "%d-%m-%Y"}-#{SecureRandom.urlsafe_base64[0..6]}.png"
@filePath = "#{$destinationFolder}/#{@fileName}"
`maim -s #{@filePath}`

`echo -n #{$screenshotUrl}#{@fileName} | xclip -selection clipboard -f`

ftp = Net::FTP.new
ftp.connect($ftpHost, $ftpPort)
ftp.login($ftpUsername, $ftpPassword)
ftp.putbinaryfile(File.new($ftpFolder+@filePath))
ftp.close
