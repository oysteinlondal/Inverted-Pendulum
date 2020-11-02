package body Setup is
    
    protected body Motor_Setup is
        procedure Calibrate_Motors_If_Required is
        begin
            if not Setup_Done then
                Put("Start Setup");
                delay 2.0;
                Setup_Done := True;
            end if;
        end Calibrate_Motors_If_Required;
    end Motor_Setup;
    
end Setup;