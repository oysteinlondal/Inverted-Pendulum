with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;


package Cascade_Controller is
   Ret_Angle    : Float := Float(Angle);
   Ret_Velocity : Float := Float(Velocity);
   kp           : Float := 1.5;
   kp2          : Float := 1.0;
   ut1          : Float := 0.0;
   ut2          : Float := 0.0
   function To_Radians(Ret_Velocity : Float) return Float;
   function Inner_Loop(ut           : Float) return Float;
   function Power_To_Engine(ut2     : Float) return Float;
     
end Cascade_Controller;
