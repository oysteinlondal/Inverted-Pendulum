with Ada.Float_Text_IO;
with Ada.Text_IO;
with Angle; use Angle;
with Ada.Real_Time; use Ada.Real_Time;

package Accelorometer_Reader is

   task Accelorometer_Reader with Priority => 1;

end Accelorometer_Reader;