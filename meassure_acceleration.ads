--with Imu.Library; use Imu.Library
with Exception_Declarations; use Exception_Declarations;

package Meassure_Acceleration is
    procedure Retrieve_Acceleration (Acc_X, Acc_Y : out Float);
private
    X_Coordinate : Float;
    Y_Coordinate : Float;
    Z_Coordinate : Float;
end Meassure_Acceleration;
