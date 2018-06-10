


***************************************
global map_exercise "C:\Dropbox\dime training"

global part1 0
global part2 1
global part3 1
global part4 1
global part5 1
global part6 1
global part7 1
global part8 1
global part9 0

if $part1{
	*install relevent commands
	local toinstall "spmap spgrid geodist mergepoly geoinpoly shp2dta"
	foreach x of local toinstall{
		ssc install `x' , all replace
	}
}



if $part2{
	*converting shp files into dta format
	shp2dta using "$map_exercise/MNG_adm/MNG_adm2.shp", database("$map_exercise/mng_data") coordinates("$map_exercise/mng_coor") replace
}

if $part3{
	*generating a map of mongolia
	use "$map_exercise/mng_data.dta",clear
	spmap  using "$map_exercise/mng_coor.dta" , id(_ID) title("Mongolia", size(*1.8))  fcolor(none)
	graph export "$map_exercise/Mongolia.png", as(png) replace
}

if $part4{
	*limit to study area
	use "$map_exercise/mng_data.dta",clear
	keep if NAME_1=="Arhangay"
	spmap  using "$map_exercise/mng_coor.dta" , id(_ID) title("Arhangay Province" "Study Area", size(*1.8)) ///
		subtitle("Study Area" " ", size(*0.8)) fcolor(none)
	graph export "$map_exercise/study_area.png", as(png) replace
}

if $part5{
	*make outline of study area
	use "$map_exercise/mng_data.dta",clear
	keep if NAME_1=="Arhangay"
	mergepoly using "$map_exercise/mng_coor.dta",coor("$map_exercise/outline_coor.dta") replace
	save "$map_exercise/outline_data.dta",replace

	spmap using "$map_exercise/outline_coor.dta", id(_ID) title("Arhangay Province", size(*1.8)) ///
		subtitle("Study Area" "Outline", size(*0.8)) fcolor(none)
	graph export "$map_exercise/study_area_outline.png", as(png) replace	
}

if $part6{
	*graph points on outline of study area
	use "$map_exercise/outline_data.dta",replace
	spmap using "$map_exercise/outline_coor.dta", id(_ID) title("Arhangay Province", size(*1.8)) ///
		subtitle("Study Area" "Outline" "Household Locations", size(*0.8)) fcolor(none) ///
  	    point(data("$map_exercise/survey_data.dta")xcoord(lon) ycoord(lat) by(status) size(tiny tiny) fcolor(green red))
	graph export "$map_exercise/points1.png", as(png) replace	  	
  	*graph points on whole country
  	use "$map_exercise/mng_data.dta",clear
	spmap  using "$map_exercise/mng_coor.dta" , id(_ID) title("Mongolia", size(*1.8))  fcolor(none) ///
		subtitle("Study Area" "Outline" "Household Locations", size(*0.8)) ///
  	    point(data("$map_exercise/survey_data.dta")xcoord(lon) ycoord(lat) by(status) size(tiny tiny) fcolor(green red))	
	graph export "$map_exercise/points2.png", as(png) replace
}


if $part7{
	*check if all points lie within study area
	use "$map_exercise/survey_data.dta",replace

    geoinpoly lat lon using "$map_exercise/outline_coor.dta"
    tab _ID, missing
    *only 23% of all gps coordinates are within our study area
    }


if $part8{
	*bring back polygons and shade

	use "$map_exercise/survey_data.dta",replace

    geoinpoly lat lon using "$map_exercise/mng_coor"
    tab _ID, missing

    *generating variable for how many households per village
    egen villagecount=count(status),by(_ID)
    duplicates drop _ID,force

    merge 1:1 _ID using "$map_exercise/mng_data.dta",nogen keep(match using)

    spmap villagecount using "$map_exercise/mng_coor.dta" , id(_ID) title("Mongolia", size(*1.8))  fcolor(Reds)
       		

	graph export "$map_exercise/village_count.png", as(png) replace

}

if $part9{
	*optional break study area into evenly sized cells
	*calculate distance between households
	

}

