%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% This programs contains a pre-recorded audio file for use if u wish to   %
%                                                                         %
% change the sudio message then please feel free to run the               %
% Personal_message.m file before runing this file and make sure to use the%
% appropriate lenght for the voice message.                               %
%                                                                         %
%In the version1.m you can edit this file to either run indefinately or   %
%please follow the instructions if u want this to only run and detect only%
%once and also finds the center of the moved object.                      %
%                                                                         %
% in the upcoming version would add object detection to notify if u had   %
% been to grocery shop ten to wash veggies or anything that is washable   %
% before storing it.                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
close all;
clear;
while 1 % remove this While loop if u want the system to stop after it has detected the moving object once
clc;
%close all;
clear;
y=1;
x=videoinput('winvideo',1);
while y==1
    close all;
    %Read Background Image
    
    image=getsnapshot(x);
    imwrite(image,'background_mod1.jpg');
    pause(.3);
    image=getsnapshot(x);
    imwrite(image,'current.jpg');
    %Read Background Image
    Background=imread('background_mod1.jpg');
    %Read Current Frame
    CurrentFrame=imread('current.jpg'); 
    %Display Background and Foreground
    subplot(2,2,1);imshow(Background);title('BackGround');
    subplot(2,2,2);imshow(CurrentFrame);title('current frame');
    %Convert RGB 2 gray
    [Background_gray]=rgb2gray(Background);
    [CurrentFrame_gray]=rgb2gray(CurrentFrame);
    test_gray = imsubtract(CurrentFrame_gray,Background_gray);
    %imtool(test_gray);
    %subplot(2,2,3);imshow(test_gray);title('mmoving object');
    subplot(2,2,4);imshow(CurrentFrame_gray);title('current frame');
    [ii , jj]=find(test_gray>35); %threshold of how sensitive you want the system to be in dark areas
    %CurrentFrame(ii,jj,:)=0;
    m= max(test_gray);
    n=max(m);
    if n >= 35
    
        y=0;
    
    end
end

%ii_avg = floor((max(ii) + min(ii))/2);
%jj_avg = floor((max(jj) + min(jj))/2);

ii_avg = floor(median(ii));
jj_avg = floor(median(jj));


cross_ii = [(ii_avg -15):1:ii_avg:1:(ii_avg + 15)]; % lenght of horizontal line
cross_ii_width = [(jj_avg -3):1:jj_avg:1:(jj_avg + 3)]; %width of horizontal line

cross_jj = [(jj_avg -15):1:jj_avg:1:(jj_avg + 15)]; % lenght of vertical line
cross_jj_width = [(ii_avg -3):1:ii_avg:1:(ii_avg + 3)]; %width of vertical line

CurrentFrame(cross_ii,cross_ii_width,1)=255; %Plot horizontal line
CurrentFrame(cross_ii,cross_ii_width,2)=0; %Plot horizontal line
CurrentFrame(cross_ii,cross_ii_width,3)=0; %Plot horizontal line

CurrentFrame(cross_jj_width,cross_jj,1)=255; %Plot vertical line.
CurrentFrame(cross_jj_width,cross_jj,2)=0; %Plot vertical line.
CurrentFrame(cross_jj_width,cross_jj,3)=0; %Plot vertical line.

subplot(2,2,3);imshow(CurrentFrame);title('moving object');
pause(2)
[y,Fs] = audioread('audio.wav');
sound(y,Fs);
pause(5) % change this pause according to your personal voice message.
%imtool(CurrentFrame);

end
