clc;
clear all;
Fs = 10000 ; 
p = 13;
numberofBits = 16 ; 
numberofChannels = 1 ; 
audio = audiorecorder(Fs,numberofBits,numberofChannels);
disp('Start speaking')
pause(0.4)
recordblocking(audio,5); % the no '5' has to be changed accordin to the length of your auido message
b=getaudiodata(audio);
disp('The audio has been recorded');
filename= 'audio.wav';
audiowrite(filename,b,Fs)
[y,Fs] = audioread('audio.wav');
sound(y,Fs);