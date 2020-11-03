with Ada.Float_Text_IO;
with Ada.Text_IO;
with Angle; use Angle;
with Ada.Real_Time; use Ada.Real_Time;
with Task_Scheduling; use Task_Scheduling;
with Setup; use Setup;
with Shared_Data;
with Meassure_Velocity;
with Meassure_Acceleration;
with Acceptance_Test; use Acceptance_Test;

package Task_Implementations is

   task Gyroscope_Reader     with Priority => 20;
   task Accelerometer_Reader with Priority => 19;
   task Cascade_Controller   with Priority => 18;
   task Actuator_Writer      with Priority => 17;
   
private

   -- Protected types to store and retrive shared data
   Accelerometer_SR : Shared_Data.Sensor_Reading;
   Gyroscope_SR     : Shared_Data.Sensor_Reading;
   Motor_AW         : Shared_Data.Actuator_Write;

   Recoveryblock_Count         : Constant Integer := 0; 
   Recoveryblock_Count_Limit   : Constant Integer := 4;

end Task_Implementations;
