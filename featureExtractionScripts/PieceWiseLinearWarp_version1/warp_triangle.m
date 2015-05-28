function J=warp_triangle(I,xy,uv,ImageSize)
%
%  I = im2double(imread('lena.bmp'));
%
%  xy=[1 1;1 size(I,2);size(I,1) 1;size(I,1) size(I,2)];
%  uv=[256 512; 1 256; 512  256; 256 1];
%
%  ImageSize=[512 512];
%  J = warp_triangle(I,xy,uv,ImageSize);
%  figure,
%  subplot(2,2,1), imshow(I)
%  subplot(2,2,2), imshow(J)
%
%  %trans_prj = cp2tform(xy,uv,'piecewise linear');
%  %Jn = imtransform(I,trans_prj,'bicubic','Xdata',[1 ImageSize(1)],'YData',[1 ImageSize(2)],'XYscale',1);
%  %Jn(isnan(Jn))=0;
%    
% Function is written by D.Kroon University of Twente (July 2011)

xy=xy(:,[2 1]);
uv=uv(:,[2 1]);

if(nargin<4), ImageSize=[size(I,1) size(I,2)]; end
    
tri = delaunay(xy(:,1),xy(:,2));

classI=class(I);
if(~strcmpi(classI,'double'))
    I=double(I);
end
J=warp_triangle_double(I,double(xy),double(uv),double(tri),double(ImageSize));
if(~(strcmpi(classI,'double')||strcmpi(classI,'single')))
    J=cast(J,classI);
end

