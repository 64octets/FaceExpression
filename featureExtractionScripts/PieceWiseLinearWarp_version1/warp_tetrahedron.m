function J=warp_tetrahedron(I,xyz,uvw,ImageSize)
%
%  I = rand(512,512,512);
%  %load('testdata');
%  I=single(I);
%  uvw=[1 1                1;
%      1 size(I,2)         1;
%      size(I,1) 1         1;
%      size(I,1) size(I,2) 1;
%      1 1                 size(I,3);
%      1 size(I,2)         size(I,3);
%      size(I,1) 1         size(I,3);
%      size(I,1) size(I,2) size(I,3)];
%  xyz=[(uvw(:,2)+uvw(:,1))/1.5-32 (uvw(:,2)-uvw(:,1))/1.5+32 uvw(:,3)]; 
%  %xyz=uvw(:,[2 1 3]);
%  ImageSize=[512 512 512];
%  tic
%  J = warp_tetrahedron(I,xyz,uvw,ImageSize);
%  toc
%  showcs3(J)
%    
% Function is written by D.Kroon University of Twente (July 2011)

xyz=xyz(:,[2 1 3]);
uvw=uvw(:,[2 1 3]);

if(nargin<4), ImageSize=[size(I,1) size(I,2) size(I,3)]; end
    
tetra= delaunayn(double(xyz),{'Qt','Qbb','Qc','Qz'});

classI=class(I);
if(~(strcmpi(classI,'double')||strcmpi(classI,'single')))
    I=single(I);
end
J=warp_tetrahedron_double(I,double(xyz),double(uvw),double(tetra),double(ImageSize));
if(~(strcmpi(classI,'double')||strcmpi(classI,'single')))
    J=cast(J,classI);
end



 