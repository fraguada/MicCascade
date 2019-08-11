# Microphone Cascade
Simple FFT Buffer visualization. Uses Adafruit's Circuit Playground Classic.

![](micCascade.gif)

This repo contains two scripts: 
- [`Arduino_writeMic`](Arduino_writeMic) - Exactly the same as the Adafruit Circuit Playground [mic_FFT_classic.ino](https://github.com/adafruit/Adafruit_CircuitPlayground/blob/master/examples/Microphone_Demos/mic_FFT_classic/mic_FFT_classic.ino) demo, except added Serial communication.
- [`Processing_readMic`](Processing_readMic) - Listens to the serial port and creates a visualization of the incoming buffer. Be sure to edit the script to reference the correct serial device.