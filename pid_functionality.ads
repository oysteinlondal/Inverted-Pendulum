with Type_Lib; use Type_Lib;
package PID_Functionality is
    -- Procedures
    procedure Position_Controller  (K_PP     : in Float; Pos_Error : in Float; Vel_Ref : out Float);
    procedure Velocity_Controller  (K_PV     : in Float; Vel_Error : in Float; Torq_Ref : out Float);
    procedure Map_To_RPM           (Torq_Ref : in Float; RPM_Value : out RPM);
end PID_Functionality;