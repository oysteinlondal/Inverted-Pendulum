with Ada.Text_IO; use Ada.Text_IO;

package Setup is
    
    protected Motor_Setup is
        procedure Calibrate_Motors_If_Required;
    private
        Setup_Done : Boolean := False;
    end Motor_Setup;
    
end Setup;
