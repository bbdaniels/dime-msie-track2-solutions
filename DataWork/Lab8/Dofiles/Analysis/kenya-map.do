* Let's make a map of Kenya!

* Convert Kenya outline to dta

	shp2dta ///
			using "${Lab8_dt}/GIS/Kenya/KEN_adm/KEN_adm0.shp" ///
		, database("${Lab8_dtFin}/Kenya/KEN_adm0_database.dta") ///
			coordinates("${Lab8_dtFin}/Kenya/KEN_adm0_coordinates.dta") ///
			genid(ID) replace

* Map Kenya outline

	use "${Lab8_dtFin}/Kenya/KEN_adm0_database.dta" , clear

	spmap ///
			using "${Lab8_dtFin}/Kenya/KEN_adm0_coordinates.dta" ///
		, id(ID)

		graph export ///
				"${Lab8_outRaw}/KEN_adm0.png" ///
			,	replace width(2000)

* Convert Kenya regions to dta

	shp2dta ///
			using "${Lab8_dt}/GIS/Kenya/KEN_adm/KEN_adm1.shp" ///
		, database("${Lab8_dtFin}/Kenya/KEN_adm1_database.dta") ///
			coordinates("${Lab8_dtFin}/Kenya/KEN_adm1_coordinates.dta") ///
			genid(ID) replace

* Map Kenya with regions

	use "${Lab8_dtFin}/Kenya/KEN_adm1_database.dta" , clear

	spmap ///
			using "${Lab8_dtFin}/Kenya/KEN_adm1_coordinates.dta" ///
		, id(ID)

		graph export ///
				"${Lab8_outRaw}/KEN_adm1.png" ///
			,	replace width(2000)

* Map Kenya with arbitrary color

	use "${Lab8_dtFin}/Kenya/KEN_adm1_database.dta" , clear

	clonevar fakeattribute = ID

	spmap fakeattribute ///
			using "${Lab8_dtFin}/Kenya/KEN_adm1_coordinates.dta" ///
		, id(ID) fcolor(maroon navy dkgreen dkorange)

		graph export ///
				"${Lab8_outRaw}/KEN_adm1_color.png" ///
			,	replace width(2000)

* Convert features to .dta

	shp2dta ///
			using "${Lab8_dt}/GIS/Kenya/ke_major-roads/ke_major-roads.shp" ///
		, database("${Lab8_dtFin}/Kenya/ke_major-roads_database.dta") ///
			coordinates("${Lab8_dtFin}/Kenya/ke_major-roads_coordinates.dta") ///
			genid(ID) replace

	shp2dta ///
			using "${Lab8_dt}/GIS/Kenya/ke_protected-areas/ke_protected-areas.shp" ///
		, database("${Lab8_dtFin}/Kenya/ke_protected-areas_database.dta") ///
			coordinates("${Lab8_dtFin}/Kenya/ke_protected-areas_coordinates.dta") ///
			genid(ID) replace

	shp2dta ///
			using "${Lab8_dt}/GIS/Kenya/ke_hotels-lodges-campsites/ke_hotels-lodges-campsites.shp" ///
		, database("${Lab8_dtFin}/Kenya/ke_hotels-lodges-campsites_database.dta") ///
			coordinates("${Lab8_dtFin}/Kenya/ke_hotels-lodges-campsites_coordinates.dta") ///
			genid(ID) replace

* Add protected areas

	use "${Lab8_dtFin}/Kenya/KEN_adm1_database.dta" , clear

	spmap ///
			using "${Lab8_dtFin}/Kenya/KEN_adm1_coordinates.dta" ///
		, id(ID) oc(gray) ///
			polygon( ///
				data("${Lab8_dtFin}/Kenya/ke_protected-areas_coordinates.dta") ///
				fc(dkgreen) oc(none))

		graph export ///
				"${Lab8_outRaw}/KEN_adm1_areas.png" ///
			,	replace width(2000)

* Add roads

	use "${Lab8_dtFin}/Kenya/KEN_adm1_database.dta" , clear

	spmap ///
			using "${Lab8_dtFin}/Kenya/KEN_adm1_coordinates.dta" ///
		, id(ID) oc(gray) ///
			polygon( ///
				data("${Lab8_dtFin}/Kenya/ke_protected-areas_coordinates.dta") ///
				fc(dkgreen) oc(none)) ///
			line( ///
				data("${Lab8_dtFin}/Kenya/ke_major-roads_coordinates.dta") ///
				)

		graph export ///
				"${Lab8_outRaw}/KEN_adm1_roads.png" ///
			,	replace width(2000)

* Add campsites

	use "${Lab8_dtFin}/Kenya/KEN_adm1_database.dta" , clear

	spmap ///
			using "${Lab8_dtFin}/Kenya/KEN_adm1_coordinates.dta" ///
		, id(ID) oc(gray) ///
			polygon( ///
				data("${Lab8_dtFin}/Kenya/ke_protected-areas_coordinates.dta") ///
				fc(dkgreen) oc(none) ///
				) ///
			line( ///
				data("${Lab8_dtFin}/Kenya/ke_major-roads_coordinates.dta") ///
				) ///
			point( ///
				data("${Lab8_dtFin}/Kenya/ke_hotels-lodges-campsites_coordinates.dta") ///
				x(_X) y(_Y) size(medium) shape(t) fc(red) oc(black) ///
				)

		graph export ///
				"${Lab8_outRaw}/KEN_adm1_sites.png" ///
			,	replace width(2000)

* Have a lovely day!
