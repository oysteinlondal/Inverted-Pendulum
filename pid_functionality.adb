package body PID_Functionality is

    procedure Position_Controller(K_PP : in Float; Pos_Error : in Float; Vel_Ref : out Float) is
    begin
        Vel_Ref := K_PP * Pos_Error;
    end Position_Controller;

    procedure Velocity_Controller(K_PV : in Float; Vel_Error : in Float; Torq_Ref : out Float) is
    begin
        Torq_Ref := K_PV * Vel_Error;
    end Velocity_Controller;

    procedure Map_To_RPM (Torq_Ref : in Float; RPM_Value : out RPM) is
    begin
        if Torq_Ref > 0 then
            RPM_Value := 416 * Torq_Ref + 1000;
        else
            RPM_Value := 416 * (-(Torq_Ref)) + 1000;
        end if;  
    end Map_To_RPM;

end PID_Functionality; 
