note
	description: "[
					Main Eiffel XPCOM runtime binding class
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EIFFEL_WRAPPER

feature {NONE} -- Externals

	c_new_eiffel_xpcom_wrapper: NATURAL
			-- Create a new Eiffel XPCOM wrapper object
		external
			"C++ inline use <ns_eiffel_xpcom_internal.h>"
		alias
			"[
			{
				
				 nsCOMPtr<nsIInterfaceInfoManager> l_interface_manager (do_GetService(NS_INTERFACEINFOMANAGER_SERVICE_CONTRACTID));
				 NS_ASSERTION(l_interface_manager, "Failed to get InterfaceInfoManager");
				 if (!l_interface_manager)
					return NS_ERROR_FAILURE;
				
			}
			]"
		end

end
