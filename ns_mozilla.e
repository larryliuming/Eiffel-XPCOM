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



feature {NONE} -- Implementation


end
