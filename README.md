# Microphone Cascade
Simple FFT Buffer visualization. Uses Adafruit's Circuit Playground Classic.

The X axis represents the 32 bands captured by the Curcuit Playground's microphone with the [mic_FFT_classic demo](https://github.com/adafruit/Adafruit_CircuitPlayground/blob/master/examples/Microphone_Demos/mic_FFT_classic/mic_FFT_classic.ino). The color corresponds to the intensity of that particular frequency. Color LUT was generated in Grasshopper 3D and copied into the Processing sketch.

![micCascade](https://user-images.githubusercontent.com/1014562/62833208-53691a00-bc3b-11e9-93d0-181b7db275f5.gif)

This repo contains two scripts: 
- [`Arduino_writeMic`](Arduino_writeMic) - Exactly the same as the Adafruit Circuit Playground [mic_FFT_classic.ino](https://github.com/adafruit/Adafruit_CircuitPlayground/blob/master/examples/Microphone_Demos/mic_FFT_classic/mic_FFT_classic.ino) demo, except added Serial communication.
- [`Processing_readMic`](Processing_readMic) - Listens to the serial port and creates a visualization of the incoming buffer. Be sure to edit the script to reference the correct serial device.
