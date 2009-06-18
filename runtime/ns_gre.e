note
	description: "[
					Gecko runtime environment
					This class will be compiled as a DLL (or so, dylib.. on non-Windows platforms)
					The DLL name should be "eiffelxpcom.dll"
																									]"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_GRE

feature -- Command

	init_embedding (a_lib_xul_directory, a_app_directory: POINTER; a_app_dir_provider: POINTER)
			-- Init embedding
			-- `a_lib_xul_directory' and `a_app_directory' type are C char*
		local
			l_result: like cpp_init_embedding
		do
			check not_fully_implemented: False end
			l_result := cpp_init_embedding (a_lib_xul_directory, a_app_directory, a_app_dir_provider)
		end

	term_Embedding
			-- Terminate embedding
		do

		end

	lock_profile_directory
			--
		do

		end

	notify_profile
			--
		do

		end

feature {NONE} -- C externals

	cpp_init_embedding (a_lib_xul_directory, a_app_directory: POINTER; a_app_dir_provider: POINTER): NATURAL
			-- `a_lib_xul_directory' is C char*
			-- `a_app_directory' is C char*
			-- Learning from
			-- C:\xpcom\firefox-3.0.9-source\mozilla\extensions\java\xpcom\bin\nsJavaInterfaces.cpp InitEmbedding_Impl
		external
			"C++ inline use <eiffel_xpcom_wrapper.cpp>"
		alias
			"[
			{
				nsresult l_result;
				
				// create an nsILocalFile from given `a_lib_xul_directory'
  				nsCOMPtr<nsILocalFile> l_libXULDir;
  				nsString* l_str = new nsString($a_lib_xul_directory);
  				l_result := NS_NewLocalFile(*l_str, false, &l_libXULDir);
  				delete l_str;
  				
  				nsCOMPtr<nsILocalFile> l_appDir;
  				l_str = new nsString($a_app_directory);
  				l_result := NS_NewLocalFile(*l_str, false, &l_appDir;);  				
  				delete l_str;
  				
  				// create nsAppFileLocProviderProxy from given ... FIXME, need implemente a Eiffel_app_dir_provider
  				// like C:\xpcom\firefox-3.0.9-source\mozilla\extensions\java\xpcom\src\nsAppFileLocProviderProxy.cpp
  				nsCOMPtr<nsIDirectoryServiceProvider> l_provider;
			    l_result = NS_NewAppFileLocProviderProxy($a_app_dir_provider,
			                                       getter_AddRefs(l_provider;));  				
  				NS_ENSURE_SUCCESS(l_result, l_result);
  				
  				
  				// init libXUL
  				return XRE_InitEmbedding(libXULDir, appDir, provider, nsnull, 0);
			}
			]"
		end

end
