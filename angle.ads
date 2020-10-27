with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;

package Angle is

   Pi_As_Float : Constant Float := Float(Pi);
   Max_Deg   : Constant Float := 180.0;

   function To_Degrees (Radians : Float) return Float;
   function To_Radians (Degrees : Float) return Float;
   function Find_Angle (X_Coordinate, Y_Coordinate : Float) return Float;

end Angle;