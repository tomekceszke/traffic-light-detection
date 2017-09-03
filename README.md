# Traffic Light Detection
Real time traffic light color detection using Machine Learning. 
Written in pure Matlab using only basic matrix operations.

* Classification method: Logistic Regression
* Optimization: Gradient Descent 

[![Proof of concept](doc/img/poc.gif)](https://youtu.be/UsOpVFIdO-A)

## Note
- *Written only for educational purposes*
- *Intentionally written in pure Matlab language, using only basic mathematics operations*


## Training samples
![samples](doc/img/training_samples.jpg)


## Training efficiency
![red_sample](doc/img/min.jpg)


## Run
### Learn (optional)
* collect some training samples using [bin/collectSamples.bat](bin/collectSamples.bat)
* then put them to the respective directories under datasource/train/
* run [learn.m](learn.m) script in Matlab/Octave

### Test (optional)
* collect some test samples using [bin/collectSamples.bat](bin/collectSamples.bat)
* then put them to the respective directories under datasource/test/
* run [check.m](test.m) script

### Detect
* open live stream using [bin/startStream.bat](bin/startStream.bat) 
* run [detect.m](detect.m) script


### Requirements
* [VLC](http://www.videolan.org)
* [Octave](https://www.gnu.org/software/octave)



