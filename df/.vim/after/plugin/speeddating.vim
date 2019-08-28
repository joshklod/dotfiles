
if exists(':SpeedDatingFormat') != 2
	finish
endif

SpeedDatingFormat %m%[/-]%d%1%y          " US Format
SpeedDatingFormat %m%[/-]%d%1%Y
SpeedDatingFormat %d%[/-]%m%1%y          " European Format
SpeedDatingFormat %d%[/-]%m%1%Y
SpeedDatingFormat %[1]9%[0-9]%[0-9]-%Y   " Date Range
SpeedDatingFormat %[2]0%[0-9]%[0-9]-%Y
