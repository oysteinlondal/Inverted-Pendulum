package body Setup is
    
    protected body Motor_Setup is
        procedure Calibrate_Motors_If_Required is
        begin
            if not Setup_Done then
                --Calibrating left and right ESC
                Put("Start Setup");
                delay 4.0;
                --Write(3,1000);
                --Set_Analog_Period_Us(20000);
                --Write(28,1000);
                --Set_Analog_Period_Us(20000);
                --NRF52_DK.Time.Delay_Ms(2000);
                --Write(3,2000);
                --Set_Analog_Period_Us(20000);
                --Write(28,2000);
                --Set_Analog_Period_Us(20000);
                --NRF52_DK.Time.Delay_Ms (2000);
                Setup_Done := True;
            end if;
        end Calibrate_Motors_If_Required;
    end Motor_Setup;
    
end Setup;
