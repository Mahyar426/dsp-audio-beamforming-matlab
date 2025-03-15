function latency = takhir(xm,ym,zm,c,phi,teta)
phirad=phi*pi/180;
tetarad=teta*pi/180;
latency = ((xm*sin(tetarad)*cos(phirad))+(ym*sin(tetarad)*sin(phirad))+(zm*cos(tetarad)))/(c); 
end