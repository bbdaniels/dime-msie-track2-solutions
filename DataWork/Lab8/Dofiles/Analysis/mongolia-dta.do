
*wb_git_install dta2kml

cd "/users/bbdaniels/desktop/"

clear
set obs 500
gen lat = rnormal() +38
gen lon = rnormal() -77


dta2kml using demo.kml , lat(lat) lon(lon) replace
