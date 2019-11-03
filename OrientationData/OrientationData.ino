/*
 * Send orientation data to processing
 */

#include <Arduino_LSM6DS3.h>
#include <AP_Sync.h>

AP_Sync sendData(Serial);


long lastRead;

//Declare variables
float angleX;
float angleY;
float angleZ;

void setup() 
{
  Serial.begin(9600);
  if(!IMU.begin())
  {
  Serial.println("OFF");   
  }
}

void loop() 
{
float dsX, dsY, dsZ;

    if (IMU.gyroscopeAvailable())
    {
    IMU.readGyroscope(dsX, dsY, dsZ);
    
    float readInterval = ((millis()-lastRead)/1000.0);
    angleX += dsX*readInterval;
    angleY += dsY*readInterval;
    angleZ += dsZ*readInterval;

    ///Send data to Processing
    sendData.sync("ax",angleX);
    sendData.sync("ay",angleY);
    sendData.sync("az",angleZ);

    lastRead=millis();
    }



}
