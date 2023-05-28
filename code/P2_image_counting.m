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

imshow(H, [])


figure
imshow(H, [0 1000], 'InitialMagnification', 300)

xdata = [min(bin_centers), max(bin_centers)];
ydata = xdata;

figure
imshow(H,[0 1000], 'InitialMagnification', 300, 'XData', xdata, 'YData', ydata)

axis on
xlabel('a*')
ylabel('b*')

mask = H > 100;


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
imshow(X, map)

X(X~=4) = 5;

%  ReD
rgb = ind2rgb(X,map);
imshow(rgb)

I = rgb2gray(rgb);
imshow(I)

I=im2bw(I,graythresh(I));



se = strel('disk',20);
Io = imopen(I,se);
imshow(Io)

Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);
imshow(Iobr)
% % 
% 
Ioc = imclose(Io,se);

imshow(Ioc)
title('Opening-Closing')

Iobrd = imdilate(Iobr,se);
Iobrcbr = imreconstruct(imcomplement(Iobr),imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);

imshow(Iobrcbr)
title('Opening-Closing by Reconstruction')
% 
% 
gmag = imgradient(Iobrcbr);
imshow(gmag,[])
% 
% 
[centers, radii] = imfindcircles(gmag,[20 100],Sensitivity=0.9535, EdgeThreshold=0.2);
TF = isoutlier(radii);
k = find(TF);
centers = removerows(centers,'ind',k);
radii(k) = [];
size(centers)
% 
imshow(rgbA)
text(10,30,strcat('\color{green}Objects Found:',num2str(length(radii))), "FontSize", 30)
% 
h = viscircles(centers,radii, 'Color', 'r');




