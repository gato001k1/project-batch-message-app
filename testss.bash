#!/bin/bash

if [ -e echoon ]; then
  echo on
else
  echo off
fi

clear
echo "test CHBAT v1.6 TEST"
echo "requirements"
read -p "filename=" filename
if [ ! -d "users" ]; then
  echo "creating user folder"
  mkdir users
  clear
  ftpUsers
else
  ftpUsers
fi

ftpUsers() {
  if [ ! -e "username.u" ]; then
    changeusername
  else
    read uusername < username.u
    cd users
    echo "$uusername"
  fi

  ftpuserschoose
}

changeusername() {
  clear
  read -p "What username would you like to use?" uusername
  echo "$uusername" > username.u
  read uusername < username.u
  cd users
  echo "$uusername"
}

ftpuserschoose() {
  clear
  echo "select the user or option"
  echo "Write create to make a new user or settings to enter the settings and write exit to exit:"
  users=$(ls -1)
  echo "$users"
  read -p "optusr=" optusr
  if [ "$optusr" == "exit" ]; then
    exit
  elif [ "$optusr" == "create" ]; then
    inic
  elif [ "$optusr" == "settings" ]; then
    settings
  elif [ ! -d "$optusr" ]; then
    echo "$optusr does not exist"
    pause
    clear
    ftpuserschoose
  else
    cd "$optusr"
    read ftpUsername < username
    read ftpServer < server
    read ftpPassword < password
    read filename_save < filename.save
    cd ..
    nohup ./reciveftp.sh &
    cd users/"$optusr"
    clear
    loop
  fi
}

inic() {
  clear
  read -p "Enter The custom name:" optusr
  if [ -d "$optusr" ]; then
    echo "that custom name already exists"
    pause
    clear
    inic
  fi
  read -p "Enter the IP address or the Host name of the SFTP server:" ftpServer
  read -p "Enter the username to log in to the SFTP server:" ftpUsername
  read -p "Enter the password to log in to the SFTP server:" ftpPassword
  mkdir "$optusr"
  cd "$optusr"
  echo "$ftpUsername" > username
  echo "$ftpServer" > server
  echo "$ftpPassword" > password
  clear
  read -p "write the new file name or random" filename
  if [ "$filename" == "random" ]; then
    random_file2
  fi
  echo "$filename.txt" > filename.save
  echo "475872309570475-57-3475-347-57509875027057-57-3475-43543850843590843-58-358-3458-03485-4385-34850238-5843-58-403985-034285-834-58342-958-385-8342-58-34285-843-583-085-384-5823858" > "$filename_save"
  read username < username
  read password < password
  read server < server
  curl -u "$username":"$password" -T "$filename" ftp://"$server"
  pause
  clear
  goto cl
}

random_file2() {
  echo "$RANDOM$RANDOM.txt" > filename.save
  read filename_save < filename.save
  echo "475872309570475-57-3475-347-57509875027057-57-3475-43543850843590843-58-358-3458-03485-4385-34850238-5843-58-403985-034285-834-58342-958-385-8342-58-34285-843-583-085-384-5823858" > "$filename_save"
  read username < username
  read password < password
  read server < server
  curl -u "$username":"$password" -T "$filename_save" ftp://"$server"
  echo "Random filename set: $filename_save"
  pause
  clear
  goto cl
}

loop() {
  send2
}

send2() {
  read filename_save < filename.save
  cd ..
  cd ..
  echo "$optusr" > display.user
  echo "$filename_save" > display.filename
  nohup ./display.sh &
  cd users/"$optusr"
  send3
}

send3() {
  clear
  echo "write *reset to reset the reciver and exit to exit"
  echo "Server credentials: usr $ftpUsername usrn $uusername pass $ftpPassword serv $ftpServer file.save $filename_save"
  read -p "insert message here:" send
  if [ "$send" == "exit" ]; then
    cd ..
    ftpuserschoose
  elif [ "$send" == "*reset" ]; then
    cd ..
    resetreciver
  else
    echo "$(date) $uusername $send" >> "$filename_save"
    echo "0" > text.refresh
    curl -u "$ftpUsername":"$ftpPassword" -T "$filename_save" ftp://"$ftpServer"
    clear
    echo "sended"
    pause
    clear
    send3
  fi
}

settings() {
  clear
  echo "WIP settings"
  echo "change username 'username'"
  echo "change the name of the message file 'filename'"
  echo "to turn echo on 'echo on'"
  echo "exit"
  read -p "settings=" settings
  if [ "$settings" == "filename" ]; then
    filename
  elif [ "$settings" == "exit" ]; then
    cd users
    ftpuserschoose
  elif [ "$settings" == "username" ]; then
    changeusername
  elif [ "$settings" == "echo on" ]; then
    echoon
  else
    echo "That option is not available"
    pause
    clear
    settings
  fi
}

filename() {
  clear
  cd users
  echo "for what user u want to change"
  ls -1
  read -p "user_name=" user_name
  if [ ! -d "$user_name" ]; then
    echo "$user_name does not exist"
    pause
    clear
    filename
  else
    cd "$user_name"
    read -p "write the new file name or random" filename
    if [ "$filename" == "random" ]; then
      random_file
    fi
    echo "$filename.txt" > filename.save
    echo "475872309570475-57-3475-347-57509875027057-57-
