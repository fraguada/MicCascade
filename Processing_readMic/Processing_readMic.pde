import processing.serial.*;

Serial myPort;  // The serial port
int lf = 10;    // Linefeed in ASCII
String myString = null;

// color LUT, generated with Grasshopper :)
color[] colors = {#4B6BA9, #4B6BA9, #4B6BA9, #4C6CA9, #4C6CAA, #4C6CAA, #4D6DAB, #4E6EAB, #4F6FAC, #5070AD, #5171AE, #5272AF, #5373B0, #5574B1, #5676B2, #5877B3, #5979B5, #5B7BB6, #5D7DB8, #5F7EB9, #6180BB, #6382BC, #6584BE, #6786C0, #6989C2, #6B8BC4, #6E8DC5, #708FC7, #7292C9, #7594CB, #7796CD, #7A99CF, #7C9BD1, #7E9DD3, #81A0D5, #83A2D7, #86A4D9, #88A7DB, #8AA9DD, #8DABDE, #8FADE0, #91B0E2, #93B2E4, #95B4E6, #97B6E7, #99B8E9, #9BB9EA, #9DBBEC, #9FBDED, #A0BFEF, #A2C0F0, #A3C2F1, #A5C3F2, #A6C4F3, #A7C5F4, #A8C6F5, #A9C7F6, #AAC8F7, #ABC9F7, #ACCAF8, #ACCAF8, #ACCAF9, #ADCBF9, #ADCBF9, #ADCBF9, #ADCBF9, #ADCBF9, #ADCBF8, #AECBF7, #AECCF7, #AFCCF5, #AFCCF4, #B0CDF3, #B1CDF1, #B2CDEF, #B3CEED, #B4CEEB, #B5CFE9, #B6D0E6, #B7D0E4, #B9D1E1, #BAD2DE, #BCD2DB, #BDD3D8, #BFD4D4, #C1D5D1, #C2D6CD, #C4D7CA, #C6D8C6, #C8D9C2, #CADABE, #CCDBBB, #CEDCB7, #D0DCB3, #D2DDAF, #D4DEAB, #D6E0A6, #D7E1A2, #D9E29E, #DBE39A, #DDE396, #DFE492, #E1E58F, #E3E68B, #E5E787, #E7E883, #E9E980, #EAEA7C, #ECEB79, #EEEC75, #EFED72, #F1ED6F, #F2EE6C, #F4EF69, #F5EF67, #F6F064, #F7F162, #F8F160, #F9F25E, #FAF25C, #FBF25A, #FCF359, #FCF358, #FDF356, #FDF456, #FEF455, #FEF454, #FEF454, #FEF454, #FEF454, #FEF454, #FEF354, #FEF353, #FEF253, #FEF152, #FDF152, #FDF051, #FDEE50, #FDED4F, #FDEC4E, #FCEA4D, #FCE84C, #FCE74A, #FBE549, #FBE348, #FBE146, #FADE45, #FADC43, #FADA41, #F9D740, #F9D53E, #F8D23C, #F8D03A, #F7CD38, #F7CA36, #F6C734, #F6C532, #F5C230, #F5BF2E, #F4BC2C, #F4B92A, #F4B628, #F3B326, #F3B024, #F2AD22, #F2AB20, #F1A81E, #F1A51C, #F0A21A, #F0A018, #EF9D16, #EF9B14, #EE9813, #EE9611, #EE940F, #ED910E, #ED8F0C, #ED8D0B, #EC8B0A, #EC8A08, #EC8807, #EB8606, #EB8505, #EB8404, #EB8203, #EB8102, #EA8102, #EA8001, #EA7F01, #EA7F00, #EA7E00, #EA7E00, #EA7E00, #EA7E00, #EA7E00, #EA7E00, #EA7D00, #EA7D00, #EA7C00, #EA7B00, #EA7B00, #EA7A00, #EA7900, #EA7800, #EA7700, #EA7500, #EA7400, #EA7300, #EA7100, #EA7000, #EA6E00, #EA6C00, #EA6A00, #EA6900, #EA6700, #EA6500, #EA6300, #EA6100, #EA5F00, #EA5D00, #EA5B00, #EA5800, #EA5600, #EA5400, #EA5200, #EA5000, #EA4E00, #EA4C00, #EA4900, #EA4700, #EA4500, #EA4300, #EA4100, #EA3F00, #EA3D00, #EA3B00, #EA3A00, #EA3800, #EA3600, #EA3400, #EA3300, #EA3100, #EA3000, #EA2F00, #EA2D00, #EA2C00, #EA2B00, #EA2A00, #EA2900, #EA2900, #EA2800, #EA2700, #EA2700, #EA2600, #EA2600, #EA2600};
ArrayList<color []> colorList;

void setup() {
  size(768, 768);

  // List all the available serial ports:
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[5], 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  myString = myPort.readStringUntil(lf);
  myString = null;

  colorList = new ArrayList<color []>();
}

void draw() {
  //noStroke();
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil(lf);
    if (myString != null) {
      //print(myString);
      String[] list = myString.split("\t", -1);

      int fftBufferSize = list.length-1;
      
      int factor = width/fftBufferSize;
      
      color[] col = new color[fftBufferSize];

      for (int i = 0; i < fftBufferSize; ++i) {
        if ("".equals(list[i])) list[i] = null;
        if (list[i] != null) {
          int val = Integer.parseInt(list[i]);
          col[i] = colors[val];
        }
      }

      colorList.add(0, col);

      // contain the size of colorList just off of the frame
      if (colorList.size() >= fftBufferSize+1)
        colorList.remove(fftBufferSize);

      //y
      for (int y = 0; y < colorList.size(); y++) {
        //x
        color[] c = colorList.get(y);
        for (int x = 0; x < c.length; x++) {
          fill(c[x]);
          rect(x*factor, y*factor, factor, factor);
        }
      }
    }
  }
}
