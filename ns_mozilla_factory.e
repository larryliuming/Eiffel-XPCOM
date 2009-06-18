note
	description: "[
					Factory for NS_MOZILLA
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MOZILLA_FACTORY

feature -- Factory methods

	mozilla_singleton: NS_MOZILLA
			-- Get mozilla singleton 
		do
			Result := mozilla_instance_cell.item
		end

feature {NONE} -- Implementation

	mozilla_instance_cell: CELL [NS_MOZILLA]
			-- Mozilla singleton instance
		once
			create Result.put (void)
		end
end
