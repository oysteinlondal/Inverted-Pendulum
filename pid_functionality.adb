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
        --RPM_Value := Torq_Ref; NOT POSSIBLE!
        RPM_Value := 1500;
    end Map_To_RPM;

end PID_Functionality; 