with Ada.Real_Time;
with Exception_Declarations; use Exception_Declarations;
package Acceptance_Test_Lib is

    procedure Acceptance_Test(Max, Min, Value : in Float; Computation_Time, Max_Computation_Time: in Ada.Real_Time.Time_Span; Count : in Integer); 

end Acceptance_Test_Lib;