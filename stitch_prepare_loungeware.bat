@echo off
setlocal

echo checking for node
node -v > nul 2>&1
if %errorlevel% equ 0 (
    echo found node!
) else (
  echo installing node through NVM
  curl  -L -o nvm-setup.exe https://github.com/coreybutler/nvm-windows/releases/download/1.1.11/nvm-setup.exe
  start /w "node setup" nvm-setup.exe
  del nvm-setup.exe
  setx NVM_HOME "%USERPROFILE%\.nvm"
  setx PATH "%PATH%;%USERPROFILE%\.nvm"
  nvm install 16
  nvm use 16
)

echo installing stitch
npm install --global @bscotch/stitch

echo loungeware is ready!
endlocal
