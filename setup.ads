with Ada.Text_IO; use Ada.Text_IO;
--with NRF52_DK.Time;
--with NRF52_DK.IOs; use NRF52_DK.IOs;

package Setup is
    
    protected Motor_Setup with Priority => 25 is
        procedure Calibrate_Motors_If_Required;
    private
        Setup_Done : Boolean := False;
    end Motor_Setup;
    
end Setup;
