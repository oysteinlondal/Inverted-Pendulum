package body Angle is

    function Find_Angle (X_Coordinate, Y_Coordinate : Float) return Float is
    begin

        if Y_Coordinate = 0.0 then

            return Arctan(X_Coordinate/0.0000001); -- Might use exception instead later

        end if;

        return Arctan(X_Coordinate/Y_Coordinate);

    end Find_Angle;

    function To_Degrees (Radians : Float) return Float is
    begin 

        return Radians * (Max_Deg/Pi_As_Float);
   
    end To_Degrees;

    function To_Radians (Degrees : Float) return Float is
    begin

        return Degrees * (Pi_As_Float/Max_Deg);

    end To_Radians;

end Angle;