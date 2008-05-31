/*
 * AnalogInput
 * by DojoDave <http://www.0j0.org>
 *
 * Turns on and off a light emitting diode(LED) connected to digital  
 * pin 13. The amount of time the LED will be on and off depends on
 * the value obtained by analogRead(). In the easiest case we connect
 * a potentiometer to analog pin 2.
 *
 * http://www.arduino.cc/en/Tutorial/AnalogInput
 */

int ledPin = 13;   // select the pin for the LED
int val = 0;    // variable to store the value for the LED
bool busted = 0;  // simple error variable 'is it busted?'

int potPin = 2;    // select the input pin for the potentiometer
int pVal = 0;       // variable to store the value coming from the potentiometer

int lightSensor = 3;    // select the input pin for the light sensor
int lVal = 0;   // variable to store the value coming from the light sensor


void setup() {
  pinMode(ledPin, OUTPUT);  // declare the ledPin as an OUTPUT
  Serial.begin(9600);
}

void loop() {
  pVal = analogRead(potPin);    // read the value from the potentiometer
  lVal = analogRead(lightSensor);   // read the value from the light sensor

  // Lame algorithms to make the values more discernible physically
  lVal = (lVal - 500) * 4;
  val = (lVal - pVal) - 800;
  
  // Error-checking - if val goes below 0, the loop is borked, revert to 1.
  if (val < 1) {
    val = 1;
    busted = 1;
  }

  if (busted) {
    Serial.print("Busted! Value too low, reverted to 1.\n");
    busted = 0;
  } else {  
    Serial.print("light: ");
    Serial.print(lVal);
    Serial.print("  pot: ");
    Serial.print(pVal);
    Serial.print("  delay: ");
    Serial.print(val);
    Serial.print("\n");
  } 
    
  digitalWrite(ledPin, HIGH);  // turn the ledPin on
  delay(val);                  // stop the program for some time
  digitalWrite(ledPin, LOW);   // turn the ledPin off
  delay(val);                  // stop the program for some time
  
}
