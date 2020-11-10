package body Shared_Data is
   
    protected body Sensor_Reading is
        procedure Set (Meassured_Value : in Float) is
        begin
            Current_Value := Meassured_Value;
            Updated       := True;
        end Set;

        entry Get (Value : out Float) when Updated is 
        begin
            Value   := Current_Value;
            Updated := False;
        end Get;
    end Sensor_Reading;

    protected body Actuator_Write is
        procedure Set (Calculated_Value : in RPM; Motor : in Motor_Direction) is
        begin
            Current_Value := Calculated_Value;
            Current_Motor := Motor;
            Updated       := True;
        end Set;

        entry Get (Value : out RPM; Motor : out Motor_Direction) when Updated is
        begin
            Value         := Current_Value;
            Motor         := Current_Motor;
            Updated       := False;
        end Get;
    end Actuator_Write;

end Shared_Data;