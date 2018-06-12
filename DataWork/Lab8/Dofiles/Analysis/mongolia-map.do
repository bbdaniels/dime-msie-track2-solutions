* Suggested solution to Lab 8 mapping exercise

global part1 0


* Installing mapping commands

	if $part1{
		local toinstall "spmap spgrid geodist mergepoly geoinpoly shp2dta"

		foreach x of local toinstall {
			ssc install `x' , all replace
		}
	}

* Converting shp files into dta format

	shp2dta using "${Lab8_dt}/GIS/Mongolia/MNG_adm/MNG_adm2.shp" ///
		, database("${Lab8_dtFin}/Mongolia/mng_data.dta") ///
		coordinates("${Lab8_dtFin}/Mongolia/mng_coor.dta") ///
		replace

* Generating a map of Mongolia

	use "${Lab8_dtFin}/Mongolia/mng_data.dta" , clear

	spmap ///
		using "${Lab8_dtFin}/Mongolia/mng_coor.dta" ///
		, id(_ID) title("Mongolia", size(*1.8))  fcolor(none)

		graph export "${Lab8_outRaw}/Mongolia.png", as(png) replace

* Limit to study area

	use "${Lab8_dtFin}/Mongolia/mng_data.dta" , clear
		keep if NAME_1=="Arhangay"

	spmap ///
	 	using "${Lab8_dtFin}/Mongolia/mng_coor.dta" ///
	, id(_ID) ///
		title("Arhangay Province" "Study Area", size(*1.8)) ///
		subtitle("Study Area" " ", size(*0.8)) fcolor(none)

		graph export "${Lab8_outRaw}/study_area.png", as(png) replace

* Make outline of study area

	use "${Lab8_dtFin}/Mongolia/mng_data.dta" , clear
	keep if NAME_1=="Arhangay"

	mergepoly ///
		using "${Lab8_dtFin}/Mongolia/mng_coor.dta" ///
	, coor("${Lab8_dtFin}/Mongolia/outline_coor.dta") replace

		save "${Lab8_dtFin}/Mongolia/outline_data.dta" , replace

	spmap ///
		using "${Lab8_dtFin}/Mongolia/outline_coor.dta" ///
	, id(_ID) title("Arhangay Province", size(*1.8)) ///
		subtitle("Study Area" "Outline", size(*0.8)) fcolor(none)

		graph export "${Lab8_outRaw}/study_area_outline.png", as(png) replace

* Plot points on outline of study area

	use "${Lab8_dtFin}/Mongolia/outline_data.dta",replace

	spmap ///
		using "${Lab8_dtFin}/Mongolia/outline_coor.dta" ///
	, id(_ID) title("Arhangay Province", size(*1.8)) ///
		subtitle("Study Area" "Outline" "Household Locations", size(*0.8)) fcolor(none) ///
  	    point(data("${Lab8_dtInt}/lab8_survey_data.dta") ///
			xcoord(lon) ycoord(lat) by(status) size(tiny tiny) fcolor(green red))

		graph export "${Lab8_outRaw}/points1.png", as(png) replace

* Graph points on whole country

  	use "${Lab8_dtFin}/Mongolia/mng_data.dta",clear

	spmap  ///
		using "${Lab8_dtFin}/Mongolia/mng_coor.dta" ///
	, id(_ID) title("Mongolia", size(*1.8))  fcolor(none) ///
		subtitle("Study Area" "Outline" "Household Locations", size(*0.8)) ///
  	    point(data("${Lab8_dtInt}/lab8_survey_data.dta") ///
			xcoord(lon) ycoord(lat) by(status) size(tiny tiny) fcolor(green red))

		graph export "${Lab8_outRaw}/points2.png", as(png) replace

* Check if all points lie within study area
	use "${Lab8_dtInt}/lab8_survey_data.dta",replace

    geoinpoly lat lon using "${Lab8_dtFin}/Mongolia/outline_coor.dta"
    tab _ID, missing
    *only 23% of all gps coordinates are within our study area

* Polygons and shading

	use "${Lab8_dtInt}/lab8_survey_data.dta" , clear

    geoinpoly lat lon using "${Lab8_dtFin}/Mongolia/mng_coor.dta"
    tab _ID, missing


	* Generating variable for how many households per village

    egen villagecount=count(status),by(_ID)
    duplicates drop _ID,force

    merge 1:1 _ID using "${Lab8_dtFin}/Mongolia/mng_data.dta",nogen keep(match using)

    spmap villagecount ///
		using "${Lab8_dtFin}/Mongolia/mng_coor.dta" ///
		, id(_ID) title("Mongolia", size(*1.8))  fcolor(Reds)


	graph export "${Lab8_outRaw}/village_count.png", as(png) replace

* Have a lovely day!
