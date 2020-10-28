with Ada.Float_Text_IO;
with Ada.Text_IO;
with Angle; use Angle;
with Ada.Real_Time; use Ada.Real_Time;
with Task_Scheduling; use Task_Scheduling;
with Shared_Data;

package Task_Implementations is

   task Gyroscope_Reader     with Priority => 20;
   task Accelerometer_Reader with Priority => 19;
   task Cascade_Controller   with Priority => 18;
   task Actuator_Writer      with Priority => 17;

end Task_Implementations;