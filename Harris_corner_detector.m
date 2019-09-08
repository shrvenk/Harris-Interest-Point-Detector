clear all;
img = imread('demo2.jpg');
img = rgb2gray(img);
Ix = imfilter(img,[-1,1],'corr','same');
Iy = imfilter(img,[-1,1]','corr','same');
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;
G = fspecial('gaussian',[10,10],1);
Ix2 = conv2(Ix2,G,'same');
Iy2 = conv2(Iy2,G,'same');
Ixy = conv2(Ixy,G,'same');
[x,y]=size(img);
result = zeros([x,y]);
for i = 2:x-1
    for j = 2:y-1
        A = [Ix2(i,j),Ixy(i,j);Ixy(i,j),Iy2(i,j)];
        Eig = eig(A);
        E1(i,j)=Eig(1);
        E2(i,j)=Eig(2);
        k=1/13;
        R = (abs(Eig(1))*abs(Eig(2)))-(k*(abs(Eig(1))+abs(Eig(2)))^2);
        if(R<0 && img(i,j)>img(i,j-1) && img(i,j) > img(i,j+1) && img(i,j) > img(i+1,j) && img(i,j) > img(i-1,j) )
            result(i,j)=255;
        end
    end
end
imshow(uint8(result));
        
        
