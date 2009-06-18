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
		do
			--| Add your code here
		end

feature {NONE} -- Implementation

	eiffel_wrapper: NS_EIFFEL_WRAPPER
			-- Main Eiffel XPCOM wrapper

	moziila_factory: NS_MOZILLA_FACTORY
			--

	mozilla: NS_MOZILLA
			--

end
