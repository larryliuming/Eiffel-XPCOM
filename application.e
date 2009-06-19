indexing
	description : "eiifel_xpcom application root class"
	date        : "$Date: 2008-12-29 15:41:59 -0800 (Mon, 29 Dec 2008) $"
	revision    : "$Revision: 76432 $"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_gre_path: FILE_NAME
		do
			create moziila_factory
			mozilla := moziila_factory.mozilla_singleton
			create gre_version_range.make ("1.9.0", true, "2.0", false)

			l_gre_path := mozilla.get_gre_path_with_properties (<<gre_version_range>>, void)
		end

feature {NONE} -- Implementation

	eiffel_wrapper: NS_EIFFEL_WRAPPER
			-- Main Eiffel XPCOM wrapper

	moziila_factory: NS_MOZILLA_FACTORY
			--

	mozilla: NS_MOZILLA
			--

	gre_version_range: NS_GRE_VERSION_RANGE
			--

	gre: NS_GRE
			--
			
end
