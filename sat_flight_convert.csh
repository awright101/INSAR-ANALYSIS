#!/bin/csh 
 
#Convert grd files for header/inclination of satellite flight + XYZ grd data for INSAR into XYZ ascii then combine each LOS file in format using cat file >> new_file 
 
#LONG  LAT  LOS_VELO  HEADER  INCLINATION  FILENAME 
 
 
#Converting grd files 2 xyz files  
 
foreach file (`ls match_los.grd.dir/*grd`) 

set newfile = `echo match_los.grd.dir/$file | sed 's/grd/xyz/g'` 
grd2xyz match_los.grd.dir/$file -R27.5/41.5/36.5/42.5 > match_los.grd.dir/$newfile   

end 
 
#MOVING NEW XYZ INSAR files to match_los.txt.dir  

 
 
#foreach file (`ls match_los.grd.dir/*.xyz`)  # mv $file match_los.txt.dir #end rm combined_LOS_MASTER.xyz 
 
 
#COMBINING FILES  set lines=`cat file_endings.txt` set i=1 while ( $i <= $#lines ) 
 
set num = $lines[$i] 
 
 
set hedfile = inchedfiles/bighed$num 
set incfile = inchedfiles/biginc$num 
set insarfile = match_los.txt.dir/match_losrate$num 
set filename = XY_los_inched_$num 
 
 
set filename = "INSAR_116"
echo $filename | awk '{print $1}' > name_temp.txt awk '{print $3}' $hedfile > hed_temp.txt 

awk '{print $3}' $incfile  > inc_temp.txt 
 
paste $insarfile inc_temp.txt hed_temp.txt > combfiles.dir/$filename.tmp 
awk '{print $0 FS "\t'$lines[$i]'"}' combfiles.dir/$filename.tmp > combfiles.dir/$filename 
echo """combined file now stored in combfiles.dir/$filename """ 
 
rm  combfiles.dir/$filename.tmp 
 
cat combfiles.dir/$filename >> combined_LOS_MASTER.xyz 
set firstpart = XY_los_inched_ #foreach file (`ls combfiles.dir/*xyz`)
set marker = $file  #set marker = `echo $file | sed 's/'$firstpart'/file_/g'`
awk '{print $0 FS "\t'$marker'"}' $file > $file #echo "done $file" #end 
 
 
echo $lines[$i]     

@ i = $i + 1 


end 

rm hed_temp.txt 
rm inc_temp.txt 
 
echo """ALL FILES NOW STORED IN COMBINED MASTER LOS.XYZ VIA CAT!!!!"""
