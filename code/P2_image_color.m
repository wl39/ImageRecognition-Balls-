clc; clear;
fontSize = 20;

rgb = imread("../source_files/very_easy.jpg");




lab = applycform(rgb, makecform('srgb2lab'));
lab = lab2double(lab);
a = lab(:,:,2);
b = lab(:,:,3);

N = 101;
bin_centers = linspace(-100, 100, N);

subscripts = 1:N;
ai = interp1(bin_centers, subscripts, a, 'linear', 'extrap');
bi = interp1(bin_centers, subscripts, b, 'linear', 'extrap');


ai = round(ai);
bi = round(bi);

ai = max(min(ai, N), 1);
bi = max(min(bi, N), 1);

H = accumarray([bi(:), ai(:)], 1, [N N]);
% figure
imshow(H, [])


% figure
imshow(H, [0 1000], 'InitialMagnification', 300)

xdata = [min(bin_centers), max(bin_centers)];
ydata = xdata;

% figure
imshow(H,[0 1000], 'InitialMagnification', 300, 'XData', xdata, 'YData', ydata)

axis on
xlabel('a*')
ylabel('b*')

mask = H > 100;

% figure
imshow(mask, 'InitialMagnification', 300, 'XData', [-100 100], ...
    'YData', [-100 100])
axis on

props = regionprops(mask, H, 'Centroid');
props(1)

centersRed = cat(1, props.Centroid);
ab_centers = 2*centersRed - 102;

a_centers = ab_centers(:,1);
b_centers = ab_centers(:,2);

hold on
voronoi(a_centers, b_centers, 'r')
hold off

dt = DelaunayTri(a_centers, b_centers)






rgbA = imread("../source_files/very_hard.jpg");
% figure
imshow(rgbA)
rgb = imsharpen(rgbA);


lab = lab2double(applycform(rgb, makecform('srgb2lab')));
L = lab(:,:,1);
a = lab(:,:,2);
b = lab(:,:,3);

X = nearestNeighbor(dt, a(:), b(:));
X = reshape(X, size(a));

L_mean = zeros(size(a_centers));
for k = 1:numel(L_mean)
    L_mean(k) = mean(L(X == k));
end


map = applycform([L_mean, a_centers, b_centers], makecform('lab2srgb'));

close all
% figure
imshow(X, map)


XRed = X(:,:);
XRed(X~=5) = 4;

XYellow = X(:,:);
XYellow(X~=3) = 4;

XBlue = X(:,:);
XBlue(X~=2) = 4;

XGreen = X(:,:);
XGreen(X~=1) = 4;







%  ReD
rgbRed = ind2rgb(XRed,map);
% figure
imshow(rgbRed);
IRed = rgb2gray(rgbRed);
% figure
imshow(IRed)

IRed=im2bw(IRed,graythresh(IRed));

seRed = strel('disk',15);
IoRed = imopen(IRed,seRed);
% figure
imshow(IoRed)
title('Opening')

IeRed = imerode(IRed,seRed);
IobrRed = imreconstruct(IeRed,IRed);
% figure
imshow(IobrRed)
title('Opening-by-Reconstruction')


IocRed = imclose(IoRed,seRed);
% figure
imshow(IocRed)

title('Opening-Closing')

IobrdRed = imdilate(IobrRed,seRed);
IobrcbrRed = imreconstruct(imcomplement(IobrdRed),imcomplement(IobrRed));
IobrcbrRed = imcomplement(IobrcbrRed);
% figure
imshow(IobrcbrRed)
title('Opening-Closing by Reconstruction')


gmagRed = imgradient(IobrcbrRed);
% figure
imshow(gmagRed,[])


% Yellow
rgbYellow = ind2rgb(XYellow,map);
% figure
imshow(rgbYellow);
IYellow = rgb2gray(rgbYellow);
% figure
imshow(IYellow)

IYellow=im2bw(IYellow,graythresh(IYellow));

seYellow = strel('disk',15);
IoYellow = imopen(IYellow,seYellow);
% figure
imshow(IoYellow)
title('Opening')

IeYellow = imerode(IYellow,seYellow);
IobrYellow = imreconstruct(IeYellow,IYellow);
% figure
imshow(IobrYellow)
title('Opening-by-Reconstruction')


IocYellow = imclose(IoYellow,seYellow);
% figure
imshow(IocYellow)

title('Opening-Closing')

IobrdYellow = imdilate(IobrYellow,seYellow);
IobrcbrYellow = imreconstruct(imcomplement(IobrdYellow),imcomplement(IobrYellow));
IobrcbrYellow = imcomplement(IobrcbrYellow);
% figure
imshow(IobrcbrYellow)
title('Opening-Closing by Reconstruction')

gmagYellow = imgradient(IobrcbrYellow);
% figure
imshow(gmagYellow,[])


%  Blue
rgbBlue = ind2rgb(XBlue,map);
% figure
imshow(rgbBlue);
IBlue = rgb2gray(rgbBlue);
% figure
imshow(IBlue)

IBlue=im2bw(IBlue,graythresh(IBlue));

seBlue = strel('disk',15);
IoBlue = imopen(IBlue,seBlue);
% figure
imshow(IoBlue)
title('Opening')

IeBlue = imerode(IBlue,seBlue);
IobrBlue = imreconstruct(IeBlue,IBlue);
% figure
imshow(IobrBlue)
title('Opening-by-Reconstruction')


IocBlue = imclose(IoBlue,seBlue);
% figure
imshow(IocBlue)

title('Opening-Closing')

IobrdBlue = imdilate(IobrBlue,seBlue);
IobrcbrBlue = imreconstruct(imcomplement(IobrdBlue),imcomplement(IobrBlue));
IobrcbrBlue = imcomplement(IobrcbrBlue);
% figure
imshow(IobrcbrBlue)
title('Opening-Closing by Reconstruction')


gmagBlue = imgradient(IobrcbrBlue);
% figure
imshow(gmagBlue,[])



%  Green
rgbGreen = ind2rgb(XGreen,map);
% figure
imshow(rgbGreen);
IGreen = rgb2gray(rgbGreen);
% figure
imshow(IGreen)

IGreen=im2bw(IGreen,graythresh(IGreen));

seGreen = strel('disk',15);
IoGreen = imopen(IGreen,seGreen);
% figure
imshow(IoGreen)
title('Opening')

IeGreen = imerode(IGreen,seGreen);
IobrGreen = imreconstruct(IeGreen,IGreen);
% figure
imshow(IobrGreen)
title('Opening-by-Reconstruction')


IocGreen = imclose(IoGreen,seGreen);
% figure
imshow(IocGreen)

title('Opening-Closing')

IobrdGreen = imdilate(IobrGreen,seGreen);
IobrcbrGreen = imreconstruct(imcomplement(IobrdGreen),imcomplement(IobrGreen));
IobrcbrGreen = imcomplement(IobrcbrGreen);
% figure
imshow(IobrcbrGreen)
title('Opening-Closing by Reconstruction')


gmagGreen = imgradient(IobrcbrGreen);
% figure
imshow(gmagGreen,[])


% L = watershed(gmagYellow);
% Lrgb = label2rgb(L);
% imshow(Lrgb)

[centersRed, radiiRed] = imfindcircles(gmagRed,[20 100],Sensitivity=0.9535, EdgeThreshold=0.2);

TFRed = isoutlier(radiiRed); % removing outliers
kRed = find(TFRed);
centersRed = removerows(centersRed,'ind',kRed);
radiiRed(kRed) = [];
size(centersRed)


[centersYellow, radiiYellow] = imfindcircles(gmagYellow,[20 100],Sensitivity=0.9535, EdgeThreshold=0.2);

TFYellow = isoutlier(radiiYellow); % removing outliers
kYellow = find(TFYellow);
centersYellow = removerows(centersYellow,'ind',kYellow);
radiiYellow(kYellow) = [];
size(centersYellow)


[centersBlue, radiiBlue] = imfindcircles(gmagBlue,[20 100],Sensitivity=0.9535, EdgeThreshold=0.2);

TFBlue = isoutlier(radiiBlue); % removing outliers
kBlue = find(TFBlue);
centersBlue = removerows(centersBlue,'ind',kBlue);
radiiBlue(kBlue) = [];
size(centersBlue)


[centersGreen, radiiGreen] = imfindcircles(gmagGreen,[20 100],Sensitivity=0.9535, EdgeThreshold=0.2);

TFGreen = isoutlier(radiiGreen); % removing outliers
kGreen = find(TFGreen);
centersGreen = removerows(centersGreen,'ind',kGreen);
radiiGreen(kGreen) = [];
size(centersGreen)

% figure
imshow(rgbA)
text(10,30,strcat('\color{green}Objects Found:',num2str(length(radiiRed) + length(radiiYellow) + length(radiiBlue) + length(radiiGreen))), "FontSize", 30)
text(10,80,strcat('\color{red}Objects Found:',num2str(length(radiiRed))), "FontSize", 30)
text(10,130,strcat('\color{yellow}Objects Found:',num2str(length(radiiYellow))), "FontSize", 30)
text(10,180,strcat('\color{blue}Objects Found:',num2str(length(radiiBlue))), "FontSize", 30)
text(10,230,strcat('\color{green}Objects Found:',num2str(length(radiiGreen))), "FontSize", 30)

hRed = viscircles(centersRed,radiiRed, 'Color', 'r');
hYellow = viscircles(centersYellow,radiiYellow, 'Color', 'y');
hBlue = viscircles(centersBlue,radiiBlue,'Color', 'b');
hGreen = viscircles(centersGreen,radiiGreen, 'Color', 'g');




