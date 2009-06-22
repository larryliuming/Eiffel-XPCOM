//Only Eiffel XPCOM runtime need MOZILLA_INTERNAL_API
//#define XPCOM_GLUE
#include "xpcom-config.h"
/* 
 * NO_NSPR_10_SUPPORT disables the inclusion 
 * of obsolete/protypes.h, whose int16, uint16, 
 * int32, and uint32 typedefs conflict
 */ 
#define NO_NSPR_10_SUPPORT

#define XP_WIN
#define XP_WIN32

#include "nsCOMPtr.h"
#include "nsServiceManagerUtils.h"
#include "nsIInterfaceInfoManager.h"
