package Shared_Data is
   
    protected type Sensor_Reading is
        procedure Set (Meassured_Value : in Float);
        entry     Get (Value : out Float);
    private
        Updated       : Boolean := False;
        Current_Value : Float;
    end Sensor_Reading;

    Accelerometer_SR : Sensor_Reading;
    Gyroscope_SR     : Sensor_Reading;

    protected Actuator_Write is
        procedure Set (Calculated_Value : in Natural);
        entry     Get (Value : out Natural);
    private
        Updated       : Boolean := False;
        Current_Value : Natural;
    end Actuator_Write;


end Shared_Data;