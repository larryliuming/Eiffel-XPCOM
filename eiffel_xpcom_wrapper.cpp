
/* 
 * NO_NSPR_10_SUPPORT disables the inclusion 
 * of obsolete/protypes.h, whose int16, uint16, 
 * int32, and uint32 typedefs conflict
 */ 
#define NO_NSPR_10_SUPPORT

#define XP_WIN
#define XP_WIN32

//Standalone Glue
#include "xpcom-config.h"

#include "nsCOMPtr.h"
#include "nsServiceManagerUtils.h"
#include "nsIInterfaceInfoManager.h"

nsresult new_eiffel_xpcom_wrapper (nsISupports* aXPCOMObject,
                        const nsIID& aIID, EIF_POINTER aObjectLoader,
                        EIF_POINTER* aResult)

{
	 nsCOMPtr<nsIInterfaceInfoManager> l_interface_manager (do_GetService(NS_INTERFACEINFOMANAGER_SERVICE_CONTRACTID));
	 NS_ASSERTION(l_interface_manager, "Failed to get InterfaceInfoManager");
	 if (!l_interface_manager)
	  return NS_ERROR_FAILURE;
}
