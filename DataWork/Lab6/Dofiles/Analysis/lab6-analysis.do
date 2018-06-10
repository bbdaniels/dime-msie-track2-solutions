* Suggested solution for Lab 6

	* Install programs

		net install ///
			"https://raw.githubusercontent.com/worldbank/stata/master/wb_git_install/wb_git_install.pkg"

		wb_git_install sumStats
		wb_git_install xml_tab

	* Use data

		use "${Lab6_dtFin}/hh_roster.dta" ///
		, clear

	* Create variable locals

		local controls hh_fs_01 hh_fs_03 hh_fs_05 hh_inc_01 hh_inc_02
		local outcome1 hh_inc_08 // Livestock sales
		local outcome2 hh_inc_12 // LWH terracing

* Task 1: Summary statistics

	* Clean variables of missings

		foreach var of varlist  `controls' {
				replace `var' = .a if `var' == -88
			}

	* Summarize food security

		sumStats ///
			( `controls' `outcome1' `outcome2' ) ///
			using "${Lab6_outRaw}/task1_1.xls" ///
		, replace stats(N mean median sd min max)

	* Summarize by treatment/control

		sumStats ///
			(`controls' `outcome1' `outcome2' if hh_treatment == 0) ///
			(`controls' `outcome1' `outcome2' if hh_treatment == 1) ///
			(`controls' `outcome1' `outcome2' if tag_hh == 1) ///
			using "${Lab6_outRaw}/task1_2.xls" ///
		, replace stats(N mean median sd min max)

* Task 2: Balance table


* Task 3: Regression table

	* Regressions

		reg `outcome1' ///
			`controls' ///
		, cl(hh_id)
			est sto reg1

		reg `outcome2' ///
			`controls' ///
		, cl(hh_id)
			est sto reg2

		reg `outcome1' ///
			hh_treatment ///
			`controls' ///
		, cl(hh_id)
			est sto reg3

		reg `outcome1' ///
			hh_treatment ///
			`controls' ///
		, cl(hh_id)
			est sto reg4

	* Output: basic

		xml_tab ///
			reg1 reg2 reg3 reg4 ///
		using "${Lab6_outRaw}/task3_1.xls" ///
		, replace

	* Output: cleaned

		xml_tab ///
			reg1 reg2 reg3 reg4 ///
		using "${Lab6_outRaw}/task3_1_clean.xls" ///
		, replace below stats(N r2) ///
			keep(hh_treatment `controls' _cons) ///
			lines(COL_NAMES 3 LAST_ROW 3) ///
			cnames("Livestock" "LWH Terracing" "Livestock" "LWH Terracing") ///
			format((S2110) (SCCB0 N2302))

* Have a lovely day!
