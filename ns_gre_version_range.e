note
	description: "[
					Specifice a version ragne of GRE
					Used by {NS_MOZILLA}
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRE_VERSION_RANGE

create
	make

feature {NONE} -- Initialization

	make (a_lower: STRING; a_lower_inclusive: BOOLEAN; a_upper: STRING; a_upper_inclusive: BOOLEAN)
			-- Creation method
		do
			lower := a_lower
			lower_inclusive := a_lower_inclusive
			upper := a_upper
			upper_inclusive := a_upper_inclusive
		ensure
			set: lower = a_lower and lower_inclusive = a_lower_inclusive and upper = a_upper and upper_inclusive = a_upper_inclusive
		end

feature -- Query

	is_valid (a_version: STRING_GENERAL): BOOLEAN
			-- Check if `a_version' is valid in current range
		do
			if lower_inclusive then
				Result := lower.as_string_32 <= a_version.as_string_32
			else
				Result := lower.as_string_32 < a_version.as_string_32
			end

			if Result then
				if upper_inclusive then
					Result := upper.as_string_32 >= a_version.as_string_32
				else
					Result := upper.as_string_32 > a_version.as_string_32
				end
			end
		end

feature {NONE} -- Implementation

	lower: STRING
			-- GRE version lower range

	lower_inclusive: BOOLEAN
			-- Include lower range?

	upper: STRING
			-- GRE version upper range

	upper_inclusive: BOOLEAN
			-- Inlcude upper range?

end
