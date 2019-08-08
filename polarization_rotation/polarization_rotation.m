% check which way Delta x and xbar should be

[X1,X2]=meshgrid(x,x);

Xbar0=(X1+X2)/2;

DeltaX0=X2-X1;

Delta_x=linspace(-3,3,300);
xbar=linspace(-3,3,300);

[Xbar,DeltaX]=meshgrid(Delta_x,xbar);

% MUrot=griddata(Xbar0,DeltaX0,MU,Xbar,DeltaX,'nearest');
MUrot=griddata(Xbar0,DeltaX0,MU,Xbar,DeltaX);


figure
subplot(1,2,1)
imagesc(x,x,abs(MU))
subplot(1,2,2)
imagesc(Delta_x,xbar,abs(MUrot))

