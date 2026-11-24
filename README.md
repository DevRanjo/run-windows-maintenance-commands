# run-windows-maintenance-commands
Running the basic maintenance command scripts after one another in a .bat script.

What commands the script will run: 	
  - DISM /Online /Cleanup-image /CheckHealth
  - DISM.exe /Online /Cleanup-image /Scanhealth
  - DISM.exe /Online /Cleanup-image /Restorehealth
  - sfc /scannow
  - chkdsk C: /scan
