* Let's make a map of Kenya!

global directory "/Users/bbdaniels/Dropbox/WorldBank/DIME/FC Training/June 2018/Session Materials/Stata Track 2/Lab 8 - GIS in Stata"

* Convert Kenya outline to dta

	shp2dta ///
			using "${directory}/GIS/KEN_adm/KEN_adm0.shp" ///
		, database("${directory}/data/KEN_adm0_database.dta") ///
			coordinates("${directory}/data/KEN_adm0_coordinates.dta") ///
			genid(ID) replace

* Map Kenya outline

	use "${directory}/data/KEN_adm0_database.dta" , clear

	spmap ///
			using "${directory}/data/KEN_adm0_coordinates.dta" ///
		, id(ID)

		graph export ///
				"${directory}/outputs/KEN_adm0.png" ///
			,	replace width(2000)

* Convert Kenya regions to dta

	shp2dta ///
			using "${directory}/GIS/KEN_adm/KEN_adm1.shp" ///
		, database("${directory}/data/KEN_adm1_database.dta") ///
			coordinates("${directory}/data/KEN_adm1_coordinates.dta") ///
			genid(ID) replace

* Map Kenya with regions

	use "${directory}/data/KEN_adm1_database.dta" , clear

	spmap ///
			using "${directory}/data/KEN_adm1_coordinates.dta" ///
		, id(ID)

		graph export ///
				"${directory}/outputs/KEN_adm1.png" ///
			,	replace width(2000)

* Map Kenya with arbitrary color

	use "${directory}/data/KEN_adm1_database.dta" , clear

	clonevar fakeattribute = ID

	spmap fakeattribute ///
			using "${directory}/data/KEN_adm1_coordinates.dta" ///
		, id(ID) fcolor(maroon navy dkgreen dkorange)

		graph export ///
				"${directory}/outputs/KEN_adm1_color.png" ///
			,	replace width(2000)

* Convert features to .dta

	shp2dta ///
			using "${directory}/GIS/ke_major-roads/ke_major-roads.shp" ///
		, database("${directory}/data/ke_major-roads_database.dta") ///
			coordinates("${directory}/data/ke_major-roads_coordinates.dta") ///
			genid(ID) replace

	shp2dta ///
			using "${directory}/GIS/ke_protected-areas/ke_protected-areas.shp" ///
		, database("${directory}/data/ke_protected-areas_database.dta") ///
			coordinates("${directory}/data/ke_protected-areas_coordinates.dta") ///
			genid(ID) replace

	shp2dta ///
			using "${directory}/GIS/ke_hotels-lodges-campsites/ke_hotels-lodges-campsites.shp" ///
		, database("${directory}/data/ke_hotels-lodges-campsites_database.dta") ///
			coordinates("${directory}/data/ke_hotels-lodges-campsites_coordinates.dta") ///
			genid(ID) replace

* Add protected areas

	use "${directory}/data/KEN_adm1_database.dta" , clear

	spmap ///
			using "${directory}/data/KEN_adm1_coordinates.dta" ///
		, id(ID) oc(gray) ///
			polygon( ///
				data("${directory}/data/ke_protected-areas_coordinates.dta") ///
				fc(dkgreen) oc(none))

		graph export ///
				"${directory}/outputs/KEN_adm1_areas.png" ///
			,	replace width(2000)

* Add roads

	use "${directory}/data/KEN_adm1_database.dta" , clear

	spmap ///
			using "${directory}/data/KEN_adm1_coordinates.dta" ///
		, id(ID) oc(gray) ///
			polygon( ///
				data("${directory}/data/ke_protected-areas_coordinates.dta") ///
				fc(dkgreen) oc(none)) ///
			line( ///
				data("${directory}/data/ke_major-roads_coordinates.dta") ///
				)

		graph export ///
				"${directory}/outputs/KEN_adm1_roads.png" ///
			,	replace width(2000)

* Add campsites

	use "${directory}/data/KEN_adm1_database.dta" , clear

	spmap ///
			using "${directory}/data/KEN_adm1_coordinates.dta" ///
		, id(ID) oc(gray) ///
			polygon( ///
				data("${directory}/data/ke_protected-areas_coordinates.dta") ///
				fc(dkgreen) oc(none) ///
				) ///
			line( ///
				data("${directory}/data/ke_major-roads_coordinates.dta") ///
				) ///
			point( ///
				data("${directory}/data/ke_hotels-lodges-campsites_coordinates.dta") ///
				x(_X) y(_Y) size(medium) shape(t) fc(red) oc(black) ///
				)

		graph export ///
				"${directory}/outputs/KEN_adm1_sites.png" ///
			,	replace width(2000)

* Have a lovely day!
