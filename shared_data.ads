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
        procedure Set (Calculated_Value : in RPM; Motor : in Motor_Direction);
        entry     Get (Value : out RPM; Motor : out Motor_Direction);
    private
        Updated       : Boolean := False;
        Current_Value : RPM;
        Current_Motor         : Motor_Direction;
    end Actuator_Write;


end Shared_Data;