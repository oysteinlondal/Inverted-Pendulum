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
        procedure Set (Calculated_Value : in Natural) is
        begin
            Current_Value := Calculated_Value;
            Updated       := True;
        end Set;

        entry Get (Value : out Natural) when Updated is
        begin
            Value   := Current_Value;
            Updated := False;
        end Get;
    end Actuator_Write;

end Shared_Data;