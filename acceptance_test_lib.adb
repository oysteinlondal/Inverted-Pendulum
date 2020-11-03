package body Acceptance_Test_Lib is

    procedure Acceptance_Test(Max, Min, Value : in Float; Computation_Time, Max_Computation_Time: in Ada.Real_Time.Time_Span; Count : in Integer) is
    begin         
        if Count > 4 then
            raise Recovery_Block_Overload;
        
        elsif Value > Max then
            raise Value_Exceed_Max;   
                
        elsif Value < Min then
            raise Value_Exceed_Max;

        elsif Computation_Time > Max_Computation_Time then
            raise Excecution_Time_Overun;      
        end if;
    end Acceptance_Test;  

end Acceptance_Test_Lib;