note
	description: "[
				
					Users should use {NS_MOZILLA_FACTORY} to get current instance
					
				 A singleton class which provides access to the Mozilla browser.  Requires
				 that XULRunner be installed on the user's system.
				 <p>
				 You would use to class to find a XULRunner installation, setup a profile (if
				 necessary), and initialize embedding.  A typical scenario would look like
				 this:
				 </p><pre>
				 Mozilla mozilla = Mozilla.getInstance();
				 GREVersionRange[] range = new GREVersionRange[1];
				 range[0] = new GREVersionRange("1.8.0.*", false, "1.8.1.*", true);
				 try {
				    File grePath = Mozilla.getGREPathWithProperties(range, null);
				    mozilla.initialize(grePath);
				    profLock = mozilla.lockProfileDirectory(profileDir);
				    // LocationProvider is a user class that implements IAppFileLocProvider
				    LocationProvider locProvider = new LocationProvider(grePath, profileDir);
				    mozilla.initEmbedding(grePath, grePath, locProvider);
				    mozilla.notifyProfile();
				 } catch (XPCOMInitializationException xie) {
				    // handle exception
				 } catch (XPCOMException xe) {
				   // handle exception
				 }
				 </pre>
				  
				 @see http://www.mozilla.org/projects/embedding/GRE.html


																									]"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_MOZILLA

feature -- Initialization

feature -- Command

feature -- Query

	get_gre_path_with_properties (a_versions: ARRAY [NS_GRE_VERSION_RANGE]; a_properties: HASH_TABLE [STRING_GENERAL, STRING_GENERAL]): FILE_NAME
				--   Locates the path of a GRE with the specified properties.  This method
				--   will only return GREs that support Java embedding (looks for the
				--   presence of "javaxpcom.jar").
				--   <p>
				--   Currently this uses a "first-fit" algorithm, it does not select
				--   the newest available GRE.
				--
				--   @param aVersions        An array of version ranges: if any version range
				--                           matches, the GRE is considered acceptable.
				--   @param aProperties      A list of GRE property/value pairs which must
				--                           all be satisfied.  This parameter is ignored on
				--                           Macintosh, because of the manner in which the
				--                           XUL frameworks are installed.
				--      @return                 A file object of the appropriate path. If
				--                           the "local" GRE is specified (via the USE_LOCAL_GRE
				--                           environment variable, for example), returns
				--                           <code>null</code>.
				--      @throws FileNotFoundException if an appropriate GRE could not be found
			require
				a_version_valid: a_versions /= Void and then a_versions.count >= 1
			local
				l_env: STRING
				l_platform: PLATFORM
			do
			    -- if GRE_HOME is in the environment, use that GRE
			    l_env := get_environment_value("GRE_HOME");
			    if l_env /= Void then

			    else
				    -- the Gecko bits that sit next to the application or in the PATH
				    -- FIXME: Don't understand... adapted from JavaXPCOM Mozilla.java
				    l_env := get_environment_value("USE_LOCAL_GRE");
				    if (l_env /= Void) then

				    else
				   		-- Search for GRE in platform specific locations.  We want a GRE that
				   		-- supports Eiffel, so we look for the "eiffelxpcom" property by default.
				   		create l_platform
				   		if l_platform.is_windows then
							Result := get_GRE_path_windows (a_versions, a_properties)
				   		elseif l_platform.is_unix then

				   		elseif l_platform.is_mac then

				   		else
				   			check platform_not_supported: False end
				   		end
				    end
			    end

			    if Result = Void then
			    	-- Throw exception here
			    end
			ensure

			end


feature {NONE} -- Implementation

	get_environment_value (a_string: STRING_GENERAL): STRING_32
			--
		do

		end

	get_GRE_path_windows (a_versions: ARRAY [NS_GRE_VERSION_RANGE]; a_properties: HASH_TABLE [STRING_GENERAL, STRING_GENERAL]): FILE_NAME
			--
		local
			l_temp_string: STRING
		do
			l_temp_string := "Software\\mozilla.org\\GRE"
			Result := get_GRE_path_from_reg_key ("HKEY_CURRENT_USER\\" + l_temp_string)
			if Result = Void then
				Result := get_GRE_path_from_reg_key ("HKEY_LOCAL_MACHINE\\" + l_temp_string)
			end
		end

	get_GRE_path_from_reg_key (a_key: STRING): FILE_NAME
			--
		do

		end

end
