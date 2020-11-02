with ada.Exceptions;
package Exceptions is
   Value_Exceed_Max : Exception;
   Value_Exceed_Min : Exception;
   Excecution_Time_Overun : Exception;
   Unknown_Error : Exception;
   Recovery_Block_Overload : Exception;
    --  Like an object. *NOT* a type !
end Exceptions;
