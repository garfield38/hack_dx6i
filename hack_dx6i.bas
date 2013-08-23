' *****************************************************************************
' * Project: Automatic Timer On/Off for Spektrum Dx6i                         *
' * Author: Stephane Driussi                                                  *
' * Release: 1.0                                                              *
' * Date: August 15, 2013                                                     *
' *****************************************************************************
'          /-------+
'       NC | 1   8 | VCC
' Throttle | 2   7 | NC
'     Gear | 3   6 | NC
'      GND | 4   5 | Trainer
'          +-------+
'           Attiny85

$regfile = "attiny85.dat"
$crystal = 1000000
$hwstack = 40
$swstack = 16
$framesize = 32

Const Trainer = 0             ' Trainer  pin.5
Const Gear = 4                ' Gear     pin.3
Config Portb.trainer = Input  ' Trainer switch Output.
Set Portb0                    ' Enable pull up
Config Portb.gear = Input     ' Gear switch
Config Adc = Single , Prescaler = Auto
Dim Throttle As Word
Dim Armed As Bit

Armed = 0
Waitms 100
' Check if trhottle is in low or middle position
Throttle = Getadc(3)          ' Throttle pin.2
If Throttle < 100 Then
  Do                          ' Low position, the timer is managed by throttle
    Throttle = Getadc(3)
    If Throttle > 100 And Armed = 0 Then
      Armed = 1
      Gosub Sendpulsetrainer
    End If
    If Throttle < 50 And Armed = 1 Then
      Armed = 0
      Gosub Sendpulsetrainer
    End If
    Waitms 50
  Loop
Else
  Do                          ' Middle position, timer activated by Gear switch
    If Pinb.gear = 1 Then
      Bitwait Pinb.gear , Reset
    Else
      Bitwait Pinb.gear , Set
    End If
    Gosub Sendpulsetrainer
    Waitms 50
  Loop
End If

Sendpulsetrainer:             ' Change direction of Trainer pin
Ddrb = &B00000001
Waitms 200
Ddrb = &B00000000
Return