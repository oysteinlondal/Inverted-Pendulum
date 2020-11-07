with Type_Lib; use Type_Lib;
package Shared_Data is
   
    protected type Sensor_Reading is
        procedure Set (Meassured_Value : in Float);
        entry     Get (Value : out Float);
    private
        Updated       : Boolean := False;
        Current_Value : Float;
    end Sensor_Reading;

    protected type Actuator_Write is
        procedure Set (Calculated_Value : in RPM);
        entry     Get (Value : out RPM);
    private
        Updated       : Boolean := False;
        Current_Value : RPM;
    end Actuator_Write;


end Shared_Data;