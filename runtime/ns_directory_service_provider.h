#ifndef _ns_directory_service_provider_h_
#define _ns_directory_service_provider_h_

#include "ns_eiffel_xpcom_internal.h"
#include "nsIDirectoryService.h"
#include "nsStringAPI.h"
#include "nsILocalFile.h"
//for XRE_InitEmbedding
#include "nsXULAppAPI.h"
#include "nsISimpleEnumerator.h"

//define Eiffel callback function type
typedef void
#ifndef EIF_IL_DLL
	(* eiffel_get_file_function_type)
#else
	(__stdcall* eiffel_get_file_function_type)
#endif
	(
#ifndef EIF_IL_DLL
		void*,
#endif
		PRUnichar**
	);

//define Eiffel callback function type
typedef void
#ifndef EIF_IL_DLL
	(* eiffel_get_files_function_type)
#else
	(__stdcall* eiffel_get_files_function_type)
#endif
	(
#ifndef EIF_IL_DLL
		void*,
#endif
		PRUnichar***,
		PRUint32*
	);

//declare Eiffel version of nsIDirectoryServiceProvider2
class ns_eiffel_directory_service_provider: public nsIDirectoryServiceProvider2
{
public:
  ns_eiffel_directory_service_provider(void *a_eiffel_get_file_function, void *a_eiffel_get_files_function, void *a_current_object);
  ~ns_eiffel_directory_service_provider();

  NS_DECL_ISUPPORTS
  NS_DECL_NSIDIRECTORYSERVICEPROVIDER
  NS_DECL_NSIDIRECTORYSERVICEPROVIDER2

private:
  eiffel_get_file_function_type eiffel_get_file_function;
  eiffel_get_files_function_type eiffel_get_files_function;
  void *current_eiffel_object;
};

//*** Implementation ***

ns_eiffel_directory_service_provider::ns_eiffel_directory_service_provider(void *a_eiffel_get_file_function, void *a_eiffel_get_files_function, void *a_current_object)
{
 eiffel_get_file_function = (eiffel_get_file_function_type) a_eiffel_get_file_function;
 eiffel_get_files_function =(eiffel_get_files_function_type) a_eiffel_get_files_function;
 current_eiffel_object = a_current_object;
}

ns_eiffel_directory_service_provider::~ns_eiffel_directory_service_provider()
{
  
}

NS_IMPL_ISUPPORTS2(ns_eiffel_directory_service_provider,
                   nsIDirectoryServiceProvider,
                   nsIDirectoryServiceProvider2)

//*** Implementation for ns_directory_service_provider::GetFile ***
// nsIDirectoryServiceProvider

NS_IMETHODIMP
ns_eiffel_directory_service_provider::GetFile(const char* aProp, PRBool* aIsPersistant,
                                   nsIFile** a_result)
{
  // Set nsIFile result value
  nsCOMPtr<nsILocalFile> localFile;

  //get file path (type is C char*) from Eiffel function
  PRUnichar* l_buff;
  eiffel_get_file_function(
#ifndef EIF_IL_DLL
				current_eiffel_object,
#endif
				&l_buff
		  );
  nsAutoString l_str(l_buff);
//  nsString* l_str = new nsString(l_buff);
	
  nsCOMPtr<nsILocalFile> l_localFile;
  nsresult l_result = NS_NewLocalFile(l_str, false, getter_AddRefs(l_localFile));
 
  if (NS_SUCCEEDED(l_result)) {
    return localFile->QueryInterface(NS_GET_IID(nsIFile), (void**)a_result);
  }

  return l_result;
}

//*** Implementation for ns_directory_service_provider::GetFiles ***
// nsIDirectoryServiceProvider2

class Eiffel_Directory_Enumerator : public nsISimpleEnumerator
{
public:
  NS_DECL_ISUPPORTS

  Eiffel_Directory_Enumerator(PRUnichar** a_c_array, PRUint32 a_size)
    : mIndex(0)
  {
	c_array = a_c_array;
	mArraySize = a_size;
  }

  ~Eiffel_Directory_Enumerator()
  {

  }

  NS_IMETHOD HasMoreElements(PRBool* aResult)
  {
    if (!c_array) {
      *aResult = PR_FALSE;
    } else {
      *aResult = (mIndex < mArraySize);
    }
    return NS_OK;
  }

  NS_IMETHOD GetNext(nsISupports** aResult)
  {
    nsresult rv = NS_ERROR_FAILURE;
	
    PRUnichar *l_item = c_array[mIndex];
    mIndex + mIndex + 1;

    if (l_item) {
	const PRUnichar* l_buf = l_item;
	nsAutoString l_path (l_buf);
   //  	nsAString* l_path;// = new nsString(l_buf);

	nsCOMPtr<nsILocalFile> l_local_file;
	rv = NS_NewLocalFile(l_path, false, getter_AddRefs(l_local_file));

      if (NS_SUCCEEDED(rv)) {
        return l_local_file->QueryInterface(NS_GET_IID(nsIFile), (void**)aResult);
      }
    }

    return NS_ERROR_FAILURE;
  }

private:
  PRUnichar**  c_array;
  PRUint32      mArraySize;
  PRUint32      mIndex;
};

NS_IMPL_ISUPPORTS1(Eiffel_Directory_Enumerator, nsISimpleEnumerator)

NS_IMETHODIMP
ns_eiffel_directory_service_provider::GetFiles(const char* aProp,
                                    nsISimpleEnumerator** aResult)
{
  nsresult rv = NS_OK;

  if (NS_SUCCEEDED(rv)) {
	// Parse return value
 	//get file path (type is C char*) from Eiffel function
	PRUnichar ** l_buff;
	PRUint32 l_count;
	eiffel_get_files_function(
#ifndef EIF_IL_DLL
			current_eiffel_object,
#endif
			&l_buff,
			&l_count
		  ); 
    *aResult = new Eiffel_Directory_Enumerator(l_buff, l_count);
    NS_ADDREF(*aResult);
    return NS_OK;
  }

  // Handle error conditions
  *aResult = nsnull;
  return rv;
}



#endif  //_ns_directory_service_provider_h_

