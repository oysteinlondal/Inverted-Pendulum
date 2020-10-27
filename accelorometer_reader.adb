package body Accelorometer_Reader is

    task body Accelorometer_Reader is 

      Angle                      : Float;

      Sum_Accelerometer_Xvalues  : Float := 0.0;
      Sum_Accelerometer_Yvalues  : Float := 0.0;

      Avg_Accelerometer_Xvalue   : Float := 0.0;
      Avg_Accelerometer_Yvalue   : Float := 0.0;

      New_Xvalue                 : Float;
      New_Yvalue                 : Float;

      Count_Accelerometer_Reads  : Natural := 0;
      Max_Accelerometer_Reads    : Natural := 5;

      -- Timing Constraints
      Period                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
      Next_Period                : Ada.Real_Time.Time;

      begin

         Next_Period := Ada.Real_Time.Clock + Period; -- Define next time to run
         loop

               delay until Next_Period; -- Wait for new period 

               Count_Accelerometer_Reads := (Count_Accelerometer_Reads + 1) mod Max_Accelerometer_Reads;

               New_Xvalue := 3.0;--NANO.AccX;
               New_Yvalue := 2.0;--NANO.AccY;

               Sum_Accelerometer_Xvalues := Sum_Accelerometer_Xvalues + New_Xvalue;
               Sum_Accelerometer_Yvalues := Sum_Accelerometer_Yvalues + New_Yvalue;

               if Count_Accelerometer_Reads = 0 then

                  Avg_Accelerometer_Xvalue := Sum_Accelerometer_Xvalues / Float(Count_Accelerometer_Reads);
                  Avg_Accelerometer_Yvalue := Sum_Accelerometer_Yvalues / Float(Count_Accelerometer_Reads);

                  Angle := Find_Angle(Avg_Accelerometer_Xvalue, Avg_Accelerometer_Yvalue);

                  Ada.Float_Text_IO.Put(Angle);

                  -- Reset

                  Sum_Accelerometer_Xvalues := 0.0;
                  Sum_Accelerometer_Yvalues := 0.0;

               end if;

               Next_Period := Next_Period + Period;

         end loop;

   end Accelorometer_Reader;
   
end Accelorometer_Reader;