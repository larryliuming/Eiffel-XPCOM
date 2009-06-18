
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


