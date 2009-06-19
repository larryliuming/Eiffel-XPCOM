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
			l_result := cpp_init_embedding (a_lib_xul_directory, a_app_directory, $Current, $get_file, $get_files)
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

feature {NONE} -- Eiffel function C callbacks

	get_file (a_file_path: TYPED_POINTER [POINTER])
			-- Callback function used by C++ ns_directory_service_provider::GetFile
			-- `a_file_path's item type is C char*
		do

		end

	get_files (a_files_path: TYPED_POINTER [POINTER])
			-- Callback function used by C++ ns_directory_service_provider::GetFiles
			-- `a_files_path's item type is C char*[]
		do

		end

feature {NONE} -- C externals

	cpp_init_embedding (a_lib_xul_directory, a_app_directory: POINTER; a_current_object, a_get_file_function, a_get_files_function: POINTER): NATURAL
			-- `a_lib_xul_directory' is C char*
			-- `a_app_directory' is C char*
			-- Learning from
			-- C:\xpcom\firefox-3.0.9-source\mozilla\extensions\java\xpcom\bin\nsJavaInterfaces.cpp InitEmbedding_Impl
		external
			"C++ inline use <ns_directory_service_provider.h>"
		alias
			"[
			{
				nsresult l_result;
				
				// create an nsILocalFile from given `a_lib_xul_directory'
  				nsCOMPtr<nsILocalFile> l_libXULDir;
  				PRUnichar* l_char = (PRUnichar*) $a_lib_xul_directory;
  				nsString* l_str = new nsString(l_char);
  				l_result = NS_NewLocalFile(*l_str, false, getter_AddRefs(l_libXULDir));
  				delete l_str;
  				
  				l_char = (PRUnichar*) $a_app_directory;
  				l_str = new nsString(l_char);
  				nsCOMPtr<nsILocalFile> l_appDir;
  				l_result = NS_NewLocalFile(*l_str, false, getter_AddRefs(l_appDir));  				
  				delete l_str;
  				
  				// create ns_eiffel_directory_service_provider from given data
  				nsCOMPtr<ns_eiffel_directory_service_provider> l_provider =
						(new ns_eiffel_directory_service_provider ($a_get_file_function,
																			$a_get_files_function,
																			$a_current_object));  				
						
  				NS_ENSURE_SUCCESS(l_result, l_result);  				
  				
  				// init libXUL
  				return XRE_InitEmbedding(l_libXULDir, l_appDir, l_provider, nsnull, 0);
			}
			]"
		end

end
